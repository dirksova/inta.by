<?php
class ControllerCommonHeader extends Controller {
	
	private function split_tels($tel) {
		 
		 $number = array();
		 $x = 0;
		 foreach(str_split($tel) as $t) { 
		    if($x == 0) { $number[] = '<span>'; }
		    if($x == 4) { $number[] = ' '; }
			if($x == 6) { $number[] = ' </span> '; }
			if($x == 9) { $number[] = '-'; }
			if($x == 11) { $number[] = '-'; }
		    $number[] = $t;
		    $x++;
		 }
		 
		 return implode('', $number);
		
	}	
	
	public function index() {

        $data['smca_form_data']         = (array)$this->config->get('ocdev_smart_cart_form_data');
        $data['smca_store_id']          = (int)$this->config->get('config_store_id');
        $data['smca_customer_group_id'] = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
      
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
			}
		}

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}


            // YUMenu
            $yumenus = $this->config->get('yumenu_main');
            $data['yumenus'] = array();

            if ($yumenus) {
                $this->load->model('extension/module');

                $main_menus = array();

                foreach ($yumenus as $menu_id) {
                    $setting_info = $this->model_extension_module->getModule($menu_id);

                    if ($setting_info && $setting_info['status']) {
                        $main_menus[] = $setting_info;

                        $sort_order = array();
                        foreach ($main_menus as $key => $value) {
                            $sort_order[$key] = isset($value['main_sort']) ? $value['main_sort'] : 0;
                        }
                        array_multisort($sort_order, SORT_ASC, $main_menus);
                    }
                }

                foreach ($main_menus as $main_menu) {
                    $output = $this->load->controller('extension/module/yumenu', $main_menu);

                    if ($output) {
                        $data['yumenus'][] = $output;
                    }
                }
            }
            
		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();

			// << Live Price

				if ( !$this->model_module_liveprice ) {
					$this->load->model('module/liveprice');
				}
				if ( $this->model_module_liveprice->installed() ) {
					$liveprice_custom_js = $this->model_module_liveprice->getPathToCustomJS();
					if ( $liveprice_custom_js ) {
						$this->document->addScript( $liveprice_custom_js );
					}
					$this->document->addScript( $this->model_module_liveprice->getPathToMainJS() );
					$data['liveprice_installed'] 	= true;
					$data['liveprice_settings'] 	= $this->config->get('liveprice_settings');
					$data['lp_theme_name'] 				= $this->model_module_liveprice->getThemeName();
				}
				
			// >> Live Price
			
		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', true);
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] =  $this->config->get('config_telephone');
		$data['telephone2'] =  $this->config->get('config_telephone2');
		$data['telephone_formatted'] = $this->split_tels($this->config->get('config_telephone'));
		$data['telephone2_formatted'] = $this->split_tels($this->config->get('config_telephone2'));
		
		$data['social_fb'] = $this->config->get('config_fb');
		$data['social_vk'] = $this->config->get('config_vk');
		$data['social_ok'] = $this->config->get('config_ok');
		$data['social_tw'] = $this->config->get('config_tw');
		$data['social_in'] = $this->config->get('config_in');
		
		$data['search_href'] = $this->url->link('product/search');
		$data['special'] = $this->url->link('product/special');
		$data['text_special'] = $this->language->get('text_special');
		
		$data['contact'] = $this->url->link('information/contact');
		
		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
			$data['informations'][] = array(
				'title' => $result['title'],
				'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
			);
			}
		}


		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		
            if ($data['yumenus']) {
                $categories = array();
            } else {
                $categories = $this->model_catalog_category->getCategories(0);
            }
            

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				// Level 1
				$data['categories'][] = array(
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}

		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} elseif (isset($this->request->get['information_id'])) {
				$class = '-' . $this->request->get['information_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		return $this->load->view('common/header', $data);
	}
}
