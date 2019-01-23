<?php
class ControllerExtensionModuleLMCfilter extends Controller {
	public function index() {
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		$category_id = end($parts);

		$this->load->model('catalog/category');

		$category_info = $this->model_catalog_category->getCategory($category_id);
        
        
		if ($category_info) {
			$this->load->language('extension/module/LMCfilter');

			$data['heading_title'] = $this->language->get('heading_title');

			$data['button_filter'] = $this->language->get('button_filter');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['action'] = str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url));

			if (isset($this->request->get['filter'])) {
				$data['filter_category'] = explode(',', $this->request->get['filter']);
			} else {
				$data['filter_category'] = array();
			}

			$this->load->model('catalog/product');

			$data['filter_groups'] = array();

			$filter_groups = $this->model_catalog_category->getCategoryFilters($category_id);

			if ($filter_groups) {
                
                $price_slider = false;
                $category_prices = null;
                
				foreach ($filter_groups as $filter_group) {
					$childen_data = array();

					foreach ($filter_group['filter'] as $filter) {
						$filter_data = array(
							'filter_category_id' => $category_id,
							'filter_filter'      => $filter['filter_id']
						);

						$childen_data[] = array(
							'filter_id' => $filter['filter_id'],
							'name'      => $filter['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : '')
						);
					}
                    
                    if ($filter_group['LMCfilter_mode'] == 'price') {
                        $price_slider = true;
                        $min = isset($filter_group['LMCfilter_data']['min_price']) ? $filter_group['LMCfilter_data']['min_price'] : 1;
                        $max = isset($filter_group['LMCfilter_data']['max_price']) ? $filter_group['LMCfilter_data']['max_price'] : 100;
                        $step = isset($filter_group['LMCfilter_data']['step']) ? $filter_group['LMCfilter_data']['step'] : 1;
                        $auto = isset($filter_group['LMCfilter_data']['price_auto']) ? $filter_group['LMCfilter_data']['price_auto'] : 0;
                            
                        if ($auto == 1) {
                            
                            if ($category_prices == null) {
                                $sql = "SELECT MAX(p.price) AS default_price_max, MAX(pd.price) AS discount_price_max, MAX(ps.price) AS special_price_max, MIN(p.price) AS default_price_min, MIN(pd.price) AS discount_price_min, MIN(ps.price) AS special_price_min FROM " . DB_PREFIX . "product_to_category ptc LEFT JOIN " . DB_PREFIX . "product p ON (p.product_id = ptc.product_id) LEFT JOIN " . DB_PREFIX . "product_discount pd ON (p.product_id = pd.product_id AND pd.quantity = '1' AND pd.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((pd.date_start = '0000-00-00' OR pd.date_start < NOW()) AND (pd.date_end = '0000-00-00' OR pd.date_end > NOW()))) LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))) WHERE ptc.category_id = " . (int)$category_id;
                                $query = $this->db->query($sql);
                                $r = $query->row;
                                if ($r['discount_price_min'] != null && ($r['special_price_min'] == null ? true : $r['discount_price_min'] <= $r['special_price_min']) && $r['discount_price_min'] <= $r['default_price_min']) {
                                    $min = $r['discount_price_min'];
                                } elseif ($r['special_price_min'] != null && ($r['discount_price_min'] == null ? true : $r['special_price_min'] <= $r['discount_price_min']) && $r['special_price_min'] <= $r['default_price_min']) {
                                    $min = $r['special_price_min'];
                                } else {
                                    $min = $r['default_price_min'];
                                }
                                if ($r['discount_price_max'] != null && ($r['special_price_max'] == null ? true : $r['discount_price_max'] <= $r['special_price_max']) && $r['discount_price_max'] <= $r['default_price_max']) {
                                    $max = $r['discount_price_max'];
                                } elseif ($r['special_price_max'] != null && ($r['discount_price_max'] == null ? true : $r['special_price_max'] <= $r['discount_price_max']) && $r['special_price_max'] <= $r['default_price_max']) {
                                    $max = $r['special_price_max'];
                                } else {
                                   
                                } $max = $r['default_price_max'];
                                $category_prices = array(
                                    'min'   => $min,
                                    'max'   => $max,
                                );
                            }
                            
                            $min = $category_prices['min'];
                            $max = $category_prices['max'];
                            
                        }
                        
                        if ($min == $max) {
                            $min--; $max++;
                        }
                        
                        $filter_group['LMCfilter_data']['min_price'] = $min;
                        $filter_group['LMCfilter_data']['max_price'] = $max;
                        $filter_group['LMCfilter_data']['step'] = $step;
                    }

					$data['filter_groups'][] = array(
						'filter_group_id' => $filter_group['filter_group_id'],
						'name'            => $filter_group['name'],
						'filter'          => $childen_data,
                        'LMCfilter_mode' => $filter_group['LMCfilter_mode'],
                        'LMCfilter_data' => $filter_group['LMCfilter_data'],
					);
				}
                
                $data['price_slider'] = $price_slider;

				return $this->load->view('extension/module/LMCfilter', $data);
			}
		}
	}
}
