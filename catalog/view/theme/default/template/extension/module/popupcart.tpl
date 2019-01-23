<div id="popupcart_extended">   
	<div class="head"><?php echo $head; ?><i class="fa fa-close" onclick="$('#popupcart_extended').popup('hide')" ></i></div>
	<?php if ($products || $vouchers) { ?>
		<div class="popupcart_info">
			<table>
				<tr>
					<td class="image"><?php echo $text_foto; ?></td>
					<td class="name"><?php echo $text_name ?></td>
					<?php if ($manufacturer_show) { ?>
						<td class="brand"><?php echo $text_manufacturer; ?></td>
					<?php } ?>
					<td class="quantity"><?php echo $text_quantity; ?></td>
					<td class="price"><?php echo $text_price; ?></td>
					<td></td>
				</tr>
				<tr class="hr"><td colspan="6"></td></tr>
				<?php foreach ($products as $key => $product) { ?>
					<tr class="row_<?php echo $key; ?>_<?php echo $product['id']; ?>">
						<td class="image">
							<?php if ($product['thumb']) { ?>
								<img src="<?php echo $product['thumb']; ?>" onclick="location='<?php echo $product['href']; ?>'" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
							<?php } ?>
						</td>
						<td class="name">
							<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
							<div>
								<?php foreach ($product['option'] as $option) { ?>
									- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
								<?php } ?>
							</div>
							<?php if (!$product['stock']) { ?>
								<?php if ($product['quantity'] >= $product['maximum']) { ?>
									<span style="font-size:10px; color:#f00;"><?php echo $in_stock; ?> <?php echo ($product['maximum'] > 1) ? $left : $left1; ?> <?php echo $just; ?> <?php echo $product['maximum']; ?> <?php echo $pcs; ?></span>
								<?php } ?>
							<?php } ?>
						</td>
						<?php if ($manufacturer_show) { ?>
							<td class="brand"><?php echo $product['manufacturer']; ?></td>
						<?php } ?>
						<td class="quantity">
							<div>
								<input type="text" name="<?php echo $product['key']; ?>" size="2" value="<?php echo $product['quantity']; ?>" onchange="updateCart('<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>')" />
								<span>
									<?php if (!$product['stock']) { ?>
										<?php if ($product['quantity'] < $product['maximum']) { ?>
											<i class="fa fa-plus" onclick="updateCart('<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '+')"></i>
										<?php } else { ?>
											<i class="fa fa-plus" style="opacity:0.5; cursor:default"></i>
										<?php } ?>
									<?php } else { ?>
										<i class="fa fa-plus" onclick="updateCart('<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '+')"></i>
									<?php } ?>
									<i class="fa fa-minus" onclick="updateCart('<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '-')"></i>
								</span>
							</div>
						</td>
						<td class="price"><?php echo $product['total']; ?></td>
						<td class="remove"><i class="fa fa-trash-o" title="<?php echo $button_remove; ?>" onclick="$(this).parent().prev().prev().find('input').val(''); updateCart('<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>')" ></i></td>
					</tr>
					<tr class="hr"><td colspan="6"></td></tr>
				<?php } ?>
			</table>
		</div>
		<div class="popupcart_total">
			<table>
				<?php foreach($totals as $total) { ?>
					<tr>
						<td class="right"><?php echo $total['title']; ?></td> <td class="right"><?php echo $total['text']; ?></td>
					</tr>
				<?php } ?>
			</table>
		</div>
		<div class="popupcart_buttons">
			<?php if($button_shopping_show) { ?>
				<button type="button" class="button btn btn-primary btn-lg" onclick="$('#popupcart_extended').popup('hide')" ><?php echo $button_shopping; ?></button>
			<?php } else { ?>
				<a class="continue" onclick="$('#popupcart_extended').popup('hide')"><?php echo $button_shopping; ?></a>
			<?php } ?>
			<?php if ($button_cart_show) { ?>
				<button type="button" class="cont button btn btn-primary btn-lg" onclick="location='<?php echo $cart; ?>'" ><?php echo $button_cart; ?></button>
			<?php } ?>
			<button type="button" class="button btn btn-primary btn-lg" onclick="location='<?php echo $checkout; ?>'"><?php echo $button_checkout; ?></button>
		</div>
		<?php if($related && isset($products_related)) { ?>
			<div id="related">
				<div class="heading"><?php echo $text_related; ?></div>
				<div class="related_product">
					<?php foreach ($products_related as $product) { ?>
						<div>
							<?php if ($product['thumb']) { ?>
								<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
							<?php } ?>
							<div>
								<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
								<?php if ($product['price']) { ?>
									<div class="price">
										<?php if (!$product['special']) { ?>
											<?php echo $product['price']; ?>
										<?php } else { ?>
											<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
										<?php } ?>
									</div>
								<?php } ?>
								<div class="cart"><a onclick="cart.add('<?php echo $product['product_id']; ?>', 1, 1);" class="button btn btn-primary"><i class="fa fa-shopping-cart"></i></a></div>
							</div>
						</div>
					<?php } ?>
				</div>
			</div>
		<?php } ?>
	<?php } else { ?>
		<div class="empty"><?php echo $text_empty; ?></div>
	<?php } ?>
	<input type="hidden" name="addtocart_logic" value="<?php echo $addtocart_logic; ?>" />
	<input type="hidden" name="click_on_cart" value="<?php echo $click_on_cart; ?>" />
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('#popupcart_extended').popup({transition: 'all 0.3s',	scrolllock: true});	
});

function carousel () {
	$('.related_product').owlCarousel({
		responsiveBaseWidth: '.related_product',
		navigation: true,
		slideSpeed: 200,
		paginationSpeed: 300,
		touchDrag: true,
		mouseDrag: false,
		navigationText: ['&lt;', '&gt;'],
		pagination: false,
	});
}

function p_array() {
	<?php foreach ($products as $product) { ?>
		<?php if($product['option']) { ?>
			replace_button('<?php echo $product['id']; ?>', 1);
		<?php } else { ?>
			replace_button('<?php echo $product['id']; ?>', 0);
		<?php } ?>
	<?php } ?>
}

function replace_button(product_id, options){
	if(options && $('.'+product_id).attr('id') == 'button-cart') {
		var text = '<?php echo $button_incart_with_options; ?>';
	} else {
		var text = '<?php echo $button_incart; ?>';
	}
	<?php if($button_incart_logic) { ?>
		$('html, body').find('.'+product_id).val(text).text(text).addClass('in_cart');
	<?php } else { ?>
		if(options) {
			$('html, body').find('.'+product_id).val(text).text(text).addClass('in_cart');
		} else {
			$('html, body').find('.'+product_id).attr('onclick', '$(\'#popupcart_extended\').popup(\'show\');').val(text).text(text).addClass('in_cart');
		}
	<?php } ?>
}
</script>