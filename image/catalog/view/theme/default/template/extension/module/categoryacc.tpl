<div class="list-group" id="accordion">
  <?php foreach ($categories as $category) { ?> 
  <a <?php if ($category['children']) { ?> <?php } else { ?>href="<?php echo $category['href']; ?>" <?php } ?> class="list-group-item accordion-toggle"><?php if($category['image']){ ?><img src="image/<?php echo $category['image']; ?>" ><?php } ?><?php echo $category['name']; ?></span><?php if ($category['children']) { ?><i class="fa fa-angle-right"></i><?php } ?></a>
  <?php if ($category['children']) { ?>
	  <div class="accordion-content">
	  <div></div>
	  <?php foreach ($category['children'] as $child) { ?>
	  <?php if ($child['category_id'] == $child_id) { ?>
	  <a href="<?php echo $child['href']; ?>" class="list-group-item list-group-subitem">&nbsp;&nbsp;&nbsp; <?php echo $child['name']; ?></a>
	  <?php } else { ?>
	  <a href="<?php echo $child['href']; ?>" class="list-group-item list-group-subitem">&nbsp;&nbsp;&nbsp; <?php echo $child['name']; ?></a>
	  <?php } ?>
	  <?php } ?>
	  </div>
  <?php } else { ?>
  <div></div>
  <?php } ?>
  <?php } ?>
</div>
<style>
.accordion-content {display:none;}
.accordion-toggle img {width:36px;height:36px;margin-right:5px;}
.accordion-toggle i {float:right;margin-top:10px;-o-transition:all 200ms ease;-moz-transition:all 200ms ease;-khtml-transition:all 200ms ease;-webkit-transition:all 200ms ease;transition:all 200ms ease;}
.accordion-content a:last-child {border-radius:0;border-bottom:none!important;}
.fa-acc-rotating {-moz-transform: rotate(90deg);-ms-transform: rotate(90deg);-webkit-transform: rotate(90deg);-o-transform: rotate(90deg);transform: rotate(90deg);-o-transition:all 200ms ease;-moz-transition:all 200ms ease;-khtml-transition:all 200ms ease;-webkit-transition:all 200ms ease;transition:all 200ms ease;}
</style>
<script type="text/javascript">
  $(document).ready(function($) {
    $('#accordion').find('.accordion-toggle').click(function(){
      $(this).next().slideToggle('fast');
	  $('.fa-acc-rotating').removeClass('fa-acc-rotating');
	  $(".accordion-content").not($(this).next()).slideUp('fast');
	  $(this).find('i').toggleClass('fa-acc-rotating');
    });
  });
</script>