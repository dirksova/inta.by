<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <h5><?php echo $text_information; ?></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
         
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_extra; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
   
          <li><a href="<?php echo $special; ?>">Скидки</a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_account; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
        
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
    </div> 
  </div>
</footer>
 <div class="after_footer">
    <div class="container">
    <div class="row">
	  <div class="col-xs-12 col-md-2 "><div class="copyright"> @ <?=date('Y');?>. <?=$_SERVER['SERVER_NAME'];?></div></div>
	  <div class="col-xs-12 col-md-6 "><div class="copyright"><Владелец магазина: ООО "ИнТа Мебель", Свидетельство о регистрации №193140569 выдано Минским горисполкомом 24.09.2018, юр адрес г. Минск, ул. Тимирязева, д. 65а, пом. 430. Сведения внесены в Торговый Реестр Республики Беларусь 15 октября 2018 г.></div></div>
	  <div class="col-xs-12 col-md-4 "><div class="copyright"><a href="https://bepaid.by" target="_blanc"><img src="/image/bepaid.png" style="max-width:100%;"></a></div></div>
	</div>
	</div>
</div>

				<!-- ocmodpphone start //-->
				<div class="scroll-top-wrapper" onclick="scrollToTop()"><i class="fa fa-2x fa-arrow-circle-up"></i></div>
				<style>
				.scroll-top-wrapper {position:fixed;opacity:0;text-align:center;z-index:9998;background-color:#777;color:#fefefe;width:40px;height:40px;line-height:40px;right:30px;bottom:30px;border-radius:4px;-webkit-transition:all 0.3s ease-in-out;-moz-transition:all 0.3s ease-in-out;-ms-transition:all 0.3s ease-in-out;-o-transition:all 0.3s ease-in-out;transition:all 0.3s ease-in-out;}
				.scroll-top-wrapper i.fa {line-height:inherit;font-size:18px;}
				.scroll-top-wrapper.show {cursor:pointer;opacity:0.6;right:30px;bottom:80px;}
				</style>
				<link href="catalog/view/theme/default/stylesheet/ocmodbtotop.css" rel="stylesheet" media="screen"/>
				<script type="text/javascript"><!--
				$(document).on( 'scroll', function(){
					if ($(window).scrollTop() > 100) {
						$('.scroll-top-wrapper').addClass('show');
					} else {
						$('.scroll-top-wrapper').removeClass('show');
					}
				});
				function scrollToTop() {
					verticalOffset = typeof(verticalOffset) != 'undefined' ? verticalOffset : 0;
					element = $('body');
					offset = element.offset();
					offsetTop = offset.top;
					$('html, body').animate({scrollTop: offsetTop}, 200, 'linear');
				};
				//--></script>
				<!-- ocmodpphone stop //-->
			

        <?php
          $customer_groups = isset($smca_form_data['customer_groups']) ? $smca_form_data['customer_groups'] : array();
          $stores = isset($smca_form_data['stores']) ? $smca_form_data['stores'] : array();
        ?>
        <?php if ($smca_form_data['activate'] && !in_array($smca_customer_group_id, $customer_groups) && !in_array($smca_store_id, $stores)) { ?>
        <!-- <?php echo $smca_form_data['front_module_name'].':'.$smca_form_data['front_module_version']; ?> -->
        <script type="text/javascript">
          $(function() {
            $.ajax({
              type: 'get',
              url:  'index.php?route=extension/module/ocdev_smart_cart/cartProducts',
              dataType: 'json',
              success: function(json) {
                // one step
                $.each($("[onclick^='"+json['add_function_selector']+"']"), function() {
                  var product_id = $(this).attr('onclick').match(/[0-9]+/);
                    $(this)
                    .attr('onclick', 'getOCwizardModal_smca(\'' + $(this).attr('onclick').match(/[0-9]+/) + '\',\'' + 'add' + '\');')
                    .addClass('smca-call-button');
                });
                var product_id_in_page = $("input[name='product_id']").val();
                  $('#'+json['add_id_selector'])
                  .unbind('click')
                  .attr('onclick', 'getOCwizardModal_smca(\'' + product_id_in_page + '\',\'' + 'add_option' + '\');');
                // two step
                if (json['cart_products']) {
                  $.each(json['cart_products'], function(i,value) {
                    $('[onclick="getOCwizardModal_smca(\'' + value + '\',\'' + 'add' + '\');"]')
                    .html('<i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md">' + json['text_in_cart'] + '</span>')
                    .attr('onclick', 'getOCwizardModal_smca(\'' + value + '\',\'' + 'load' + '\');');
                    $('[onclick="getOCwizardModal_smca(\'' + value + '\',\'' + 'add_option' + '\');"]')
                    .html(json['text_in_cart'])
                    .attr('onclick', 'getOCwizardModal_smca(\'' + value + '\',\'' + 'load_option' + '\');');
                  });
                }
                if (json['cart_products_vs_options']) {
                  $.each(json['cart_products_vs_options'], function(i,value) {
                    $('[onclick="getOCwizardModal_smca(\'' + value + '\',\'' + 'add' + '\');"]')
                    .html('<i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md">' + json['text_in_cart'] + '</span>');
                    $('[onclick="getOCwizardModal_smca(\'' + value + '\',\'' + 'add_option' + '\');"]')
                    .html(json['text_in_cart_vs_options']);
                  });
                }
              }
            });
          });
          function getOCwizardModal_smca(product_id, action) {
            quantity = typeof(quantity) != 'undefined' ? quantity : 1;
            if (action == "add") {
              $.ajax({
                url: 'index.php?route=checkout/cart/add',
                type: 'post',
                data: 'product_id=' + product_id + '&quantity=' + quantity,
                dataType: 'json',
                success: function(json) {
                  if (json['redirect']) {
                    location = json['redirect'];
                  }
                  if (json['success']) {
                    buttonManipulate();
                    getOCwizardModal_smca(product_id,'load');
                    $('#cart-total').html(json['total']);
                  }
                }
              });
            }

            if (action == "load" || action == "load_option") {
              $.magnificPopup.open({
                tLoading: '<img src="catalog/view/theme/default/stylesheet/ocdev_smart_cart/loading.svg" alt="" />',
                items: {
                  src: 'index.php?route=extension/module/ocdev_smart_cart',
                  type: 'ajax'
                },
                showCloseBtn: false
              });
              $('.mfp-bg').css({
                'background': 'url(image/ocdev_smart_cart/background/<?php echo $smca_form_data['style_beckground']; ?>)',
                'opacity': '<?php echo ($smca_form_data['background_opacity'] == 0) ? $smca_form_data['background_opacity'] : $smca_form_data['background_opacity']/10; ?>'
              });
            }

            if (action == "add_option") {
              $.ajax({
                url: 'index.php?route=checkout/cart/add',
                type: 'post',
                data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
                dataType: 'json',
                beforeSend: function() {
                  $('#button-cart').button('loading');
                },
                complete: function() {
                  $('#button-cart').button('reset');
                },
                success: function(json) {
                  $('.alert, .text-danger').remove();
                  $('.form-group').removeClass('has-error');

                  if (json['error']) {
                    if (json['error']['option']) {
                      for (i in json['error']['option']) {
                        var element = $('#input-option' + i.replace('_', '-'));

                        if (element.parent().hasClass('input-group')) {
                          element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                        } else {
                          element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                        }
                      }
                    }
                    $('.text-danger').parent().addClass('has-error');
                  }
                  if (json['success']) {
                    buttonManipulate();
                    getOCwizardModal_smca(product_id, 'load_option');
                    $('#cart-total').html(json['total']);
                  }
                }
              });
            }
          }
        </script>
        <!-- <?php echo $smca_form_data['front_module_name'].':'.$smca_form_data['front_module_version']; ?> -->
        <?php } ?>
      
</body></html>