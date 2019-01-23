<?php
class ControllerExtensionModuleCategoryacc extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/categoryacc');

		$this->document->setTitle($this->language->get('heading_title_big'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('categoryacc', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['heading_title_big'] = $this->language->get('heading_title_big');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title_big'),
			'href' => $this->url->link('extension/module/categoryacc', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/categoryacc', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['categoryacc_status'])) {
			$data['categoryacc_status'] = $this->request->post['categoryacc_status'];
		} else {
			$data['categoryacc_status'] = $this->config->get('categoryacc_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/categoryacc', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/categoryacc')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}