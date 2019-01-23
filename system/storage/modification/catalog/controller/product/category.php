<?php
class ControllerProductCategory extends Controller {
	public function index() {
		$this->load->language('product/category');

		$this->load->model('catalog/category');

			/* Ocmod filter */
			
				if (isset($this->request->get['gofilter'])) {
					$gofilter = $this->request->get['gofilter'];
				} else {
					$gofilter = false;
				}
				
				$data['gofilter'] = $gofilter;
				
				if (isset($this->request->get['nofilter'])) {
					$nofilter = $this->request->get['nofilter'];
				} else {
					$nofilter = false;
				}
				
				$data['nofilter'] = $nofilter;
				
				if ($nofilter or $gofilter) {
					$this->load->model('extension/module/gofilter');
					$products_array = $this->model_extension_module_gofilter->getOptionsProducts($this->request->get);
					$products = $this->model_extension_module_gofilter->getGenerationEnumeration($products_array);
				}
				
				if (strpos($this->request->server['REQUEST_URI'], "gofilter/") !== false) {
					$this->load->language('extension/module/gofilter');
				}
				
				$data['categories'] = array();

				if (isset($this->request->post['products_id'])) {
					$products = $this->request->post['products_id'];
					$data['products'] = $products;
				}
				
				if (isset($this->request->get['products_id'])) {
					$products = $this->request->get['products_id'];
					$data['products'] = $products;
				}
				
				if (isset($this->request->get['route_layout'])) {
					$route_layout = true;
				} else {
					$route_layout = false;
				}
				
				$url_filter = "";
				
				if (isset($this->request->get['gofilter']) or isset($this->request->get['nofilter'])) {
					
					if (isset($this->request->get['category_id'])) {
						$url_filter .= '&categ_id=' . $this->request->get['category_id'];
					}
					if (isset($this->request->get['categ_id'])) {
						$url_filter .= '&categ_id=' . $this->request->get['categ_id'];
					}
					if (isset($this->request->get['patfilter'])) {
						$url_filter .= '&path=' . $this->request->get['patfilter'];
					}
					if (isset($this->request->get['prices_min_value'])) {
						$url_filter .= '&prices_min_value=' . $this->request->get['prices_min_value'];
					}
					if (isset($this->request->get['prices_max_value'])) {
						$url_filter .= '&prices_max_value=' . $this->request->get['prices_max_value'];
					}
					if (isset($this->request->get['stock_status_filter'])) {
						foreach ($this->request->get['stock_status_filter'] as $key => $value)
						$url_filter .= '&stock_status_filter[' . $key . ']=' . $value;
					}
					if (isset($this->request->get['route_layout'])) {
						$url_filter .= '&route_layout=' . $this->request->get['route_layout'];
					}
					if (isset($this->request->get['nofilter'])) {
						$url_filter .= '&nofilter=' . $this->request->get['nofilter'];
					}
					if (isset($this->request->get['manufacturers_filter'])) {
						foreach ($this->request->get['manufacturers_filter'] as $key => $value)
						$url_filter .= '&manufacturers_filter[]=' . $value;
					}
					if (isset($this->request->get['option_filter'])) {
						foreach ($this->request->get['option_filter'] as $key => $value)
						$url_filter .= '&option_filter[]=' . $value;
					}
					if (isset($this->request->get['filter_filter'])) {
						foreach ($this->request->get['filter_filter'] as $key => $value)
						$url_filter .= '&filter_filter[]=' . $value;
					}
					if (isset($this->request->get['attributes_filter'])) {
						foreach ($this->request->get['attributes_filter'] as $key => $value) {
							if ($value) {
								foreach ($value as $key_2 => $value_2) {
									$url_filter .= '&attributes_filter[' . $key . '][]=' . $value_2;
								}
							}
						}
					}
					if (isset($this->request->get['rating_filter'])) {
						foreach ($this->request->get['rating_filter'] as $key => $value)
						$url_filter .= '&rating_filter[]=' . $value;
					}
					if (isset($this->request->get['gofilter'])) {
						$url_filter .= '&nofilter=' . $this->request->get['gofilter'];
					}
				}
				
				if (isset($this->request->post)) {
					
					if (isset($this->request->post['category_id'])) {
						$url_filter .= '&categ_id=' . $this->request->post['category_id'];
					}
					if (isset($this->request->post['categ_id'])) {
						$url_filter .= '&categ_id=' . $this->request->post['categ_id'];
					}
					if (isset($this->request->post['patfilter'])) {
						$url_filter .= '&path=' . $this->request->post['patfilter'];
					}
					if (isset($this->request->post['prices_min_value'])) {
						$url_filter .= '&prices_min_value=' . $this->request->post['prices_min_value'];
					}
					if (isset($this->request->post['prices_max_value'])) {
						$url_filter .= '&prices_max_value=' . $this->request->post['prices_max_value'];
					}
					if (isset($this->request->post['stock_status_filter'])) {
						foreach ($this->request->post['stock_status_filter'] as $key => $value)
						$url_filter .= '&stock_status_filter[' . $key . ']=' . $value;
					}
					if (isset($this->request->post['route_layout'])) {
						$url_filter .= '&route_layout=' . $this->request->post['route_layout'];
					}
					
					if (isset($this->request->post['manufacturers_filter'])) {
						foreach ($this->request->post['manufacturers_filter'] as $key => $value)
						$url_filter .= '&manufacturers_filter[]=' . $value;
					}
					if (isset($this->request->post['option_filter'])) {
						foreach ($this->request->post['option_filter'] as $key => $value)
						$url_filter .= '&option_filter[]=' . $value;
					}
					if (isset($this->request->post['filter_filter'])) {
						foreach ($this->request->post['filter_filter'] as $key => $value)
						$url_filter .= '&filter_filter[]=' . $value;
					}
					if (isset($this->request->post['attributes_filter'])) {
						foreach ($this->request->post['attributes_filter'] as $key => $value) {
							if ($value) {
								foreach ($value as $key_2 => $value_2) {
									$url_filter .= '&attributes_filter[' . $key . '][]=' . $value_2;
								}
							}
						}
					}
					if (isset($this->request->post['rating_filter'])) {
						foreach ($this->request->post['rating_filter'] as $key => $value)
						$url_filter .= '&rating_filter[]=' . $value;
					}
				}
				
				$data['url_filter'] = $url_filter;
			
			/* Ocmod filter */
            

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		// LMCfilter BEGIN
		if (isset($this->request->get['filter_price'])) {
			$filter_price = $this->request->get['filter_price'];
		} else {
			$filter_price = '';
		}
		// LMCfilter END
			

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.price';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			/* Ocmod filter */
				$url .= $url_filter;
			/* Ocmod filter */
            

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path . $url)
					);
				}
			}
		} else {
			$category_id = 0;
		}


			/* Ocmod filter */
				if (!isset($products)) {
				$data['compare'] = $this->url->link('product/compare');
				
			/* Ocmod filter */
				
            
		$category_info = $this->model_catalog_category->getCategory($category_id);

			/* Ocmod filter */
				} else {
					$category_info = true;
					$data['heading_title'] = "";
					$data['thumb'] = false;
					$data['description'] = false;
				}
			/* Ocmod filter */
            

		if ($category_info) {
			$this->document->setTitle($category_info['meta_title']);
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			
			if($category_info['meta_h1'] ==""){
		$data['heading_title'] = $category_info['name'];
		}
		else {
			$data['heading_title'] = $category_info['meta_h1'];
			}
			

			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			/* Ocmod filter */
				$url .= $url_filter;
			/* Ocmod filter */
            

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			// LMCfilter BEGIN
            if (isset($this->request->get['filter_price'])) {
				$url .= '&filter_price=' . $this->request->get['filter_price'];
			}
			// LMCfilter END
			

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				$data['categories'][] = array(
					'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}

			$data['products'] = array();

			/* Ocmod filter */ 
				if (isset($products)) {
					$data['categories'] = false;
				}
				if (!isset($products)) {
			/* Ocmod filter */
            

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,

				// LMCfilter BEGIN
				'filter_price'       => $filter_price,
				// LMCfilter END
			
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);


			/* Ocmod filter */ } else {

			if (isset($products)) {
				if ($products != "") {
					$products_id = $products;
				} else {
					$products_id = false;
				}
			} else {
				$products_id = false;
			}
			
			$filter_data = array(
				'filter_filter'      => $filter,

				// LMCfilter BEGIN
				'filter_price'       => $filter_price,
				// LMCfilter END
			
				'products_id'        => $products_id,
				'route_layout'       => $route_layout,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);
			
			$url = '';
			
			/* Ocmod filter */ } /* Ocmod filter */
            
			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize2($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $result['rating'],
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
				);
			}

			$url = '';

			/* Ocmod filter */
				$url .= $url_filter;
			/* Ocmod filter */
            

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			// LMCfilter BEGIN
            if (isset($this->request->get['filter_price'])) {
				$url .= '&filter_price=' . $this->request->get['filter_price'];
			}
			// LMCfilter END
			

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);

			$url = '';

			/* Ocmod filter */
				$url .= $url_filter;
			/* Ocmod filter */
            

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			// LMCfilter BEGIN
            if (isset($this->request->get['filter_price'])) {
				$url .= '&filter_price=' . $this->request->get['filter_price'];
			}
			// LMCfilter END
			

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
				);
			}

			$url = '';

			/* Ocmod filter */
				$url .= $url_filter;
			/* Ocmod filter */
            

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			// LMCfilter BEGIN
            if (isset($this->request->get['filter_price'])) {
				$url .= '&filter_price=' . $this->request->get['filter_price'];
			}
			// LMCfilter END
			

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
			    $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical');
			} elseif ($page == 2) {
			    $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'prev');
			} else {
			    $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page - 1), true), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
			    $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page + 1), true), 'next');
			}

			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

			$data['continue'] = $this->url->link('common/home');


			/* Ocmod filter */ 
			
			if ($gofilter or $nofilter) {
				$go_filter_pagination = new Gofilterpagination();
				$go_filter_pagination->total = $product_total;
				$go_filter_pagination->page = $page;
				$go_filter_pagination->limit = $limit;
				$go_filter_pagination->url = $url . '&page={page}';
				$go_filter_pagination->products = $products;
				
				$data['go_filter_pagination'] = $go_filter_pagination->render();
			}

			$data['gofilter_cloud'] = "";
			if (!isset($products)) {

			/* Ocmod filter */
            
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			/* Ocmod filter */ } else {$data['column_left'] = ""; $data['column_right'] = ""; $data['content_top'] = ""; $data['content_bottom'] = ""; $data['footer'] = ""; $data['header'] = ""; $data['gofilter_cloud'] = $this->load->controller('product/gofilterscripts');} /* Ocmod filter */
            

			$this->response->setOutput($this->load->view('product/category', $data));
		} else {
			$url = '';

			/* Ocmod filter */
				$url .= $url_filter;
			/* Ocmod filter */
            

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			// LMCfilter BEGIN
            if (isset($this->request->get['filter_price'])) {
				$url .= '&filter_price=' . $this->request->get['filter_price'];
			}
			// LMCfilter END
			

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/category', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			
			/* Ocmod filter */ if ($gofilter or $nofilter or strpos($this->request->server['REQUEST_URI'], "gofilter/") !== false) {} else {$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');} /* Ocmod filter */
            


			/* Ocmod filter */ 
			
			if ($gofilter or $nofilter) {
				$go_filter_pagination = new Gofilterpagination();
				$go_filter_pagination->total = $product_total;
				$go_filter_pagination->page = $page;
				$go_filter_pagination->limit = $limit;
				$go_filter_pagination->url = $url . '&page={page}';
				$go_filter_pagination->products = $products;
				
				$data['go_filter_pagination'] = $go_filter_pagination->render();
			}

			$data['gofilter_cloud'] = "";
			if (!isset($products)) {

			/* Ocmod filter */
            
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			/* Ocmod filter */ } else {$data['column_left'] = ""; $data['column_right'] = ""; $data['content_top'] = ""; $data['content_bottom'] = ""; $data['footer'] = ""; $data['header'] = ""; $data['gofilter_cloud'] = $this->load->controller('product/gofilterscripts');} /* Ocmod filter */
            

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}
}
