<?php
class ControllerCatalogLMCfilter extends Controller {
	private $error = array();

	public function add_price() {
		$this->load->language('catalog/LMCfilter');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/LMCfilter');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm_price()) {
            
			$this->model_catalog_LMCfilter->addFilter_price($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, true));

		}

		$this->getForm_price();
	}

	public function edit_price() {
		$this->load->language('catalog/LMCfilter');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/LMCfilter');
		$this->load->model('catalog/filter');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm_price()) {
			$this->model_catalog_LMCfilter->editFilter_price($this->request->get['filter_group_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm_price();
	}

	protected function getForm_price() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['filter_group_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$data['entry_group'] = $this->language->get('entry_group');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $data['entry_price_auto'] = $this->language->get('entry_price_auto');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['entry_min_price'] = $this->language->get('entry_min_price');
        $data['entry_max_price'] = $this->language->get('entry_max_price');
        $data['entry_step'] = $this->language->get('entry_step');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_filter_add'] = $this->language->get('button_filter_add');
		$data['button_remove'] = $this->language->get('button_remove');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['group'])) {
			$data['error_group'] = $this->error['group'];
		} else {
			$data['error_group'] = array();
		}

		if (isset($this->error['filter'])) {
			$data['error_filter'] = $this->error['filter'];
		} else {
			$data['error_filter'] = array();
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['filter_group_id'])) {
			$data['action'] = $this->url->link('catalog/LMCfilter/add_price', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/LMCfilter/edit_price', 'token=' . $this->session->data['token'] . '&filter_group_id=' . $this->request->get['filter_group_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['filter_group_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$filter_group_info = $this->model_catalog_filter->getFilterGroup($this->request->get['filter_group_id']);
            $filter_group_info['LMCfilter_data'] = json_decode($filter_group_info['LMCfilter_data'], true);
            $filter_group_info['LMCfilter_data']['min_price'] = isset($filter_group_info['LMCfilter_data']['min_price']) ? $filter_group_info['LMCfilter_data']['min_price'] : '';
            $filter_group_info['LMCfilter_data']['max_price'] = isset($filter_group_info['LMCfilter_data']['max_price']) ? $filter_group_info['LMCfilter_data']['max_price'] : '';
            $filter_group_info['LMCfilter_data']['step'] = isset($filter_group_info['LMCfilter_data']['step']) ? $filter_group_info['LMCfilter_data']['step'] : '';
		}
        

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['filter_group_description'])) {
			$data['filter_group_description'] = $this->request->post['filter_group_description'];
		} elseif (isset($this->request->get['filter_group_id'])) {
			$data['filter_group_description'] = $this->model_catalog_filter->getFilterGroupDescriptions($this->request->get['filter_group_id']);
		} else {
			$data['filter_group_description'] = array();
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($filter_group_info)) {
			$data['sort_order'] = $filter_group_info['sort_order'];
		} else {
			$data['sort_order'] = '';
		}
        
		if (isset($this->request->post['price_auto'])) {
			$data['price_auto'] = $this->request->post['price_auto'];
		} elseif (!empty($filter_group_info)) {
			$data['price_auto'] = isset($filter_group_info['LMCfilter_data']['price_auto']) ? $filter_group_info['LMCfilter_data']['price_auto'] : 0;
		} else {
			$data['price_auto'] = 0;
		}
        
		if (isset($this->request->post['min_price'])) {
			$data['min_price'] = $this->request->post['min_price'];
		} elseif (!empty($filter_group_info)) {
			$data['min_price'] = $filter_group_info['LMCfilter_data']['min_price'];
		} else {
			$data['min_price'] = '';
		}
        
		if (isset($this->request->post['max_price'])) {
			$data['max_price'] = $this->request->post['max_price'];
		} elseif (!empty($filter_group_info)) {
			$data['max_price'] = $filter_group_info['LMCfilter_data']['max_price'];
		} else {
			$data['max_price'] = '';
		}
        
		if (isset($this->request->post['step'])) {
			$data['step'] = $this->request->post['step'];
		} elseif (!empty($filter_group_info)) {
			$data['step'] = $filter_group_info['LMCfilter_data']['step'];
		} else {
			$data['step'] = '';
		}

		if (isset($this->request->post['filter'])) {
			$data['filters'] = $this->request->post['filter'];
		} elseif (isset($this->request->get['filter_group_id'])) {
			$data['filters'] = $this->model_catalog_filter->getFilterDescriptions($this->request->get['filter_group_id']);
		} else {
			$data['filters'] = array();
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/LMCfilter_price_form', $data));
	}

	protected function validateForm_price() {
		if (!$this->user->hasPermission('modify', 'catalog/LMCfilter')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['filter_group_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 1) || (utf8_strlen($value['name']) > 64)) {
				$this->error['group'][$language_id] = $this->language->get('error_group');
			}
		}

		return !$this->error;
	}

}
