<?php
class ControllerInformationInformation extends Controller {
	public function index() {
		$this->load->language('information/information');

		$this->load->model('catalog/information');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$this->document->setTitle($information_info['meta_title']);
			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);

			$data['breadcrumbs'][] = array(
				'text' => $information_info['title'],
				'href' => $this->url->link('information/information', 'information_id=' .  $information_id)
			);

			
			if($information_info['meta_h1'] ==""){
		$data['heading_title'] = $information_info['title'];
		}
		else {
			$data['heading_title'] = $information_info['meta_h1'];
			}
			

			$data['button_continue'] = $this->language->get('button_continue');

			$data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('information/information', $data));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

 
	public function developper() {
		
		    $this->document->setTitle('Информация о разработчике сайта и использовании программного кода');
			$this->document->setDescription('Информация о разработчике сайта и использовании программного кода');
			$this->document->setKeywords('Информация о разработчике сайта и использовании программного кода');
			$this->load->language('information/information');
			$data['breadcrumbs'] = array();

		    $data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		    );
			$data['breadcrumbs'][] = array(
				'text' => 'Информация о разработчике сайта',
				'href' => '/index.php?route=information/information/developper'
			);
			
			$data['heading_title'] = 'Информация о разработчике сайта и использовании программного кода';

			$data['button_continue'] = $this->language->get('button_continue');
			
			$description = '<p style="text-align:justify;font-size:13px; padding:20px 0;">Данный сайт разработан индивидуальным предпринимателем Янковцом Алексеем Александровичем (свидетельство о государственной регистрации № 191268018 от 8 ноября 2016г.), далее - Разработчик, по договору №04102018 от 04.10.2018' . '<br>';
			$description .= 'Сайт содержит и использует в работе на каждой странице компьтерную программу, далее - Программа, автором которой является Разработчик.' . '<br>';
			$description .= 'Указанная Программа формирует визуальное отображение информационных блоков сайта и контента, получаемого из базы данных.' . '<br>';
			$description .= 'Авторские права на Программу принадлежат Разработчику.' . '<br>';
			$description .= 'Для использования Программы необходимо заключить с Разработчиком лицензионный договор.' . '<br>';
			$description .= 'Использование сайта с Программой Разработчика без лицензионного договора не допускается и является нарушением авторских прав Разработчика.' . '<br>';
			$description .= 'Копирование, изменение или удаление (отключение) Программы Разработчика возможно только с письменного согласия Разработчика.' . '<br>';
			$description .= 'В настоящее время Программа расположена на этом сайте в файле (путь от корня сайта): \catalog\view	heme\default\stylesheet\intamebel.css' . '<br>';
			$description .= 'Для проверки целостности и неизменности Программы необходимо использовать хеш-сумму (контрольную сумму SHA256) для указанного выше файла (hex): 7fbbb1918abe55db7c46e3a7b082e0fb40925c7e6a0556b2bc92ab1bb4c48214' . '</p>';
 
			$data['description'] =  $description ;

			$data['continue'] = $this->url->link('common/home');

		
		    $data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = false;
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('information/information', $data));
		
	}
			
	public function agree() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$output = '';

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
		}

		$this->response->setOutput($output);
	}
}