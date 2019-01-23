<?php
class ControllerErrorNotFound extends Controller {
	public function index() {
		$this->load->language('error/not_found');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['route'])) {
			$url_data = $this->request->get;

			unset($url_data['_route_']);

			$route = $url_data['route'];

			unset($url_data['route']);

			$url = '';

			if ($url_data) {
				$url = '&' . urldecode(http_build_query($url_data, '', '&'));
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link($route, $url, $this->request->server['HTTPS'])
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_error'] = $this->language->get('text_error');

		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		
			/* Ocmod filter */
			if (strpos($this->request->server['REQUEST_URI'], "gofilter/") === false) {$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');}
			/* Ocmod filter */
            

		
			/* Ocmod filter */
			if (strpos($this->request->server['REQUEST_URI'], "gofilter/") !== false) {
				$massivs = explode('/', (string)$this->request->server['REQUEST_URI']);
				foreach ($massivs as $key => $value) {
					if ($value == "gofilter") {
						$key_route = $key + 1;
					}
				}
				if (isset($key_route)) {
					$massivs_route = explode('-', $massivs[$key_route]);
					$text_route = $massivs_route[0] . "/" . $massivs_route[1];
				}
				$filter_array = array();
				$seo_separator = "=";
				$this->load->model('extension/module/gofilter');
                $seo_separator = $this->model_extension_module_gofilter->getGenerationSeparator();
				foreach ($massivs as $key => $value) {
					if ($key >= $key_route) {
						$massiv = explode($seo_separator, $value);
						$key_shift = array_shift($massiv);
						$id = 0; foreach ($massiv as $value_2) {
							$filter_array[$key_shift][] = $value_2;
						}
					}
				}
				if($filter_array) {
					$data['seo_results'] = $this->model_extension_module_gofilter->getSeoElements($filter_array);
				} else {
					$data['seo_results'] = false;
				}
				$this->request->get['route'] = $text_route;
				
				if (isset($data['seo_results']['category_id'])) {$this->request->get['path'] = $data['seo_results']['category_id'];}
				$this->load->controller($text_route);
			} else {
				$this->response->setOutput($this->load->view('error/not_found', $data));
			}
			/* Ocmod filter */
            
	}
}