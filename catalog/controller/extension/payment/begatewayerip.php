<?php
class ControllerExtensionPaymentBegatewayErip extends Controller {

  public function index() {
    $this->language->load('extension/payment/begatewayerip');
    $this->load->model('checkout/order');
    $data['text_wait'] = $this->language->get('text_wait');
    $data['text_loading'] = $this->language->get('text_loading');
    $data['button_confirm'] = $this->language->get('button_confirm');

    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . 'extension/payment/begatewayerip.tpl')) {
      return $this->load->view($this->config->get('config_template') . 'extension/payment/begatewayerip.tpl', $data);
    } else {
      return $this->load->view('extension/payment/begatewayerip.tpl', $data);
    }
  }

  public function send() {
    $this->language->load('extension/payment/begatewayerip');

    $json = array();
    $json['text_thankyou'] = $this->language->get('text_thankyou');
    $json['success_url'] = $this->url->link('checkout/success', '', 'SSL');
    $json['button_continue'] = $this->language->get('button_continue');

    $token = $this->generateToken();

    if ($token == false || !isset($token['transaction'])) {
      $json['error'] = $this->language->get('token_error');
    } else {
      $json['instruction'] = sprintf($this->language->get('text_erip_instruction'),
        $token['transaction']['order_id'],
        implode(' ', $token['transaction']['erip']['instruction']),
        $token['transaction']['order_id']
      );
      $json['instruction'] = str_replace(PHP_EOL, "<br>", $json['instruction']);
      $this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('config_order_status_id'));
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function generateToken(){

    $this->load->model('checkout/order');
    $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
    $orderAmount = $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'], false);
    $orderAmount = (float)$orderAmount * pow(10,(int)$this->currency->getDecimalPlace($order_info['currency_code']));
    $orderAmount = intval(strval($orderAmount));
    $callback_url = $this->url->link('extension/payment/begatewayerip/callback', '', 'SSL');
    $callback_url = str_replace('carts.local', 'webhook.begateway.com:8443', $callback_url);
    $description = sprintf($this->language->get('text_service_info'), $order_info['order_id']);

    $order_array = array (
      'currency'=> $order_info['currency_code'],
      'amount' => $orderAmount,
      'description' => $description,
      'order_id' => $order_info['order_id'],
      'email' => $order_info['email'],
      'ip' => $_SERVER['REMOTE_ADDR'],
      'notification_url'=> $callback_url,
      'payment_method' => array(
        'type' => 'erip',
        'account_number' => $order_info['order_id'],
        'service_no' => $this->config->get('begatewayerip_service_no'),
        'service_info' => array(
          $description
        )
      )
    );

    $token_json =  array('request' => $order_array );

    $this->load->model('checkout/order');

    $post_string = json_encode($token_json);

    $username=$this->config->get('begatewayerip_companyid');
    $password=$this->config->get('begatewayerip_encryptionkey');

    $curl = curl_init('https://' . $this->config->get('begatewayerip_domain_api') . '/beyag/payments');
    curl_setopt($curl, CURLOPT_PORT, 443);
    curl_setopt($curl, CURLOPT_HEADER, 0);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_HTTPHEADER, array(
      'Content-Type: application/json',
      'Content-Length: '.strlen($post_string))) ;
    curl_setopt($curl, CURLOPT_FORBID_REUSE, 1);
    curl_setopt($curl, CURLOPT_FRESH_CONNECT, 1);
    curl_setopt($curl, CURLOPT_POST, 1);
    curl_setopt($curl, CURLOPT_USERPWD, "$username:$password");
    curl_setopt($curl, CURLOPT_POSTFIELDS, $post_string);

    $response = curl_exec($curl);

    if (!$response) {
      $this->log->write('ERIP request failed: ' . curl_error($curl) . '(' . curl_errno($curl) . ')');
      curl_close($curl);
      return false;
    }

    curl_close($curl);

    $token = json_decode($response,true);

    if ($token == NULL) {
      $this->log->write("ERIP response parse error: $response");
      return false;
    }

    if (isset($token['errors'])) {
      $this->log->write("ERIP request errors: $response");
      return false;
    }

    if (isset($token['transaction']) && isset($token['transaction']['status'])
        && $token['transaction']['status'] == 'pending' ) {
      return $token;
    } else {
      $this->log->write("No payment token in response: $response");
      return false;
    }
  }

  public function callback() {

    $this->language->load('extension/payment/begatewayerip');

    $postData =  (string)file_get_contents("php://input");

    $post_array = json_decode($postData, true);
    $this->_set_auth_data();

    $order_id = $post_array['transaction']['tracking_id'];
    $status = $post_array['transaction']['status'];

    $transaction_id = $post_array['transaction']['uid'];
    $transaction_message = $post_array['transaction']['message'];

    $this->log->write("Webhook received: $postData");

    $this->load->model('checkout/order');

    $order_info = $this->model_checkout_order->getOrder($order_id);
    if ($this->is_authorized() && $order_info) {
      if(isset($status) && $status == 'successful'){
        $message = $this->language->get('text_transaction_id') . ' ' . $transaction_id;
        $message .= PHP_EOL;
        $message .= $this->language->get('text_processor_message') . ' ' . $transaction_message;

        $this->model_checkout_order->addOrderHistory((int)$order_id, $this->config->get('begatewayerip_completed_status_id'), $message, false);
      }
    }
  }

  protected function is_authorized() {
    $username=$this->config->get('begatewayerip_companyid');
    $password=$this->config->get('begatewayerip_encryptionkey');
    if (isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW'])) {
      return $_SERVER['PHP_AUTH_USER'] == $username &&
             $_SERVER['PHP_AUTH_PW'] == $password;
    }

    return false;
  }

  protected function _set_auth_data() {
    if(preg_match('/Basic+(.*)$/i', $_SERVER['REDIRECT_HTTP_AUTHORIZATION'], $matches)) {
      $_SERVER['HTTP_AUTHORIZATION'] = $_SERVER['REDIRECT_HTTP_AUTHORIZATION'];
      list($_SERVER['PHP_AUTH_USER'], $_SERVER['PHP_AUTH_PW']) = explode(':' , base64_decode(substr($_SERVER['HTTP_AUTHORIZATION'], 6)));
    }
  }
}
?>
