<?php
class ControllerExtensionModuleGofilter extends Controller {
	private $error = array();
	
	public function index() {
		
		$this->load->language('extension/module/gofilter');
			
		$data['protection'] = $this->language->get('protection');
		$data['help_protection'] = $this->language->get('help_protection');
		$data['help_cod_protection'] = $this->language->get('help_cod_protection');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		if ($this->config->get('gofilter_code_protection')) {
			$this->document->setTitle($this->language->get('heading_title_title'));
			$data['heading_title_title'] = $this->language->get('heading_title_title');
			$data['heading_title'] = $this->language->get('heading_title');
		} else {
			$this->document->setTitle($this->language->get('heading_title_title_activat'));
			$data['heading_title_title'] = $this->language->get('heading_title_title_activat');
			$data['heading_title'] = $this->language->get('heading_title_activat');
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['action'] = $this->url->link('extension/module/gofilter', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('setting/setting');

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		if ($this->config->get('gofilter_code_protection')) {
			$data['code_protection'] = $this->config->get('gofilter_code_protection');
		} else {
			$data['code_protection'] = false;
		}
		
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
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/gofilter', 'token=' . $this->session->data['token'], true)
		);
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		
		
		
		if ($this->config->get('gofilter_code_protection')) {
			if (isset($this->request->post['gofilter_code_protection'])) {
				
				if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
					$this->model_setting_setting->editSetting('gofilter', $this->request->post);

					$this->session->data['success'] = $this->language->get('text_success_code');
					
					$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
					
				}
				
				if (isset($this->request->post['gofilter_code_protection'])) {
					$data['gofilter_code_protection'] = $this->request->post['gofilter_code_protection'];
				} else {
					if ($this->config->get('gofilter_code_protection')) {
						$data['gofilter_code_protection'] = $this->config->get('gofilter_code_protection');
					} else {
						$data['gofilter_code_protection'] = false;
					}
				}
				if (isset($this->request->post['gofilter_status'])) {
					$data['gofilter_status'] = $this->request->post['gofilter_status'];
				} else {
					$data['gofilter_status'] = $this->config->get('gofilter_status');
				}

			}
			
			
			$this->success();
			
		} else {
			if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
				$this->model_setting_setting->editSetting('gofilter', $this->request->post);

				$this->session->data['success'] = $this->language->get('text_success_code');
				
				$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
				
			}
			
			if (isset($this->request->post['gofilter_code_protection'])) {
				$data['gofilter_code_protection'] = $this->request->post['gofilter_code_protection'];
			} else {
				if ($this->config->get('gofilter_code_protection')) {
					$data['gofilter_code_protection'] = $this->config->get('gofilter_code_protection');
				} else {
					$data['gofilter_code_protection'] = false;
				}
			}
			if (isset($this->request->post['gofilter_status'])) {
				$data['gofilter_status'] = $this->request->post['gofilter_status'];
			} else {
				$data['gofilter_status'] = $this->config->get('gofilter_status');
			}
			
			$this->response->setOutput($this->load->view('extension/module/gofilter.tpl', $data));
		}
		
	}

	public function success() {

		$this->document->addStyle('view/javascript/gofilter/bootstrap-switch.min.css');
		$this->document->addStyle('view/javascript/gofilter/highlight.css');
		$this->document->addStyle('view/stylesheet/gofilter/main.css');
		$this->document->addScript('view/javascript/gofilter/bootstrap-switch.min.js');
		$this->document->addScript('view/javascript/gofilter/highlight.js');
		$this->document->addScript('view/javascript/gofilter/main.js');
		
		$this->document->addStyle('view/stylesheet/gofilter/gofilter.css');
		
		$this->document->addScript('view/javascript/gofilter/jscolor/jscolor.js');
	
		$this->load->language('extension/module/gofilter');
		
		$data['protection'] = $this->language->get('protection');
		$data['help_protection'] = $this->language->get('help_protection');
		$data['help_cod_protection'] = $this->language->get('help_cod_protection');
		
		if ($this->config->get('gofilter_code_protection')) {
			$data['code_protection'] = $this->config->get('gofilter_code_protection');
		} else {
			$data['code_protection'] = false;
		}
		
		$data['token']  = $this->session->data['token'];
		$data['delete_cache'] = str_replace('&amp;', '&', $this->url->link('extension/module/gofilter/removecache', 'token=' . $this->session->data['token'], 'SSL'));
		$data['delete_garbage'] = str_replace('&amp;', '&', $this->url->link('extension/module/gofilter/delete_garbage', 'token=' . $this->session->data['token'], 'SSL'));

		$this->document->setTitle($this->language->get('heading_title_title'));
		$data['heading_title'] = $this->language->get('heading_title');
		
		$this->load->model('extension/module/gofilter');
		
		$this->model_extension_module_gofilter->createGofilter('gofilter');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_extension_module_gofilter->editGofilter('gofilter', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		
		$data['entry_name'] = $this->language->get('entry_name');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['text_where'] = $this->language->get('text_where');
		$data['text_help_where'] = $this->language->get('text_help_where');
		$data['text_column'] = $this->language->get('text_column');
		$data['text_content'] = $this->language->get('text_content');
		
		$data['text_layout'] = $this->language->get('text_layout');
		$data['text_style'] = $this->language->get('text_style');
		$data['text_settings'] = $this->language->get('text_settings');
		$data['text_cache'] = $this->language->get('text_cache');
		$data['text_seo'] = $this->language->get('text_seo');
		$data['text_scripts'] = $this->language->get('text_scripts');
		$data['text_settings_layout'] = $this->language->get('text_settings_layout');
		$data['text_help_settings_layout'] = $this->language->get('text_help_settings_layout');
		$data['text_add_layout'] = $this->language->get('text_add_layout');
		$data['text_h3_filter'] = $this->language->get('text_h3_filter');
		$data['text_help_layout'] = $this->language->get('text_help_layout');
		$data['text_select_block'] = $this->language->get('text_select_block');
		$data['text_status_show'] = $this->language->get('text_status_show');
		$data['text_sort_filter'] = $this->language->get('text_sort_filter');
		$data['text_additional'] = $this->language->get('text_additional');
		$data['text_block_price'] = $this->language->get('text_block_price');
		$data['text_block_category'] = $this->language->get('text_block_category');
		$data['text_ajax'] = $this->language->get('text_ajax');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_checkbox'] = $this->language->get('text_checkbox');
		$data['text_radio'] = $this->language->get('text_radio');
		
		$data['text_block_keywords'] = $this->language->get('text_block_keywords');
		$data['text_space'] = $this->language->get('text_space');
		$data['text_comma'] = $this->language->get('text_comma');
		$data['text_block_manufacturers'] = $this->language->get('text_block_manufacturers');
		$data['text_block_stock'] = $this->language->get('text_block_stock');
		$data['text_block_options'] = $this->language->get('text_block_options');
		$data['text_block_attributes'] = $this->language->get('text_block_attributes');
		$data['text_block_ratings'] = $this->language->get('text_block_ratings');
		$data['text_help_layout_block'] = $this->language->get('text_help_layout_block');
		$data['text_color'] = $this->language->get('text_color');
		$data['text_h4_group'] = $this->language->get('text_h4_group');
		$data['text_bg'] = $this->language->get('text_bg');
		$data['text_indikator_price'] = $this->language->get('text_indikator_price');
		$data['text_setting_view'] = $this->language->get('text_setting_view');
		$data['text_view_vilter'] = $this->language->get('text_view_vilter');
		$data['text_help_view_vilter'] = $this->language->get('text_help_view_vilter');
		$data['text_view_qyantity'] = $this->language->get('text_view_qyantity');
		$data['text_help_view_qyantity'] = $this->language->get('text_help_view_qyantity');
		$data['text_height_filter'] = $this->language->get('text_height_filter');
		$data['text_help_height_filter'] = $this->language->get('text_help_height_filter');
		$data['text_quantity'] = $this->language->get('text_quantity');
		$data['text_view'] = $this->language->get('text_view');
		
		$data['text_setting_quantity'] = $this->language->get('text_setting_quantity');
		$data['text_help_view_vilter_quantity'] = $this->language->get('text_help_view_vilter_quantity');
		
		
		
		$data['text_help_collapse'] = $this->language->get('text_help_collapse');
		$data['text_help_desktop'] = $this->language->get('text_help_desktop');
		$data['text_help_mobile'] = $this->language->get('text_help_mobile');
		
		$data['text_h4_gofilter'] = $this->language->get('text_h4_gofilter');
		$data['help_text_seo_keyword_unique'] = $this->language->get('help_text_seo_keyword_unique');
		$data['help_text_cache'] = $this->language->get('help_text_cache');
		$data['help_text_on_cache'] = $this->language->get('help_text_on_cache');
		$data['text_status_cache'] = $this->language->get('text_status_cache');
		$data['text_clear_cache'] = $this->language->get('text_clear_cache');
		$data['text_button_clear_cache'] = $this->language->get('text_button_clear_cache');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['entry_category_filter'] = $this->language->get('entry_category_filter');
		$data['text_check_child_category'] = $this->language->get('text_check_child_category');
		$data['text_check_child_category_label'] = $this->language->get('text_check_child_category_label');
		
		$data['help_text_seo'] = $this->language->get('help_text_seo');
		$data['help_text_seo_keyword'] = $this->language->get('help_text_seo_keyword');
		$data['text_status_seo'] = $this->language->get('text_status_seo');
		$data['help_text_on_seo'] = $this->language->get('help_text_on_seo');
		$data['text_seo_separator'] = $this->language->get('text_seo_separator');
		$data['help_text_seo_separator'] = $this->language->get('help_text_seo_separator');
		
		$data['help_text_scripts'] = $this->language->get('help_text_scripts');
		$data['help_label_text_scripts'] = $this->language->get('help_label_text_scripts');
		$data['help_popup_label_text_scripts'] = $this->language->get('help_popup_label_text_scripts');
		
		$data['text_common_settings'] = $this->language->get('text_common_settings');
		$data['text_check_options'] = $this->language->get('text_check_options');
		$data['text_check_attributes'] = $this->language->get('text_check_attributes');
		$data['help_text_attrib'] = $this->language->get('help_text_attrib');
		$data['help_text_attrib_label'] = $this->language->get('help_text_attrib_label');
		$data['help_text_attrib_placeholder'] = $this->language->get('help_text_attrib_placeholder');
		
		$data['help_text_options'] = $this->language->get('help_text_options');
		$data['help_text_options_label'] = $this->language->get('help_text_options_label');
		$data['help_text_options_placeholder'] = $this->language->get('help_text_options_placeholder');
		$data['text_add_seo'] = $this->language->get('text_add_seo');
		$data['text_seo_parametr'] = $this->language->get('text_seo_parametr');
		$data['text_seo_keyword_parametr'] = $this->language->get('text_seo_keyword_parametr');
		
		$data['text_clear_space'] = $this->language->get('text_clear_space');
		$data['text_clear_label_space'] = $this->language->get('text_clear_label_space');
		$data['help_text_clear_label_space'] = $this->language->get('help_text_clear_label_space');
		$data['text_clear_button_space'] = $this->language->get('text_clear_button_space');
		$data['text_load_for_button_darbage'] = $this->language->get('text_load_for_button_darbage');
		$data['text_cont_for_button_darbage'] = $this->language->get('text_cont_for_button_darbage');
		
		$data['text_label_id'] = $this->language->get('text_label_id');
		$data['text_content_id'] = $this->language->get('text_content_id');
		$data['help_text_id'] = $this->language->get('help_text_id');
		$data['text_column_id'] = $this->language->get('text_column_id');
		$data['text_mobile_id'] = $this->language->get('text_mobile_id');
		
		$data['text_block_filter'] = $this->language->get('text_block_filter');
		
		
		
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
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/gofilter', 'token=' . $this->session->data['token'], true)
		);
		
		$data['text_zapros'] = "index.php?route=extension/module/gofilter/";
		
		if (isset($this->request->post['gofilter_status'])) {
			$data['gofilter_status'] = $this->request->post['gofilter_status'];
		} else {
			$data['gofilter_status'] = $this->config->get('gofilter_status');
		}
		
		$data['action'] = $this->url->link('extension/module/gofilter', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		
		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();
		$languages = $data['languages'];
		$data['languages'] = array();
		foreach ($languages as $language) {
			$data['languages'][] = array(
				'language_id' 	=> $language['language_id'],
				'name' 			=> $language['name'],
				'code' 			=> $language['code'],
				'img' 			=> "language/" . $language['code'] . "/" . $language['code'] . ".png",
			);
		}
		
		$filter_data = array(
			'sort'  => 'name',
			'order' => 'ASC'
		);
		
		$this->load->model('design/layout');
		
		$results = $this->model_design_layout->getLayouts($filter_data);

		foreach ($results as $result) {
			$module_info_store = $this->model_extension_module_gofilter->getStore($result['layout_id']);
			$module_info_route = $this->model_extension_module_gofilter->getRouting($result['layout_id']);

			$data['layouts'][] = array(
				'layout_id' 	=> $module_info_store . "-" . $result['layout_id'],
				'route' 		=> $module_info_route,
				'name'      	=> $result['name']
			);
			
		}

		$module_info = $this->model_extension_module_gofilter->getGofilter('gofilter');
		
		$data['massiv_filter'] = array();
		$data['massiv_categories'] = array();
		
		if (isset($module_info['gofilter_data'])) {
			
			foreach (json_decode($module_info['gofilter_data'], true) as $module => $value) {
				
				$massiv_id = preg_replace("/[^0-9]/", '', $module);
				
				if (isset($module)) {
					$data['massiv_filter'][] = $module;
				}
				
				
				if (isset($value['layout'])) {
					$data['massiv_layout_filter'][$massiv_id] = $value['layout'];
					
					$data['massiv_route_filter'][$massiv_id] = array();
					foreach ($value['layout'] as $key => $value_layout) {
						if (strpos($value_layout, "-") !== false) {$val_exp = explode('-', $value_layout)[1];} else {$val_exp = $value_layout;}
						$name_route = $this->model_extension_module_gofilter->getRouting($val_exp);
						$data['massiv_route_filter'][$massiv_id][] = $name_route;
						
						$data['test_categ_block'][$massiv_id] = false;
						if (isset($data['massiv_route_filter'][$massiv_id])) {
							if (in_array("product/category", $data['massiv_route_filter'][$massiv_id])) {
								$data['test_categ_block'][$massiv_id] = true;
							}
						}
					}
					
					foreach ($results as $result) {
						$module_info_store = $this->model_extension_module_gofilter->getStore($result['layout_id']);
						$module_info_route = $this->model_extension_module_gofilter->getRouting($result['layout_id']);
						
						$change_layout = false;
						if (isset($data['massiv_route_filter'][$massiv_id])) {
							if (in_array($module_info_store . "-" . $result['layout_id'], $data['massiv_layout_filter'][$massiv_id])) {
								$change_layout = true;
							}
						}
						
						

						$data['layoutss'][$massiv_id][] = array(
							'layout_id' 	=> $module_info_store . "-" . $result['layout_id'],
							'route' 		=> $module_info_route,
							'name'      	=> $result['name'],
							'change_layout' => $change_layout
						);
						
					}
					
				}
				
				$data['massiv_name_module'][$massiv_id] = array();
				if (isset($value['name_module'])) {
					foreach ($data['languages'] as $language) {
						$data['massiv_name_module'][$massiv_id][$language['language_id']] = $value['name_module'];
					}
				}
				
				if (isset($value['categories_layout'])) {
					foreach ($value['categories_layout'] as $key => $value_category_id) {
						$name_category = $this->model_extension_module_gofilter->getCategoryname($value_category_id);
						if ($name_category) {
							$data['massiv_categories'][$massiv_id][] = array(
								'category_id' 	=> $value_category_id,
								'name' 			=> $name_category
							);
						}
					}
				}
				$data['attributes_related'][$massiv_id] = array();
				if (isset($value['attributes_related'])) {
					foreach ($value['attributes_related'] as $key_attr => $value_attr) {
						$name_attr = $this->model_extension_module_gofilter->getNameAttributes($value_attr);
						$data['attributes_related'][$massiv_id][] = array(
							'name' => $name_attr,
							'attribute_id' => $value_attr
						);
					}
				}

				$data['options_related'][$massiv_id] = array();
				if (isset($value['options_related'])) {
					foreach ($value['options_related'] as $key_option => $value_option) {
						$name_option = $this->model_extension_module_gofilter->getNameOptions($value_option);
						$data['options_related'][$massiv_id][] = array(
							'option_id' 			=> (int)$value_option,
							'name_option' 			=> $name_option
						);
					}
				}
				
				$data['seo_keywords'] = array();
				if (isset($value['seo_keywords'])) {
					foreach ($value['seo_keywords'] as $key_seo => $value_seo) {
						$data['seo_keywords'][$value_seo['keyword']] = $value_seo['language'];
					}
				}
				
				
				if (isset($value['child_category'])) {$data['gofilter_child_category'][$massiv_id] = $value['child_category'];}
				
				if (isset($value['category_type'])) {$data['gofilter_category_type'][$massiv_id] = $value['category_type'];}
				if (isset($value['keywords_type'])) {$data['gofilter_keywords_type'][$massiv_id] = $value['keywords_type'];}
				if (isset($value['manufacturers_type'])) {$data['gofilter_manufacturers_type'][$massiv_id] = $value['manufacturers_type'];}
				if (isset($value['status_stock_type'])) {$data['gofilter_status_stock_type'][$massiv_id] = $value['status_stock_type'];}
				if (isset($value['ratings_type'])) {$data['gofilter_ratings_type'][$massiv_id] = $value['ratings_type'];}
				if (isset($value['layout_name'])) {$data['gofilter_layout_name'][$massiv_id] = $value['layout_name'];}
				if (isset($value['status_price'])) {$data['gofilter_status_price'][$massiv_id] = $value['status_price'];}
				if (isset($value['view_price'])) {$data['gofilter_view_price'][$massiv_id] = $value['view_price'];}
				if (isset($value['status_category'])) {$data['gofilter_status_category'][$massiv_id] = $value['status_category'];}
				if (isset($value['view_category'])) {$data['gofilter_view_category'][$massiv_id] = $value['view_category'];}
				if (isset($value['status_keywords'])) {$data['gofilter_status_keywords'][$massiv_id] = $value['status_keywords'];}
				if (isset($value['view_keywords'])) {$data['gofilter_view_keywords'][$massiv_id] = $value['view_keywords'];}
				if (isset($value['status_manufacturers'])) {$data['gofilter_status_manufacturers'][$massiv_id] = $value['status_manufacturers'];}
				if (isset($value['view_manufacturers'])) {$data['gofilter_view_manufacturers'][$massiv_id] = $value['view_manufacturers'];}
				if (isset($value['status_stock'])) {$data['gofilter_status_stock'][$massiv_id] = $value['status_stock'];}
				if (isset($value['view_stock'])) {$data['gofilter_view_stock'][$massiv_id] = $value['view_stock'];}				
				if (isset($value['status_ratings'])) {$data['gofilter_status_ratings'][$massiv_id] = $value['status_ratings'];}
				if (isset($value['view_ratings'])) {$data['gofilter_view_ratings'][$massiv_id] = $value['view_ratings'];}
				if (isset($value['status_options'])) {$data['gofilter_status_options'][$massiv_id] = $value['status_options'];}
				if (isset($value['view_options'])) {$data['gofilter_view_options'][$massiv_id] = $value['view_options'];}
				if (isset($value['status_attributes'])) {$data['gofilter_status_attributes'][$massiv_id] = $value['status_attributes'];}
				if (isset($value['view_attributes'])) {$data['gofilter_view_attributes'][$massiv_id] = $value['view_attributes'];}
				if (isset($value['status_filter'])) {$data['gofilter_status_filter'][$massiv_id] = $value['status_filter'];}
				if (isset($value['view_filter'])) {$data['gofilter_view_filter'][$massiv_id] = $value['view_filter'];}
				if (isset($value['sort_price'])) {$data['gofilter_sort_price'][$massiv_id] = $value['sort_price'];}
				if (isset($value['sort_category'])) {$data['gofilter_sort_category'][$massiv_id] = $value['sort_category'];}
				if (isset($value['sort_keywords'])) {$data['gofilter_sort_keywords'][$massiv_id] = $value['sort_keywords'];}
				if (isset($value['sort_manufacturers'])) {$data['gofilter_sort_manufacturers'][$massiv_id] = $value['sort_manufacturers'];}
				if (isset($value['sort_stock'])) {$data['gofilter_sort_stock'][$massiv_id] = $value['sort_stock'];}
				if (isset($value['sort_ratings'])) {$data['gofilter_sort_ratings'][$massiv_id] = $value['sort_ratings'];}
				if (isset($value['sort_options'])) {$data['gofilter_sort_options'][$massiv_id] = $value['sort_options'];}
				if (isset($value['sort_attributes'])) {$data['gofilter_sort_attributes'][$massiv_id] = $value['sort_attributes'];}
				if (isset($value['sort_filter'])) {$data['gofilter_sort_filter'][$massiv_id] = $value['sort_filter'];}
				
				if (isset($value['color_caption'])) {$data['color_caption'] = $value['color_caption'];}
				if (isset($value['color_group'])) {$data['color_group'] = $value['color_group'];}
				if (isset($value['bg_group'])) {$data['bg_group'] = $value['bg_group'];}
				if (isset($value['color_product'])) {$data['color_product'] = $value['color_product'];}
				if (isset($value['color_product_no'])) {$data['color_product_no'] = $value['color_product_no'];}
				if (isset($value['bg_price'])) {$data['bg_price'] = $value['bg_price'];}
				if (isset($value['max_height'])) {$data['max_height'] = $value['max_height'];}
				if (isset($value['popup_view'])) {$data['popup_view'] = $value['popup_view'];}
				if (isset($value['stock_quantity'])) {$data['stock_quantity'] = $value['stock_quantity'];}
				if (isset($value['quantity_view'])) {$data['quantity_view'] = $value['quantity_view'];}
				if (isset($value['status_cache'])) {$data['status_cache'] = $value['status_cache'];}
				if (isset($value['status_seo'])) {$data['status_seo'] = $value['status_seo'];}
				if (isset($value['seo_separator'])) {$data['seo_separator'] = $value['seo_separator'];}
				if (isset($value['count_show'])) {$data['count_show'] = $value['count_show'];}
				
				if (isset($value['collapse_price'])) {$data['gofilter_collapse_price'][$massiv_id] = $value['collapse_price'];}
				if (isset($value['collapse_category'])) {$data['gofilter_collapse_category'][$massiv_id] = $value['collapse_category'];}
				if (isset($value['collapse_keywords'])) {$data['gofilter_collapse_keywords'][$massiv_id] = $value['collapse_keywords'];}
				if (isset($value['collapse_manufacturers'])) {$data['gofilter_collapse_manufacturers'][$massiv_id] = $value['collapse_manufacturers'];}
				if (isset($value['collapse_stock'])) {$data['gofilter_collapse_stock'][$massiv_id] = $value['collapse_stock'];}
				if (isset($value['collapse_ratings'])) {$data['gofilter_collapse_ratings'][$massiv_id] = $value['collapse_ratings'];}
				if (isset($value['collapse_options'])) {$data['gofilter_collapse_options'][$massiv_id] = $value['collapse_options'];}
				if (isset($value['collapse_attributes'])) {$data['gofilter_collapse_attributes'][$massiv_id] = $value['collapse_attributes'];}
				if (isset($value['collapse_filter'])) {$data['gofilter_collapse_filter'][$massiv_id] = $value['collapse_filter'];}
				
				if (isset($value['desktop_price'])) {$data['gofilter_desktop_price'][$massiv_id] = $value['desktop_price'];}
				if (isset($value['desktop_category'])) {$data['gofilter_desktop_category'][$massiv_id] = $value['desktop_category'];}
				if (isset($value['desktop_keywords'])) {$data['gofilter_desktop_keywords'][$massiv_id] = $value['desktop_keywords'];}
				if (isset($value['desktop_manufacturers'])) {$data['gofilter_desktop_manufacturers'][$massiv_id] = $value['desktop_manufacturers'];}
				if (isset($value['desktop_stock'])) {$data['gofilter_desktop_stock'][$massiv_id] = $value['desktop_stock'];}
				if (isset($value['desktop_ratings'])) {$data['gofilter_desktop_ratings'][$massiv_id] = $value['desktop_ratings'];}
				if (isset($value['desktop_options'])) {$data['gofilter_desktop_options'][$massiv_id] = $value['desktop_options'];}
				if (isset($value['desktop_attributes'])) {$data['gofilter_desktop_attributes'][$massiv_id] = $value['desktop_attributes'];}
				if (isset($value['desktop_filter'])) {$data['gofilter_desktop_filter'][$massiv_id] = $value['desktop_filter'];}
				
				if (isset($value['mobile_price'])) {$data['gofilter_mobile_price'][$massiv_id] = $value['mobile_price'];}
				if (isset($value['mobile_category'])) {$data['gofilter_mobile_category'][$massiv_id] = $value['mobile_category'];}
				if (isset($value['mobile_keywords'])) {$data['gofilter_mobile_keywords'][$massiv_id] = $value['mobile_keywords'];}
				if (isset($value['mobile_manufacturers'])) {$data['gofilter_mobile_manufacturers'][$massiv_id] = $value['mobile_manufacturers'];}
				if (isset($value['mobile_stock'])) {$data['gofilter_mobile_stock'][$massiv_id] = $value['mobile_stock'];}
				if (isset($value['mobile_ratings'])) {$data['gofilter_mobile_ratings'][$massiv_id] = $value['mobile_ratings'];}
				if (isset($value['mobile_options'])) {$data['gofilter_mobile_options'][$massiv_id] = $value['mobile_options'];}
				if (isset($value['mobile_attributes'])) {$data['gofilter_mobile_attributes'][$massiv_id] = $value['mobile_attributes'];}
				if (isset($value['mobile_filter'])) {$data['gofilter_mobile_filter'][$massiv_id] = $value['mobile_filter'];}
				
				if (isset($value['filter_scripts'])) {$data['filter_scripts'] = $value['filter_scripts'];}
				
				
				
				
				if (isset($value['id_content'])) {$data['id_content'] = $value['id_content'];}
				if (isset($value['id_column_left'])) {$data['id_column_left'] = $value['id_column_left'];}
				if (isset($value['id_column_right'])) {$data['id_column_right'] = $value['id_column_right'];}
				if (isset($value['id_button_mobile'])) {$data['id_button_mobile'] = $value['id_button_mobile'];}
				
			}
		}
		
		$kol_vo_layout = 0;
		if (isset($data['massiv_filter'])) {
			foreach ($data['massiv_filter'] as $massiv_key => $massiv_value) {
				if (strpos($massiv_value, "layout") === false) {} else {$kol_vo_layout = $kol_vo_layout + 1;}
			}
		}
		
		$data['kol_vo_layout'] = $kol_vo_layout;
		
		$data['attributes_relateds'] = array();
		
		/*
		$exclude_attributes = $this->getAttributes();
		
		if ($exclude_attributes) {
			foreach ($exclude_attributes as $attrib) {
				$data['attributes_relateds'][] = array(
					'product_id' => $attrib['attribute_id'],
					'name'       => $attrib['name']
				);
			}
		} */

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		if (!isset($data['id_content'])) {$data['id_content'] = "#content";}
		if (!isset($data['id_column_left'])) {$data['id_column_left'] = "#column-left";}
		if (!isset($data['id_column_right'])) {$data['id_column_right'] = "#column-right";}
		if (!isset($data['id_button_mobile'])) {$data['id_button_mobile'] = "#menu";}
		

		$this->response->setOutput($this->load->view('extension/module/gofilter', $data));
	}

	public function getAttributes() {
		
		$json = array();
		if (isset($this->request->get['filter_name'])) {
			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
			$this->load->model('extension/module/gofilter');
			$results = $this->model_extension_module_gofilter->getmodelAttributes($filter_name);
			if ($results) {
				foreach ($results as $result) {
					$json[] = array(
						'attribute_id' 		=> (int)$result['attribute_id'],
						'name_attribute' 	=> $result['name_attribute'],
						'name_group' 		=> $result['name_group']
					);
				}
			}
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function getOptions() {
		
		$json = array();
		if (isset($this->request->get['filter_name'])) {
			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
			$this->load->model('extension/module/gofilter');
			$results = $this->model_extension_module_gofilter->getmodelOptions($filter_name);
			if ($results) {
				foreach ($results as $result) {
					$json[] = array(
						'option_id' 			=> (int)$result['option_id'],
						'name_option' 			=> $result['name_option']
					);
				}
			}
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function removecache() {
	  $this->load->language('extension/module/gofilter');
	  
      $json = array();

      if ($this->user->hasPermission('modify', 'extension/module/gofilter')) {
          if (isset($this->request->get['type']) &&  $this->request->get['type'] == 'gofilter') {
              $json['success'] = $this->cleanCacheGofilter();
          } else {
              $json['success'] = $this->language->get('error_not_found');
          }

      } else {
          $json['error'] = $this->language->get('error_permission');
      }

      $this->response->addHeader('Content-Type: application/json');
      $this->response->setOutput(json_encode($json));
    }
	
	public function delete_garbage() {
		
		$clear_garbage = array();
		
		$clear_garbage['\r\n'] = '';
		$clear_garbage['\r'] = '';
		$clear_garbage['\n'] = '';
		$clear_garbage['  '] = ' ';
		
		$text_clear_garbage = array();
		foreach ($clear_garbage as $key => $value) {
			$text_clear_garbage[] = $key;
		}
		
		$massiv_table = array();
		$massiv_table[DB_PREFIX . "product_attribute"] = "`text`";
		$massiv_table[DB_PREFIX . "attribute_description"] = "`name`";
		$massiv_table[DB_PREFIX . "attribute_group_description"] = "`name`";
		$massiv_table[DB_PREFIX . "category_description"] = "`name`";
		$massiv_table[DB_PREFIX . "manufacturer"] = "`name`";
		$massiv_table[DB_PREFIX . "manufacturer_description"] = "`name`";
		$massiv_table[DB_PREFIX . "option_description"] = "`name`";
		$massiv_table[DB_PREFIX . "option_value_description"] = "`name`";
		$massiv_table[DB_PREFIX . "product_description"] = "`name`";
		
		$this->load->language('extension/module/gofilter');
		
		$json = array();

		$this->load->model('extension/module/gofilter');
		$results = $this->model_extension_module_gofilter->getClearGarbage($clear_garbage, $massiv_table);
		
		$itog_count = 0;
		if ($results) {
			foreach ($results as $keys => $values) {
				$count = 0;
				foreach ($values as $key => $value) {
					$count += $value;
				}
				$itog_count += $count;
				$json['text_success'] = $this->language->get('vtablise') . $keys . $this->language->get('udaleno') . $count . $this->language->get('zapicei');
			}
		}
		
		$json['itog_count'] = $itog_count;
		$json['itog_count_text'] = $this->language->get('empty_symbol') . "` " . $this->db->escape(implode(",", $text_clear_garbage)) . " `";
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	protected function cleanCacheGofilter(){
		$this->load->language('extension/module/gofilter');
		$result = '';
        if (glob(DIR_CACHE . '*gofilter*')) {
            foreach(glob(DIR_CACHE . '*gofilter*') as $file) {
                @unlink($file);
                $result .= 'Remove file `' . $file . '`' . PHP_EOL;
            }
        } else {
            $result = $this->language->get('text_folder_not_found');
        }

        return $result;
    }

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/gofilter')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (isset($this->request->post['gofilter_data']['settings']['filter_scripts']) and (strpos($this->request->post['gofilter_data']['settings']['filter_scripts'], '&lt;script type=') !== false or strpos($this->request->post['gofilter_data']['settings']['filter_scripts'], '&lt;script&gt;') !== false or strpos($this->request->post['gofilter_data']['settings']['filter_scripts'], 'text/javascript') !== false)) {
			$this->error['warning'] = $this->language->get('error_scripts');
		}
		
		if (isset($this->request->post['gofilter_data']['settings']['seo_separator']) and (strpos($this->request->post['gofilter_data']['settings']['seo_separator'], '/') !== false)) {
			$this->error['warning'] = $this->language->get('error_seo_separator');
		}
		
		return !$this->error;
	}
}