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
</body></html>