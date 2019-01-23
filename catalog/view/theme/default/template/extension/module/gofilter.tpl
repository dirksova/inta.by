<?php if ($on_category) { ?>
<div class="options<?php if ($get_category_id) { ?> filter_category_page<?php } ?>" id="home_filter">
<div class="btn-white margin-bottom">
<div class="filter">
<form action="index.php?" method="get" id="filter_send">
<input type="hidden" name="route" value="product/category" />
<?php if ($page_category and $page_category != "" or $category_id) { ?>
<input type="hidden" name="path" value="<?php echo $category_id; ?>" />
<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" class="categ" />
<?php } ?>
<?php if (isset($parent_category_hierarchy['category_id'])) { ?>
<input type="hidden" name="parent_category_hierarchy" value="<?php echo $parent_category_hierarchy['category_id']; ?>" checked id="parent_category_hierarchy" />
<input type="hidden" name="parent_category_hierarchy_name" value="<?php echo $parent_category_hierarchy['name_hierarchy']; ?>" checked id="parent_category_hierarchy_name" />
<?php } ?>
<?php $popup_on = true;?>
<?php if (isset($keywords_filter_text) and $keywords_filter_text != "") { ?><input type="hidden" name="keywords_filter" value="<?php echo $keywords_filter_text; ?>" /><?php } ?>
<?php if (isset($max_price_const) or $old_price) { ?><input type="hidden" name="op" value="<?php if (isset($max_price_const)) {echo $max_price_const;} else {echo $old_price;} ?>" class="filter_op" /><?php } ?>
<?php $drop_option = true; $drop_attributes = true; ?>
<?php
	if (isset($popup_view)) {$popup_on = false;}
	if (!isset($max_height)) {$max_height = '215';}
	if (!isset($count_show)) {$count_show = 3;}
	if (isset($status_seo)) {$seo_on = $status_seo;} else {$seo_on = false;}
	if (!isset($seo_separator)) {$seo_separator = "=";}
?>
<?php foreach ($currencies as $currency) { ?>
	<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
		<?php $value_max_currency_left = $currency['symbol_left']; ?>
	<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
		<?php $value_max_currency_right = $currency['symbol_right']; ?>
	<?php } ?>
<?php } ?>
<div id="option_filter">
	<?php if ($name_module and $name_module != "") { ?><h3 class="col-sm-12"><i class="fa fa-filter"></i>&nbsp;&nbsp;&nbsp;<?php echo $name_module; ?></h3><?php } ?>
	<div class="clearfix">
	<div class="options_container_filter col-sm-12">
	<div class="clearfix"></div>
	<div class="options_container filter_container">
		<?php if ($category_id) { ?><a class="btn btn-white category_filt" onclick="<?php if (!$post_category_id) { ?><?php if ($category_type=="radio" or $category_type=="link") { ?>live_option_product('category_filter', 'options', '', '');<?php } else { ?>live_home_clear_category_filter(<?php echo $category_id; ?>)<?php } ?><?php } else { ?>live_home_clear_category_filter(<?php echo $old_category_id;; ?>)<?php } ?>"><span class="pull-left"><?php echo $category_name; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a><?php } ?>
		<?php if ($get_price_max and isset($max_price_const)) { ?>
			<?php if ($get_price_max > $max_price_const) {
				if (isset($max_price_const)) {$test_price = $max_price_const;}
			} else {
				if (isset($get_price_max)) {$test_price = $get_price_max;}
			} ?>
			<?php if ($test_price != $max_price_const or $get_price_min != 0) { ?>
				<?php foreach ($currencies as $currency) { ?>
					<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
						<?php $value_max_currency = $currency['symbol_left']; ?>
					<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
						<?php $value_max_currency = $currency['symbol_right']; ?>
					<?php } ?>
				<?php } ?>
				<a class="btn btn-white option_cloud_price" onclick="slider_generation('0','<?php echo $max_price_const; ?>','clear'); clear_popup_filter();"><span class="pull-left"><?php echo $text_price; ?> <?php if (isset($min_price)) {echo $min_price;} ?> - <?php if ($get_price_max > $max_price_const) {if (isset($max_price_const)) {echo $max_price_const;}} else {if (isset($max_price)) {echo $max_price;}} ?> <?php if (isset($value_max_currency)) {echo $value_max_currency;} ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
			<?php } ?>
		<?php } ?>
		<?php if (isset($manufacturers)) { ?>
			<?php $n = 2000; ?>
			<?php foreach ($manufacturers as $manufacturer) { ?>
				<?php if ($manufacturer['manufacturer_value_required']) { ?>
					<a class="btn btn-white option_cloud<?php echo $n; ?><?php echo $manufacturer['manufacturer_id']; ?>" onclick="<?php if ($manufacturers_type == 'radio') { ?>live_option_product('manufacturers_filter', 'options', '', '');<?php } else { ?>live_home_clear_manufacturers_filter(<?php echo $manufacturer['manufacturer_id']; ?>);<?php } ?>"><span class="pull-left"><?php echo $manufacturer['name']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
				<?php } ?>
				<?php $n = $n + 1; ?>
			<?php } ?>
		<?php } ?>
		<?php $k = 1; ?>
		<?php if (isset($keywords_filter)) { ?>
			<?php foreach ($keywords_filter as $keywords_value => $value) { ?>
				<?php if ($value != "") { ?>
					<a class="btn btn-white option_cloud_keywords<?php echo $k ?>" onclick="live_home_clear_keywords_filter('<?php echo $value; ?>', <?php echo $k ?>);" data-value="<?php echo $value; ?>"><span class="pull-left"><?php echo $value; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
				<?php } ?>
				<?php $k = $k + 1; ?>
			<?php } ?>
		<?php } ?>
		<?php if (isset($stock_statuses)) { ?>
			<?php foreach ($stock_statuses as $stock_status) { ?>
				<?php if ($stock_status['stock_status_value_required']) { ?>
					<a class="btn btn-white option_cloud<?php echo $stock_status['status_id']; ?>" onclick="<?php if ($status_stock_type == 'radio') { ?>live_option_product('stock_status_filter', 'options', '', '');<?php } else { ?>live_home_clear_stock_filter('<?php echo $stock_status['status_id']; ?>');<?php } ?>"><span class="pull-left"><?php echo $stock_status['name']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($options) { ?>
			<?php foreach ($options as $option) { ?>
				<?php foreach ($option['option_value'] as $option_value) { ?>
					<?php if ($option_value['option_value_required']) { ?>
						<a class="btn btn-white option_cloud<?php echo $option_value['option_value_id']; ?>" onclick="live_home_clear_option_filter(<?php echo $option_value['option_value_id']; ?>);"><span class="pull-left"><?php echo $option['name'] . ": " . $option_value['option_value_name']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($filters) { ?>
			<?php foreach ($filters as $filter) { ?>
				<?php foreach ($filter['filter'] as $filter_value) { ?>
					<?php if ($filter_value['filter_value_required']) { ?>
						<a class="btn btn-white option_cloud<?php echo $filter_value['filter_id']; ?>" onclick="live_home_clear_filter_filter(<?php echo $filter_value['filter_id']; ?>);"><span class="pull-left"><?php echo $filter['name'] . ": " . $filter_value['name']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($attributes) { ?>
			<?php $m = 1000; ?>
			<?php foreach ($attributes as $attribute) { ?>
                <?php if ($attribute['attribute_show_required']) { ?>
    				<?php foreach ($attribute['attribute'] as $attribute_text) { ?>
                        <?php if ($attribute_text['attribute_value_required'] and $attribute_text['attribute_stock_required']) { ?>
    						<a class="btn btn-white option_cloud<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>" onclick="live_home_clear_attributes_filter(<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>);"><span class="pull-left"><?php echo $attribute['name'] . ": " . $attribute_text['text']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
    					<?php } ?>
    					<?php $m = $m + 1; ?>
    				<?php } ?>
                <?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($options or $attributes or $prices_max_value) {} else { ?>
			<span class="clearfix">
				<?php if ($prices_max_value) { ?><?php echo $text_option_no_empty; ?><?php } ?>
			</span>
		<?php } ?>
		<?php if (isset($ratings)) { ?>
			<?php foreach ($ratings as $rating) { ?>
				<?php if ($rating['rating_value_required']) { ?>
					<a class="btn btn-white option_cloud<?php echo $rating['rating']; ?>" onclick="<?php if ($ratings_type == 'radio') { ?>live_option_product('rating_filter', 'options', '', '');<?php } else { ?>live_home_clear_rating_filter(<?php echo $rating['rating']; ?>);<?php } ?>">
					<span class="rating">
						<?php for ($i = 1; $i <= 5; $i++) { ?>
							<?php if ($rating['rating'] < $i) { ?>
								<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
							<?php } else { ?>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
							<?php } ?>
						<?php } ?>
					</span>
					&nbsp;&nbsp;<i class="fa fa-times pull-right"></i></a>
				<?php } ?>
			<?php } ?>
		<?php } ?>
	</div>
	</div>
	<?php foreach($type_filters as $type_filter => $value) { ?>
		<?php if ($view_categories) { ?>
			<?php if ($value == "categories") { ?>
				<?php if ($status_category) { ?>
					<?php if (isset($categories)) { ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_categories == "column") { ?> column_filt<?php if ($go_mobile) { ?> column_mobile<?php } ?><?php } ?><?php if ($view_categories == "content") { ?> content_filt<?php } ?><?php if ($collapse_category == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_category == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_category == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_category; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php if ($category_type == 'link') { ?>
								<div class="checkbox-group-overflow categories_filter">
									<?php if (isset($parent_category_id)) { ?>
										<div class="radio">
											<input type="hidden" name="parent_category_hierarchy" value="<?php echo $parent_category_hierarchy['category_id']; ?>" checked id="parent_category_hierarchy" />
											<?php if ($old_category_id) { ?>
												<a class="category_filter">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked id="common_category" />
													<input type="radio" name="category_id" value="<?php echo $old_category_id; ?>" id="option-value-category-<?php echo $old_category_id; ?>" />
													<label for="option-value-category-<?php echo $old_category_id; ?>">
														<?php echo $parent_category_hierarchy['name']; ?>
													</label>
												</a>
											<?php } else { ?>
												<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked id="common_category" />
												<a class="category_filter" onclick="live_option_product('category_filter', 'options', '', 'no_popup');">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="old_category_id" value="<?php echo $parent_category_hierarchy['category_id']; ?>" id="" />
													<label for="option-value-category-<?php echo $parent_category_hierarchy['category_id']; ?>">
														<?php echo $parent_category_hierarchy['name']; ?>
													</label>
												</a>
											<?php } ?>
										</div>
									<?php } ?>
									<?php foreach ($categories as $category) { ?>
										<?php if ($category['category_stock_required'] or isset($parent_category_id)) { ?>
											<div class="radio<?php if (!$category['category_stock_required']) { ?> not-active-link<?php } ?>">
												<a class="category_filter"><input type="radio"<?php if ($category['category_value_required']) { ?> checked<?php } ?> name="category_id" value="<?php echo $category['category_id']; ?>" data-category="category-<?php echo $category['category_id']; ?>" id="option-value-category-<?php echo $category['category_id']; ?>"<?php if (!$category['category_stock_required']) { ?> disabled<?php } ?> /><?php if ($category['category_value_required']) { ?><i class="fa fa-check pull-left"></i><?php } ?>
													<label for="option-value-category-<?php echo $category['category_id']; ?>">
														<?php echo $category['name']; ?>
														<?php if ($category['category_value_required']) { ?>
															<i class="fa fa-close pull-right" onclick="live_home_filter();"></i>
														<?php } else { ?>
															<?php if ($category['total'] and $quantity_view) { ?><span class="filter_total"><?php echo $category['total']; ?></span><?php } else { ?><span class="filter_total filter_gray">0</span><?php } ?>
														<?php } ?>
													</label>
												</a>
											</div>
										<?php } ?>
									<?php } ?>
									<div><span id="popup_categories"></span></div>
								</div>
							<?php } ?>
							<?php if ($category_type == 'select') { ?>
								<?php if (isset($parent_category_id)) { ?>
									<div class="radio select_filter">
										<input type="hidden" name="parent_category_hierarchy" value="<?php echo $parent_category_hierarchy['category_id']; ?>" checked id="parent_category_hierarchy" />
										<?php if ($old_category_id) { ?>
											<a class="category_filter">
												<i class="fa fa-reply-all pull-left"></i>
												<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked id="common_category" />
												<input type="radio" name="category_id" value="<?php echo $old_category_id; ?>" id="option-value-category-<?php echo $old_category_id; ?>" />
												<label for="option-value-category-<?php echo $old_category_id; ?>">
													<?php echo $parent_category_hierarchy['name']; ?>
												</label>
											</a>
										<?php } else { ?>
											<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked id="common_category" />
											<a class="category_filter" onclick="live_option_product('category_filter', 'options', '', 'no_popup');">
												<i class="fa fa-reply-all pull-left"></i>
												<input type="hidden" name="old_category_id" value="<?php echo $parent_category_hierarchy['category_id']; ?>" id="" />
												<label for="option-value-category-<?php echo $parent_category_hierarchy['category_id']; ?>">
													<?php echo $parent_category_hierarchy['name']; ?>
												</label>
											</a>
										<?php } ?>
									</div>
								<?php } ?>
								<div class="select-group">
									<select name="category_id" id="category-option" class="form-control">
										<option value="" id="common_category"><?php echo $text_select; ?></option>
										<?php foreach ($categories as $category) { ?>
											<?php if ($category['category_stock_required']) { ?>
											<option value="<?php echo $category['category_id']; ?>" <?php if (!$category['category_stock_required']) { ?> disabled<?php } ?> <?php if ($category['category_value_required']) { ?> selected<?php } ?>><?php echo $category['name']; ?><?php if ($category['total'] and $quantity_view) { ?> (<?php echo $category['total']; ?>)<?php } else { ?> (0)<?php } ?></option>
											<?php } ?>
										<?php } ?>
									</select>
									<div><span id="popup_categories"></span></div>
								</div>
							<?php } ?>
							<?php if ($category_type == 'radio') { ?>
								<div class="checkbox-group-overflow categories_filter">
									<?php if (isset($parent_category_id)) { ?>
										<div class="radio">
											<input type="hidden" name="parent_category_hierarchy" value="<?php echo $parent_category_hierarchy['category_id']; ?>" checked id="parent_category_hierarchy" />
											<?php if ($old_category_id) { ?>
												<a class="category_filter">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked id="common_category" />
													<input type="radio" name="category_id" value="<?php echo $old_category_id; ?>" id="option-value-category-<?php echo $old_category_id; ?>" />
													
													<label for="option-value-category-<?php echo $old_category_id; ?>">
														<?php echo $parent_category_hierarchy['name']; ?>
													</label>
												</a>
											<?php } else { ?>
												<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked id="common_category" />
												<a class="category_filter" onclick="live_option_product('category_filter', 'options', '', 'no_popup');">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="old_category_id" value="<?php echo $parent_category_hierarchy['category_id']; ?>" id="" />
													<label for="option-value-category-<?php echo $parent_category_hierarchy['category_id']; ?>">
														<?php echo $parent_category_hierarchy['name']; ?>
													</label>
												</a>
											<?php } ?>
										</div>
									<?php } ?>
									<?php foreach ($categories as $category) { ?>
										<?php if ($category['category_stock_required'] or isset($parent_category_id)) { ?>
											<div class="radio">
											  <input type="radio"<?php if ($category['category_value_required']) { ?> checked<?php } ?> name="category_id" value="<?php echo $category['category_id']; ?>" data-category="category-<?php echo $category['category_id']; ?>" id="option-value-category-<?php echo $category['category_id']; ?>"<?php if (!$category['category_stock_required']) { ?> disabled<?php } ?> />
											  <label for="option-value-category-<?php echo $category['category_id']; ?>">
												<?php echo $category['name']; ?>
												<?php if ($category['category_value_required']) { ?>
													<i class="fa fa-close" onclick="live_option_product('category_filter', 'options', '', '');"></i>
												<?php } else { ?>
													<?php if ($category['total'] and $quantity_view) { ?><span class="filter_total"><?php echo $category['total']; ?></span><?php } else { ?><span class="filter_total filter_gray">0</span><?php } ?>
												<?php } ?>
											  </label>
											</div>
										<?php } ?>
									<?php } ?>
									<div><span id="popup_categories"></span></div>
								</div>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if (isset($max_price_const) or $old_price) { ?>
			<?php if ($view_prices) { ?>
				<?php if ($value == "prices") { ?>
					<?php if ($status_price) { ?>
						<div class="checkbox-group-price btn-border col-sm-12<?php if ($view_prices == "column") { ?> column_filt<?php if ($go_mobile) { ?> column_mobile<?php } ?><?php } ?><?php if ($view_prices == "content") { ?> content_filt<?php } ?><?php if ($collapse_price == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_price == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_price == 0) { ?> hidden-sm<?php } ?>">
							<div class="checkbox-group-overflow-price<?php if ($view_prices == "column") { ?> column_filt<?php } ?><?php if ($view_prices == "content") { ?> content_filt<?php } ?>">
								<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.formCost.checkbox').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_range_price; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
								<div class="formCost checkbox">
									 <?php if (isset($value_max_currency_left)) { ?><label class="pull-left"><?php if (isset($value_max_currency_left)) {echo $value_max_currency_left;} ?></label><?php } ?><input type="text" name="prices_min_value" id="minCost" value="<?php if (isset($min_price)) {echo $min_price;} ?>" class="pull-left form-control" /><label class="pull-left"><?php if (isset($value_max_currency_right)) {echo $value_max_currency_right;} ?>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;</label>
									 <?php if (isset($value_max_currency_left)) { ?><label class="pull-left"><?php if (isset($value_max_currency_left)) {echo $value_max_currency_left;} ?></label><?php } ?><input type="text" name="prices_max_value" id="maxCost" value="<?php if (isset($max_price_const)) {if ($get_price_max > $max_price_const) {if (isset($max_price_const)) {echo $max_price_const;}} else {if (isset($max_price)) {echo $max_price;}} } else {echo $prices_max_value;} ?>" class="pull-left form-control" /> <?php if (isset($value_max_currency_right)) { ?><label for="maxCost" class="pull-left"><?php echo $value_max_currency_right; ?></label><?php } ?>
									<div class="clearfix"><div id="formCost_popup"></div></div>
									<div class="clearfix"></div><br />
									<div class="col-sm-12"><div class="slider"></div></div>
								</div><div class="clearfix"></div>
							</div>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_keywords_filter) { ?>
			<?php if ($value == "keywords_filter") { ?>
				<?php if ($status_keywords) { ?>
					<?php if (isset($max_price_const)) { ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_keywords_filter == "column") { ?> column_filt<?php } ?><?php if ($view_keywords_filter == "content") { ?> content_filt<?php } ?><?php if ($collapse_keywords == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_keywords == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_keywords == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_keywords; ?></strong><i class="fa fa-caret-down pull-right"></i></h4></div>
							<div class="select-group">
								<div id="keywords_filter" class="input-group select-group">
								  <input type="text" id="keywords_filter_input" name="keywords_filter" value="<?php if (isset($keywords_filter_text)) {echo $keywords_filter_text;} ?>" placeholder="<?php if ($delimitier == " ") {echo $text_keywords_placeholder;} ?><?php if ($delimitier == ",") {echo $text_keywords_placeholder_zap;} ?>" class="form-control" />
								  <span class="input-group-btn">
									<button type="button" class="btn"><i class="fa fa-search"></i></button>
								  </span>
								</div>
							</div>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_manufacturers) { ?>
			<?php if ($value == "manufacturers") { ?>
				<?php if ($status_manufacturers) { ?>
					<?php if (isset($manufacturers)) { ?>
						<?php if ($view_manufacturers == "column") {$sort_manufacturers = array(); foreach ($manufacturers as $key => $value) {$sort_manufacturers[$key] = $value['manufacturers_stock_required'];} array_multisort($sort_manufacturers, SORT_DESC, $manufacturers);} ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_manufacturers == "column") { ?> column_filt<?php } ?><?php if ($view_manufacturers == "content") { ?> content_filt<?php } ?><?php if ($collapse_manufacturers == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_manufacturers == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_manufacturers == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_manufacturers; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php $count = 0; ?>
							<?php $coun_end = 0; ?>
							<?php $count_group = 100; ?>
							<?php if ($manufacturers_type == 'checkbox') { ?>
								<div class="checkbox-group-overflow">
								<?php $test_checked = 0; foreach ($manufacturers as $manufacturer) {if ($manufacturer['manufacturer_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($manufacturers as $manufacturer) { ?>
									<?php $count = $count + 1; ?>
										<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="checkbox"name="manufacturers_filter[]" value="<?php echo $manufacturer['manufacturer_id']; ?>"<?php if ($manufacturer['manufacturer_value_required']) { ?> checked<?php } ?> data-manufacturers="manufacturers-<?php echo $manufacturer['manufacturer_id']; ?>" id="option-value-manufacturers-<?php echo $manufacturer['manufacturer_id']; ?>"<?php if (!$manufacturer['manufacturers_stock_required'] and !$manufacturer['manufacturer_value_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-manufacturers-<?php echo $manufacturer['manufacturer_id']; ?>">
											<?php if ($manufacturer['image'])  { ?><img src="<?php echo $manufacturer['image']; ?>" alt="" title="" /><?php } ?>
											<?php echo $manufacturer['name']; ?>
											<?php if ($manufacturer['manufacturer_value_required']) { ?>
												<?php if ($manufacturer['manufacturers_stock_required']) { ?>
													<i class="fa fa-close pull-right"></i>
												<?php } ?>
											<?php } else { ?>
												<?php if ($manufacturer['manufacturer_value_total'] and $quantity_view) { ?><span class="filter_total"><?php if ($manufacturer['manufacturers_stock_or']) { ?>+<?php } ?><?php echo $manufacturer['manufacturer_value_total']; ?></span><?php } else { ?><span class="filter_total filter_gray">0</span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
							<?php if ($manufacturers_type == 'select') { ?>
								<div class="select-group">
								   <div class="checkbox">
										<select name="manufacturers_filter[]" id="manufacturers-option" class="form-control">
											<option value="" id="common_manufacturers"><?php echo $text_select; ?></option>
											<?php $test_checked = 0; foreach ($manufacturers as $manufacturer) {if ($manufacturer['manufacturer_value_required']) {$test_checked = $test_checked + 1;}} ?>
											<?php foreach ($manufacturers as $manufacturer) { ?>
												<option value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if ($manufacturer['manufacturer_value_required']) { ?> selected<?php } ?><?php if (!$manufacturer['manufacturers_stock_required']) { ?> disabled<?php } ?>><?php echo $manufacturer['name']; ?><?php if ($manufacturer['manufacturer_value_total'] and $quantity_view) { ?> (<?php echo $manufacturer['manufacturer_value_total']; ?>)<?php } ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							<?php } ?>
							<?php if ($manufacturers_type == 'radio') { ?>
								<div class="checkbox-group-overflow">
									<?php $test_checked = 0; foreach ($manufacturers as $manufacturer) {if ($manufacturer['manufacturer_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($manufacturers as $manufacturer) { ?>
										<?php $count = $count + 1; ?>
										<div class="radio<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="radio"<?php if ($manufacturer['manufacturer_value_required']) { ?> checked<?php } ?> name="manufacturers_filter[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" data-manufacturer="manufacturer-<?php echo $manufacturer['manufacturer_id']; ?>" id="option-value-manufacturer-<?php echo $manufacturer['manufacturer_id']; ?>"<?php if (!$manufacturer['manufacturers_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-manufacturer-<?php echo $manufacturer['manufacturer_id']; ?>">
											<?php if ($manufacturer['image'])  { ?><img src="<?php echo $manufacturer['image']; ?>" alt="" title="" /><?php } ?>
											<?php echo $manufacturer['name']; ?>
											<?php if ($manufacturer['manufacturer_value_required']) { ?>
												<i class="fa fa-close pull-right" onclick="live_option_product('manufacturers_filter', 'options', '', '');"></i>
											<?php } else { ?>
												<?php if ($manufacturer['manufacturer_value_total'] and $quantity_view) { ?><span class="filter_total"><?php echo $manufacturer['manufacturer_value_total']; ?></span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_stock_statuses) { ?>
			<?php if ($value == "stock_statuses") { ?>
				<?php if ($status_stock) { ?>
					<?php if (isset($stock_statuses)) { ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_stock_statuses == "column") { ?> column_filt<?php } ?><?php if ($view_stock_statuses == "content") { ?> content_filt<?php } ?><?php if ($collapse_stock == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_stock == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_stock == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_stock_status; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php $count = 0; ?>
							<?php $coun_end = 0; ?>
							<?php $count_group = 200; ?>
							<?php if ($status_stock_type == 'checkbox') { ?>
								<div class="checkbox-group-overflow">
								<?php $test_checked = 0; foreach ($stock_statuses as $stock_status) {if ($stock_status['stock_status_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($stock_statuses as $stock_status) { ?>
										<?php $count = $count + 1; ?>
										<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="checkbox"<?php if ($stock_status['stock_status_value_required']) { ?> checked<?php } ?> name="stock_status_filter[]" value="<?php echo $stock_status['status_id']; ?>" data-stock="stock-<?php echo $stock_status['status_id']; ?>" id="option-value-stock-<?php echo $stock_status['status_id']; ?>" <?php if (!$stock_status['stock_status_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-stock-<?php echo $stock_status['status_id']; ?>">
											<?php echo $stock_status['name']; ?>
											<?php if ($stock_status['stock_status_value_required']) { ?>
												<?php if ($stock_status['stock_status_value_required']) { ?>
														<i class="fa fa-close pull-right" onclick="live_option_product('stock_status_filter', 'options', '', '');"></i>
													<?php } else { ?>
														<?php if ($stock_status['stock_status_value_total']) { ?><span class="filter_total filter_gray">0</span><?php } ?>
													<?php } ?>
												<?php } else { ?>
													<?php if ($stock_status['stock_status_value_total'] and $quantity_view) { ?><span class="filter_total"><?php if ($stock_status['stock_status_stock_or']) { ?>+<?php } ?><?php echo $stock_status['stock_status_value_total']; ?></span><?php } else { ?><span class="filter_total filter_gray">0</span><?php } ?>
												<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
							<?php if ($status_stock_type == 'select') { ?>
								<div class="select-group">
								   <div class="checkbox">
										<select name="stock_status_filter[]" id="stock_status-option" class="form-control">
											<option value="" id="common_stock_status"><?php echo $text_select; ?></option>
											<?php foreach ($stock_statuses as $stock_status) { ?>
												<option value="<?php echo $stock_status['status_id']; ?>" <?php if ($stock_status['stock_status_value_required']) { ?> selected<?php } ?><?php if (!$stock_status['stock_status_stock_required']) { ?> disabled<?php } ?>><?php echo $stock_status['name']; ?><?php if ($stock_status['stock_status_value_total'] and $quantity_view) { ?> (<?php echo $stock_status['stock_status_value_total']; ?>)<?php } ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							<?php } ?>
							<?php if ($status_stock_type == 'radio') { ?>
								<div class="checkbox-group-overflow">
									<?php foreach ($stock_statuses as $stock_status) { ?>
										<?php $count = $count + 1; ?>
										<div class="radio<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="radio"<?php if ($stock_status['stock_status_value_required']) { ?> checked<?php } ?> name="stock_status_filter[]" value="<?php echo $stock_status['status_id']; ?>" data-stock_status="stock_status-<?php echo $stock_status['status_id']; ?>" id="option-value-stock_status-<?php echo $stock_status['status_id']; ?>"<?php if (!$stock_status['stock_status_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-stock_status-<?php echo $stock_status['status_id']; ?>">
											<?php echo $stock_status['name']; ?>
											<?php if ($stock_status['stock_status_value_required']) { ?>
												<?php if ($stock_status['stock_status_value_required']) { ?>
													<i class="fa fa-close pull-right" onclick="live_option_product('stock_status_filter', 'options', '', '');"></i>
												<?php } else { ?>
													<?php if ($stock_status['stock_status_value_total']) { ?><span class="filter_total filter_gray">0</span><?php } ?>
												<?php } ?>
											<?php } else { ?>
												<?php if ($stock_status['stock_status_value_total'] and $quantity_view) { ?><span class="filter_total"><?php echo $stock_status['stock_status_value_total']; ?></span><?php } else { ?><span class="filter_total filter_gray">0</span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_ratings) { ?>
			<?php if ($value == "ratings") { ?>
				<?php if ($status_ratings) { ?>
					<?php if (isset($ratings)) { ?>
						<?php if ($view_ratings == "column") {$sort_ratings = array(); foreach ($ratings as $key => $value) {$sort_ratings[$key] = $value['ratings_stock_required'];} array_multisort($sort_ratings, SORT_DESC, $ratings);} ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_ratings == "column") { ?> column_filt<?php } ?><?php if ($view_ratings == "content") { ?> content_filt<?php } ?><?php if ($collapse_ratings == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_ratings == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_ratings == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_rating; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php $count = 0; ?>
							<?php $coun_end = 0; ?>
							<?php $count_group = 300; ?>
							<?php if ($ratings_type == 'checkbox') { ?>
								<div class="checkbox-group-overflow">
								<?php $test_checked = 0; foreach ($ratings as $rating) {if ($rating['rating_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($ratings as $rating) { ?>
										<?php $count = $count + 1; ?>
										<div class="checkbox<?php if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } ?>">
										  <input type="checkbox"<?php if ($rating['rating_value_required']) { ?> checked<?php } ?> name="rating_filter[]" value="<?php echo $rating['rating']; ?>" data-rating="<?php echo $rating['rating']; ?>" id="option-value-rating-<?php echo $rating['rating']; ?>"<?php if (!$rating['ratings_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-rating-<?php echo $rating['rating']; ?>">
											<span class="rating">
												<?php for ($i = 1; $i <= 5; $i++) { ?>
													<?php if ($rating['rating'] < $i) { ?>
														<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } else { ?>
														<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } ?>
												<?php } ?>
											</span>
											<?php if ($rating['rating_value_required']) { ?>
												<i class="fa fa-close pull-right"></i>
											<?php } else { ?>
												<?php if ($rating['rating_value_total'] and $quantity_view) { ?><span class="filter_total"><?php if ($rating['ratings_stock_or']) { ?>+<?php } ?><?php echo $rating['rating_value_total']; ?></span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
							<?php if ($ratings_type == 'radio') { ?>
								<div class="checkbox-group-overflow">
									<?php foreach ($ratings as $rating) { ?>
										<?php $count = $count + 1; ?>
										<div class="radio<?php if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } ?>">
										  <input type="radio"<?php if ($rating['rating_value_required']) { ?> checked<?php } ?> name="rating_filter[]" value="<?php echo $rating['rating']; ?>" data-rating="<?php echo $rating['rating']; ?>" id="option-value-rating-<?php echo $rating['rating']; ?>"<?php if (!$rating['ratings_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-rating-<?php echo $rating['rating']; ?>">
											<span class="rating">
												<?php for ($i = 1; $i <= 5; $i++) { ?>
													<?php if ($rating['rating'] < $i) { ?>
														<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } else { ?>
														<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } ?>
												<?php } ?>
											</span>
											<?php if ($rating['rating_value_required']) { ?>
												<i class="fa fa-close pull-right" onclick="live_option_product('rating_filter', 'options', '', '');"></i>
											<?php } else { ?>
												<?php if ($rating['rating_value_total'] and $quantity_view) { ?><span class="filter_total"><?php echo $rating['rating_value_total']; ?></span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) { if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_options) { ?>
			<?php if ($value == "options") { ?>
				<?php if ($status_options) { ?>
					<?php if ($options) { ?>
						<?php $count_group = 400; ?>
						<?php foreach ($options as $option) { ?>
							<?php if ($option['options_show_required']) { ?>
								<?php if ($option['type'] == 'checkbox' or $option['type'] == 'radio' or $option['type'] == 'select') { ?>
								<div class="checkbox-group btn-border col-sm-12<?php if ($view_options == "column") { ?> column_filt<?php } ?><?php if ($view_options == "content") { ?> content_filt<?php } ?><?php if ($collapse_options == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_options == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_options == 0) { ?> hidden-sm<?php } ?>">
									<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $option['name']; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
										<div class="checkbox-group-overflow<?php if (!$drop_option) { ?> no_drop<?php } ?>">
											<?php $count = 0; ?>
											<?php $coun_end = 0; ?>
											<?php $test_checked = 0; foreach ($option['option_value'] as $option_value) {if ($option_value['option_value_required']) {$test_checked = $test_checked + 1;}} ?>
											<?php foreach ($option['option_value'] as $option_value) { ?>
												<?php $count = $count + 1; ?>
													<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php }} ?>">
													  <input type="checkbox"<?php if ($option_value['option_value_required']) { ?> checked<?php } ?> name="option_filter[]" value="<?php echo $option_value['option_value_id']; ?>" id="option-value-<?php echo $option_value['option_value_id']; ?>" <?php if (!$option_value['option_stock_required']) { ?> disabled<?php } ?> data-options="<?php echo $option['option_id']; ?>" />
													  <label for="option-value-<?php echo $option_value['option_value_id']; ?>">
														<?php if ($option_value['image']) { ?><img src="<?php echo $option_value['image']; ?>" alt="" title="" /><?php } ?>
														<?php echo $option_value['option_value_name']; ?>
														<?php if ($option_value['option_value_required']) { ?>
															<?php if ($option_value['option_stock_required']) { ?>
																<i class="fa fa-close pull-right" onclick="live_home_clear_option_filter('<?php echo $option_value['option_value_id']; ?>');"></i>
															<?php } else { ?>
																<?php if ($option_value['option_value_total'] and $quantity_view) { ?><span class="filter_total filter_gray">0</span><?php } ?>
															<?php } ?>
														<?php } else { ?>
															<?php if ($option_value['option_value_total'] and $quantity_view) { ?><span class="filter_total"><?php echo $option_value['option_value_total']; ?></span><?php } ?>
														<?php } ?>
													  </label>
													</div>
													<?php $coun_end = $coun_end + 1; ?>
											<?php } ?>
										</div>
										<?php $coun_end = $coun_end - $count_show; ?>
										<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
								</div>
								<?php } ?>
								<?php $count_group = $count_group + 1; ?>
							<?php } ?>
						<?php } ?>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_attributes) { ?>
			<?php if ($value == "attributes") { ?>
				<?php if ($status_attributes) { ?>
					<?php if ($attributes) { ?>
						<?php $m = 1000; ?>
						<?php $count_group = 500; ?>
						<?php foreach ($attributes as $attribute) { ?>
							<?php if ($attribute['attribute_show_required']) { ?>
								<div class="checkbox-group btn-border col-sm-12<?php if ($view_attributes == "column") { ?> column_filt<?php } ?><?php if ($view_attributes == "content") { ?> content_filt<?php } ?><?php if ($collapse_attributes == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_attributes == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_attributes == 0) { ?> hidden-sm<?php } ?>">
									<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $attribute['name']; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
									<div class="checkbox-group-overflow<?php if (!$drop_attributes) { ?> no_drop<?php } ?>">
										<?php $count = 0; ?>
										<?php $coun_end = 0; ?>
										<?php $test_checked = 0; foreach ($attribute['attribute'] as $attribute_text) {if ($attribute_text['attribute_value_required']) {$test_checked = $test_checked + 1;}} ?>
										<?php foreach ($attribute['attribute'] as $attribute_text) { ?>
											<?php $count = $count + 1; ?>
											<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php }} ?>">
												<?php if ($attribute_text['attribute_value_required'] and !$attribute_text['attribute_stock_required']) { ?><input type="checkbox" name="attributes_filter[<?php echo $attribute_text['attribute_id']; ?>][]" value="<?php echo $attribute_text['text']; ?>" checked /><?php } ?>
												<input type="checkbox"<?php if ($attribute_text['attribute_value_required']) { ?> checked<?php } ?> name="attributes_filter[<?php echo $attribute_text['attribute_id']; ?>][]" value="<?php echo $attribute_text['text']; ?>" id="attribute-value-attribute-<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>" data-attribute="<?php echo $attribute['attribute_id']; ?>" <?php if (!$attribute_text['attribute_stock_required'] or !$attribute_text['attribute_results_stock_required']) { ?> disabled<?php } ?> />
												<label for="attribute-value-attribute-<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>"><?php echo $attribute_text['text']; ?><?php if ($attribute_text['attribute_value_required']) { ?><?php if ($attribute_text['attribute_stock_required']) { ?><i class="fa fa-close pull-right" onclick="live_home_clear_attributes_filter('<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>');"></i><?php } else { ?><?php if ($attribute_text['attribute_text_total']) { ?><span class="filter_total filter_gray">0</span><?php } ?><?php } ?><?php } else { ?><?php if ($attribute_text['attribute_text_total'] and $quantity_view) { ?><span class="filter_total"><?php echo $attribute_text['attribute_text_total']; ?></span><?php } ?><?php } ?></label>
											</div>
											<?php $m = $m + 1; ?>
											<?php $coun_end = $coun_end + 1; ?>
										<?php } ?>
									</div>
									<?php $coun_end = $coun_end - $count_show; ?>
									<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
								</div>
								<?php $count_group = $count_group + 1; ?>
							<?php } ?>
						<?php } ?>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_filter) { ?>
			<?php if ($value == "filter") { ?>
				<?php if ($status_filter) { ?>
					<?php if ($filters) { ?>
						<?php $count_group = 400; ?>
						<?php foreach ($filters as $filter) { ?>
							<?php if ($filter['filter_show_required']) { ?>
								<div class="checkbox-group btn-border col-sm-12<?php if ($view_filter == "column") { ?> column_filt<?php } ?><?php if ($view_filter == "content") { ?> content_filt<?php } ?><?php if ($collapse_filter == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_filter == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_filter == 0) { ?> hidden-sm<?php } ?>">
									<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $filter['name']; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
										<div class="checkbox-group-overflow">
											<?php $count = 0; ?>
											<?php $coun_end = 0; ?>
											<?php $test_checked = 0; foreach ($filter['filter'] as $filter_value) {if ($filter_value['filter_value_required']) {$test_checked = $test_checked + 1;}} ?>
											<?php foreach ($filter['filter'] as $filter_value) { ?>
												<?php $count = $count + 1; ?>
													<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php }} ?>">
													  <input type="checkbox"<?php if ($filter_value['filter_value_required']) { ?> checked<?php } ?> name="filter_filter[]" value="<?php echo $filter_value['filter_id']; ?>" id="filter-value-<?php echo $filter_value['filter_id']; ?>" <?php if (!$filter_value['filter_stock_required']) { ?> disabled<?php } ?> data-filter="<?php echo $filter_value['filter_id']; ?>" />
													  <label for="filter-value-<?php echo $filter_value['filter_id']; ?>">
														<?php echo $filter_value['name']; ?>
														<?php if ($filter_value['filter_value_required']) { ?>
															<?php if ($filter_value['filter_stock_required']) { ?>
																<i class="fa fa-close pull-right" onclick="live_home_clear_filter_filter('<?php echo $filter_value['filter_id']; ?>');"></i>
															<?php } else { ?>
																<?php if ($filter_value['filter_value_total'] and $quantity_view) { ?><span class="filter_total filter_gray">0</span><?php } ?>
															<?php } ?>
														<?php } else { ?>
															<?php if ($filter_value['filter_value_total'] and $quantity_view) { ?><span class="filter_total"><?php echo $filter_value['filter_value_total']; ?></span><?php } ?>
														<?php } ?>
													  </label>
													</div>
													<?php $coun_end = $coun_end + 1; ?>
											<?php } ?>
										</div>
										<?php $coun_end = $coun_end - $count_show; ?>
										<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
								</div>
								<?php $count_group = $count_group + 1; ?>
							<?php } ?>
						<?php } ?>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
	<?php } ?>
	<div class="clearfix"></div>
</div>
</form>
</div>
<div class="clearfix"></div>
</div>
</div>
</div>
<script id="module<?php echo $modul; ?>" type="text/javascript"><!--
$('#maxCost').on('keydown', function(e) {
	if (e.keyCode == 13) {
		live_option_product('no', 'prices', '', 'maxCost');
	}
});
$('#minCost').on('keydown', function(e) {
	if (e.keyCode == 13) {
		live_option_product('no', 'prices', '', 'maxCost');
	}
});
$('<?php echo $id_content; ?> #home_filter .column_filt').remove();
$('<?php echo $id_column_left; ?> #home_filter .content_filt, <?php echo $id_column_right; ?> #home_filter .content_filt').remove();
$('.go_filter_mobile_block #home_filter .content_filt, .go_filter_mobile_block #home_filter .content_filt').remove();
$('.go_filter_mobile_block .options_container_filter').hide();
var col = $('input[name=\'op\'].filter_op').length;
if (col == 1) {
	$('input[name=\'op\'].filter_op').addClass('filter_op' + col);
} else {
	$('input[name=\'op\'].filter_op').addClass('filter_op' + col);
	$('input[name=\'op\'].filter_op' + parseInt(col - 1)).removeClass('filter_op' + col);
}
if ($('<?php echo $id_column_left; ?> #home_filter input.categ, <?php echo $id_column_right; ?> #home_filter input.categ').html() != null) {
	$('<?php echo $id_content; ?> #home_filter input.categ').remove();
}
<?php /* if ($count_container) { ?>
	setTimeout(function () {
		live_checkout_product(<?php if (isset($category_id)) {echo $category_id;} ?>);
	}, 500);
	<?php if (isset($count_products)) { ?>
	
	function live_checkout_product(category_id) {
		var html = '';

			html += '<div class="pupop-filter animated bounceInLeft"><?php echo $text_products; ?> <?php echo $count_products; ?> ';
			
			<?php if ($count_products != 0) { ?>

				html += '<a class="btn btn-white btn-header pull-right" onclick="live_home_filter(' + category_id + ');"><?php echo $text_reset; ?></a> <button class="btn btn-primary btn-header pull-right text-uppercase" type="submit"><i class="fa fa-filter"></i> <?php echo $text_show; ?></button>';
				
			<?php } else { ?>
				
				html += '<a class="btn btn-white btn-header pull-right" onclick="live_home_filter(' + category_id + ');"><?php echo $text_reset; ?></a>';
				
			<?php } ?>

			html += '</div>';
		
		$('#<?php echo $count_container; ?>').parent().parent().parent().find('.row').append(html);
	}
	<?php } ?>
<?php } */ ?>
<?php if ((isset($max_price_const) or $old_price) and !$nofilter) { ?>
slider_generation('<?php if (isset($min_price)) {echo $min_price;} ?>','<?php if (isset($max_price_const)) {if ($get_price_max > $max_price_const) {echo $max_price_const;} else {if (isset($max_price)) {echo $max_price;}} } else {echo $prices_max_value;} ?>','noclear');
function slider_generation(min_value_price, max_value_price, clear) {
	$(".slider").slider({
		min: <?php if (isset($min_const_price)) { ?><?php echo $min_const_price; ?><?php } else { ?>0<?php } ?>,
		max: <?php if (isset($max_price_const)) {echo $max_price_const;} else {echo $old_price;} ?>,
		range: true,
		step: 1,
		values: [min_value_price, max_value_price],
		slide: function(event, ui){
			$("input#minCost").val($(".slider").slider("values",0));
			$("input#maxCost").val($(".slider").slider("values",1));
		},
		stop: function(event, ui){
			
			$("input#minCost").val($(".slider").slider("values",0));
			$("input#maxCost").val($(".slider").slider("values",1));

			if (clear != 'clear') {live_option_product('no', 'prices', '', 'maxCost');}
			
			var value_min = $(".slider").slider("values",0);
			var value_max = $(".slider").slider("values",1);
			
			<?php foreach ($currencies as $currency) { ?>
				<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
					var value_max_currency = $(".slider").slider("values",1) + '<?php echo $currency['symbol_left']; ?>';
				<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
					var value_max_currency = $(".slider").slider("values",1) + '<?php echo $currency['symbol_right']; ?>';
				<?php } ?>
			<?php } ?>
		}
	});

	if (clear == 'clear') {
		$('.option_cloud_price').remove();
		$("input#minCost").val('0');
		$("input#maxCost").val(max_value_price);
		setTimeout(function() {
			live_option_product('no', 'options', '', 'maxCost');
		},200)
	}
	return clear = 'noclear';
}
<?php } ?>

var test_category = '';
$('select#category-option, #filter_send input[name^=category_id]').on('change', function(){
	if (test_category == '') {
		live_option_product('no', 'options', '', 'popup_categories');
		test_category = '1';
	}
});
var test_keywords = '';
$('input[name^=keywords_filter]').on('change', function(){
	if (test_keywords == '') {
		live_option_product('no', 'options', 'keywords', $(this));
		test_keywords = '1';
	}
});
var test_options = '';
$('input[name^=option_filter\\[]').on('change', function(){
	if (test_options == '') {
		live_option_product('no', 'options', 'options' + $(this).attr('data-options'), $(this));
		test_options = '1';
	}
});
var test_filter = '';
$('input[name^=filter_filter\\[]').on('change', function(){
	if (test_filter == '') {
		live_option_product('no', 'options', 'filter' + $(this).attr('data-filter'), $(this));
		test_filter = '1';
	}
});
var test_attributes = '';
$('input[name^=attributes_filter\\[]').on('change', function(){
	if (test_attributes == '') {
		live_option_product('no', 'options', 'attributes' + $(this).attr('data-attribute'), $(this));
		test_attributes = '1';
	}
});
var stock_call = '';
$('.checkbox input[name^=stock_status_filter\\[], select#stock_status-option, .radio input[name^=stock_status_filter\\[]').on('change', function(){
	if (stock_call == '') {
		live_option_product('no', 'options', 'stock', $(this));
		stock_call = '1';
	}
});
var manuf_call = '';
$('.checkbox input[name^=manufacturers_filter\\[], select#manufacturers-option, .radio input[name^=manufacturers_filter\\[]').on('change', function(){
	if (manuf_call == '') {
		live_option_product('no', 'options', 'manuf', $(this));
		manuf_call = '1';
	}
});
var rating_call = '';
$('.checkbox input[name^=rating_filter\\[], .radio input[name^=rating_filter\\[]').on('change', function(){
	if (rating_call == '') {
		live_option_product('no', 'options', 'rating', $(this));
		rating_call = '1';
	}
});
function live_option_product(clear_radio, click_options, selection, clac) {
	$('<?php echo $id_content; ?> #home_filter').addClass('content_filter');
	var data_clear_radio = '';
	if (clear_radio == 'no') {data_clear_radio = ', #option_filter input[type=\'radio\'], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id]';} 
	
	if (clear_radio == 'stock_status_filter') {
		data_clear_radio = ', input[name^=manufacturers_filter\\[], input[name^=rating_filter\\[], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id]';
	}
	if (clear_radio == 'manufacturers_filter') {
		data_clear_radio = ', input[name^=stock_status_filter\\[], input[name^=rating_filter\\[], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id]';
	}
	
	if (clear_radio == 'rating_filter') {
		data_clear_radio = ', input[name^=stock_status_filter\\[], input[name^=manufacturers_filter\\[], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id]';
	}
	
	if (clear_radio == 'option_filter') {
		data_clear_radio = ', input[name^=stock_status_filter\\[], input[name^=manufacturers_filter\\[], input[name^=rating_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id]';
	}
	
	if (clear_radio == 'category_filter') {
		data_clear_radio = ', input[name^=stock_status_filter\\[], input[name^=manufacturers_filter\\[], input[name^=rating_filter\\[], input[name^=option_filter\\[]';
	}

	var data_click = '';
	if (click_options != 'options') {
		data_click += ', .formCost input[type=\'text\']';
		data_click += ', input[name=\'op\'].filter_op1';
	}
	
	var sel = '';
	if (selection != '') {
		sel = '&select=' + selection;
		
	}
	
	var select_value = '';
	if ($('select#category-option').val() != '') {
		select_value += ', select#category-option';
	}
	if ($('select#stock_status-option').val() != '') {
		select_value += ', select#stock_status-option';
	}
	if ($('select#manufacturers-option').val() != '') {
		select_value += ', select#manufacturers-option';
	}
	
	if ($('#keywords_filter input[type=\'text\']').val() != '') {var keyword = ', #keywords_filter input[type=\'text\']';} else {var keyword = '';}
	data: data = $('#option_filter input[type=\'checkbox\']:checked, #filter_send input[name^=old_category_id]' + data_clear_radio + data_click + keyword + select_value);
	var products = '';
	var options = data.serialize();

	var clas = '';
	var classing = '';
	if (clac != 'no_popup') {
		if ($(clac).attr('id') != null) {
			clas = '&class=' + clac.attr('id');
			classing = $('#' + clac.attr('id'));
		} else {
			clas = '&class=' + clac;
			classing = $('#' + clac);
		}
	}
	$.ajax({
		url: 'index.php?route=extension/module/gofilter/live_option_product',
		type: 'post',
		data: options<?php if ($category_id) { ?> + '&path=<?php echo $category_id; ?>'<?php } ?> + sel <?php if ($route) { ?> + '&route_layout=<?php echo $route; ?>'<?php } ?><?php if (isset($url) && $url !="") { ?> + '<?php echo $url; ?>'<?php } ?> + clas<?php if ($go_mobile) { ?> + '&go_mobile=1'<?php } ?>,
		beforeSend: function() {
				$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter, .filter_cloud_mobile #home_filter').addClass('load');
				$('#home_filter').find('.pupop-filter').remove();
			<?php if (!$popup_on) { ?>
				$('<?php echo $id_content; ?>').addClass('load');
			<?php } ?>
		},
		success: function(msg){
			get_data = this.data;

			setTimeout(function () {
				$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter, .filter_cloud_mobile #home_filter').removeClass('load');
				$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').empty();
				$('<?php echo $id_content; ?> #home_filter').empty();
				
				if ($('.icon_mobile_filter').hasClass('oneclick')) {
					$('.filter_cloud_mobile #home_filter').empty();
					$('.filter_cloud_mobile #home_filter').append(msg);
				} else {
					$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').append(msg);
				}
				
				$('<?php echo $id_content; ?> #home_filter').css('opacity','0');
				
				$('<?php echo $id_content; ?> #home_filter').append(msg);
				
				generetion_content();
				$('<?php echo $id_content; ?> #home_filter').css('opacity','1');
			}, 0);
			setTimeout(function () {
				<?php if (!$popup_on or $go_mobile) { ?>
					ajax_page_category(get_data, 'get');
					<?php if ($go_mobile) { ?>
						$('.icon_mobile_filter').trigger('click');
					<?php } ?>
				<?php } else { ?>
					generation_head_results('reset');
					var test_ajaxing = '';
					
					if (clac != 'no_popup') {
						if (classing.parent().parent().parent().parent().hasClass('content_filt')) {
							test_ajaxing = '1';
						}
						if (classing.parent().parent().parent().parent().hasClass('column_mobile')) {
							test_ajaxing = '1';
						}
					} else {
						test_ajaxing = '1';
					}
					
					if (test_ajaxing == '1') {
						ajax_page_category(get_data, 'get');
					}
				<?php } ?>
			}, 0);
			
			$('<?php echo $id_content; ?> .option_cloud_price').remove();
			$('<?php echo $id_content; ?> #home_filter.content_filter').show();
			$('<?php echo $id_content; ?> #home_filter + #home_filter.content_filter').hide();
			$('<?php echo $id_content; ?> #home_filter.content_filter').empty();
			
		}
	});
}
<?php if (isset($class)) { ?>
count_option_product('<?php echo $class; ?>', '<?php if (isset($products)) {echo $products;} ?>');
function count_option_product(clac, products) {
		var products_array = '';
		var count = '';
		if (products != "-1") {
			products_array = products.split(',');
			count = products_array.length;
		} else {
			count = 0;
		}
		
		var select_value = '';
		if ($('select#category-option').val() != '') {
			select_value += ', select#category-option';
		}
		if ($('select#stock_status-option').val() != '') {
			select_value += ', select#stock_status-option';
		}
		if ($('select#manufacturers-option').val() != '') {
			select_value += ', select#manufacturers-option';
		}
		
		if ($('#keywords_filter input[type=\'text\']').val() != '') {var keyword = ', #keywords_filter input[type=\'text\']';} else {var keyword = '';}
		var data = $(' .formCost input[type=\'text\'], #option_filter input[type=\'radio\'], input[name^=filter_filter\\[], input[name^=option_filter\\[], input[name^=option_filter\\[], input[name^=attributes_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id], #option_filter input[type=\'checkbox\']:checked, #filter_send input[name^=old_category_id]' + keyword + select_value);
		
		var get_data = data.serialize();
		
		var html = '';
		
		<?php if (isset($count_products)) { ?>
			html += '<div class="pupop-filter animated bounceInLeft hidden-xs"><span class="pull-left"><?php echo $text_products; ?> <?php echo $count_products; ?></span>';
			
			if (count != '0') {
				html += '<a class="btn btn-white btn-header pull-right" onclick="reset_filter();"><?php echo $text_reset; ?></a><a class="btn btn-primary btn-header pull-right text-uppercase" onclick="ajax_page_category(\'' + get_data + '\',\'get\');"><i class="fa fa-filter"></i><?php echo $text_show; ?></a>';
			} else {
				html += '<a class="btn btn-white btn-header pull-right" onclick="reset_filter();"><?php echo $text_reset; ?></a>';
			} 

			html += '</div>';
		<?php } ?>

		$('#' + clac).parent().parent().parent().find('.row').append(html);
}
<?php } ?>
function generation_head_results(reset) {
	
	if ($('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').html() != null) {
		$('<?php echo $id_content; ?>').removeClass('load');
		
		var home_filter_content = $('<?php echo $id_content; ?> #home_filter').html();

		var html_cloud = '<div class="options_container_filter">' + $('.options_container_filter').html() + '</div>';

		$('#home_filter .options_container_filter').remove();
		
		$('<?php echo $id_content; ?> .options_container_filter').remove();

		if (home_filter_content != undefined) {
			$('<?php echo $id_content; ?> .reset_filter').addClass('none_content_filter');
		}
		
		$('<?php echo $id_content; ?> .none_content_filter').remove();

		$('<?php echo $id_content; ?>').prepend(html_cloud);
		
		if ($('#home_filter').hasClass('filter_category_page')) {
			<?php if (!$post_category_id) { ?>
				$('.category_filt').remove();
			<?php } ?>
		}
		
	}
		
	show_reset();
}
function separator(get_parametr, get_check, get_select) {
		var temp_data_seo = '';
		if ($(get_check).html() != null || $(get_select).html() != null) {
			if (get_select != 'options' && get_select != 'attributes' && get_select != 'filters') {
				temp_data_seo += get_parametr;
				if ($(get_check).html() != null) {
					temp_data_seo += count_separator(count_separator($(get_check).text(),/\t+/g,''),/\n+/g,'');
					var count = $(get_check).length + 1;
					for (var i = 0; i < count; i++) {temp_data_seo = temp_data_seo.replace('  ','<?php echo $seo_separator; ?>');}
					for (var i = 0; i < count; i++) {temp_data_seo = temp_data_seo.replace(' ','_');}
				}
				temp_data_seo += count_separator(count_separator(count_separator(count_separator($(get_select).text().split('(')[0],/\s+/g,' '),'  ',' '),' ','_'),'/','?');
			}
			if (get_select == 'options') {
				var temp_arr = $(get_check).serialize().split('&');
				var url_text = '';
				temp_arr.forEach(function(item, i, temp_arr) {
					var item_id_group = count_separator(count_separator(count_separator($('#option-value-' + item.split('=')[1]).parent().parent().parent().parent().find('.row strong').text(),'  ',''),' ','_'),'/','?');
					var item_id_attr = count_separator(count_separator(count_separator(count_separator(count_separator($('#option-value-' + item.split('=')[1] + ' + label').text(),/\t+/g,''),/\n+/g,''),'  ',''),' ','_'),'/','?');
					temp_data_seo += get_parametr + '<?php echo $seo_separator; ?>' + item_id_group + '<?php echo $seo_separator; ?>' + item_id_attr;
					temp_data_seo += '/';
				});
			}
			if (get_select == 'filters') {
				var temp_arr = $(get_check).serialize().split('&');
				var url_text = '';
				temp_arr.forEach(function(item, i, temp_arr) {
					var item_id_group = count_separator(count_separator(count_separator($('#filter-value-' + item.split('=')[1]).parent().parent().parent().parent().find('.row strong').text(),'  ',''),' ','_'),'/','?');
					var item_id_attr = count_separator(count_separator(count_separator(count_separator(count_separator($('#filter-value-' + item.split('=')[1] + ' + label').text(),/\t+/g,''),/\n+/g,''),'  ',''),' ','_'),'/','?');
					temp_data_seo += get_parametr + '<?php echo $seo_separator; ?>' + item_id_group + '<?php echo $seo_separator; ?>' + item_id_attr;
					temp_data_seo += '/';
				});
			}
			if (get_select == 'attributes') {
				var temp_arr = $(get_check).serialize().split('&');
				temp_arr.forEach(function(item, i, temp_arr) {
					item = decodeURIComponent(item);
					var item_id_group = count_separator(count_separator(count_separator($('#' + $('input[data-attribute=' + '"' + count_separator(item.split("=")[0],/\D+/g,"") + '"' + ']').attr('id')).parent().parent().parent().parent().find('.row strong').text(),'  ',''),' ','_'),'/','?');

					var item_attr = count_separator(count_separator(count_separator(count_separator(count_separator($('#' + $('input[data-attribute][value=' + '"' + count_separator(item.split("=")[1], '+',' ') + '"' + ']').attr('id') + ' + label').text(),/\t+/g,''),/\n+/g,''),'  ',''),' ','_'),'/','?');
					temp_data_seo += get_parametr + '<?php echo $seo_separator; ?>' + item_id_group + '<?php echo $seo_separator; ?>' + item_attr;
					temp_data_seo += '/'
				});
			};
			temp_data_seo += '/';
			temp_data_seo = temp_data_seo.replace(' /','/').replace('//','/').replace('_/','/').replace('<?php echo $seo_separator; ?>/','/');
		}
	
		return temp_data_seo;
}
function count_separator(itm, aft, bef) {
	var mas = itm.split(aft);
	var itog = '';
	mas.forEach(function(item, i, mas) {
		
		if (i == 0) {
			itog += item.replace(aft, bef);
		} else {
			itog += bef;
			itog += item.replace(aft, bef);
		}
	});
	return itog;
}
function Seo_juxtaposition(data_seo_parametr) {
	
	var seo_massiv = [];
	<?php if ($seo_keywords) { ?>
		<?php foreach ($seo_keywords as $key_s => $value_s) { ?> 
			seo_massiv['<?php echo $key_s; ?>'] = '<?php echo $value_s; ?>';
		<?php } ?>
	<?php } ?>
	
	var temp_data_seo = data_seo_parametr;
	var result_seo_url = '';

	var temp_data_seo_arr_1 = temp_data_seo.split('/');
	temp_data_seo_arr_1.forEach(function(item_array, i, temp_data_seo_arr_1) {
		var temp_result_seo_url_1 = '';
		var temp_result_seo_url_2 = '';
		var temp_result_seo_url_common_for = '';
		if (item_array != '') {
			var item_array_1 = item_array.split('<?php echo $seo_separator; ?>');
			item_array_1.forEach(function(item, j, item_array_1) {
				if (j == 0) {
					temp_result_seo_url_1 = item + '<?php echo $seo_separator; ?>';
				} else {
					temp_result_seo_url_2 = item + '<?php echo $seo_separator; ?>';
					for (var k in seo_massiv) {
						if (k === count_separator(count_separator(item,'_', ' '),'?','/')) {
							temp_result_seo_url_2 = seo_massiv[k] + '<?php echo $seo_separator; ?>';
						}
					}
					temp_result_seo_url_common_for += temp_result_seo_url_2;
				}
			});
			result_seo_url += temp_result_seo_url_1 + temp_result_seo_url_common_for;
			result_seo_url += '/';
			result_seo_url = result_seo_url.replace('<?php echo $seo_separator; ?>/', '/');
		}
		
	});
	
	
	
	return result_seo_url;
}
function ajax_page_category(get_data, types) {

	var data_seo = '';
	var route_layout = '<?php echo $route; ?>';
	data_seo += route_layout.replace('/','-');
	data_seo += '/';
	var data_seo_parametr = '';
	if ($('#filter_send input[name^=category_id]#common_category + a.category_filter label, #filter_send input[name^=category_id]#common_category + input +label').html() != null || $('select#category-option option:selected').html() != null || $('input[name^=parent_category_hierarchy_name]#parent_category_hierarchy_name').html() != null) {
		if ($('input[name^=parent_category_hierarchy_name]#parent_category_hierarchy_name').val() != '' && $('input[name^=parent_category_hierarchy_name]#parent_category_hierarchy_name').html() != undefined) {
			data_seo_parametr += 'category<?php echo $seo_separator; ?>';
			data_seo_parametr += $('input[name^=parent_category_hierarchy_name]#parent_category_hierarchy_name').val();
			data_seo_parametr += '/';
			data_seo_parametr = data_seo_parametr.replace('<?php echo $seo_separator; ?>/','/');
		}
	}
	
	data_seo_parametr += separator('manufacturers<?php echo $seo_separator; ?>', 'input[name^=manufacturers_filter\\[]:checked + label', 'select#manufacturers-option option:selected');
	data_seo_parametr += separator('stock<?php echo $seo_separator; ?>', 'input[name^=stock_status_filter\\[]:checked + label', 'select#stock_status-option option:selected');
	data_seo_parametr += separator('options', 'input[name^=option_filter\\[]:checked', 'options');
	data_seo_parametr += separator('filter_filter', 'input[name^=filter_filter\\[]:checked', 'filters');
	data_seo_parametr += separator('attributes', 'input[name^=attributes_filter\\[]:checked', 'attributes');
	
	if ($('#keywords_filter input[type=\'text\']').val() != '' && $('#keywords_filter input[type=\'text\']').val() == 'undefined') {
		data_seo_parametr += 'keywords<?php echo $seo_separator; ?>';
		<?php if ($delimitier == " ") { ?>
		if ($('#keywords_filter input[type=\'text\']').val() != null) {
			data_seo_parametr += $('#keywords_filter input[type=\'text\']').val().replace('  ',',').replace(' ',',');
		}
		<?php } ?>
		<?php if ($delimitier == ",") { ?>
		if ($('#keywords_filter input[type=\'text\']').val() != null) {
			data_seo_parametr += $('#keywords_filter input[type=\'text\']').val().replace('  ',' ').replace(', ',',');
		}
		<?php } ?>
		data_seo_parametr += '/';
		data_seo_parametr = data_seo_parametr.replace('<?php echo $seo_separator; ?>/','/');
	}
	if ($('input[name^=rating_filter\\[]:checked + label').html() != null) {
		data_seo_parametr += 'rating<?php echo $seo_separator; ?>';
		var temp_arr = $('input[name^=rating_filter\\[]:checked').serialize().split('&');
		var temp_data_seo = '';
		temp_arr.forEach(function(item, i, temp_arr) {
			var item_attr = $('#option-value-rating-' + item.split("=")[1]).val();
			temp_data_seo += item_attr + '<?php echo $seo_separator; ?>';
		});
		data_seo_parametr += temp_data_seo;
		data_seo_parametr += '/';
		data_seo_parametr = data_seo_parametr.replace('<?php echo $seo_separator; ?>/','/');
	}
	
	<?php if ($get_price_max and isset($max_price_const)) {
		if ($get_price_max > $max_price_const) {
			if (isset($max_price_const)) {$test_price = $max_price_const;}
		} else {
			if (isset($get_price_max)) {$test_price = $get_price_max;}
		}
		if ($test_price != $max_price_const or $get_price_min != 0) { ?>
			if ($('input[name^=prices_min_value]').html() != null && $('input[name^=prices_max_value]').html() != null) {
				data_seo_parametr += $('input[name^=op]').val() + '-price-<?php echo strtolower($code); ?><?php echo $seo_separator; ?>';
				data_seo_parametr += $('input[name^=prices_min_value]').val() + '-';
				data_seo_parametr += $('input[name^=prices_max_value]').val();
				data_seo_parametr += '/';
			}
		<?php }
	} ?>
	
	get_data = get_data.replace('path','patfilter').replace('path','patfilter').replace('path','patfilter');
	var typ = '';
	
	var typs = types;
	if (types == 'post') {typ = 'post';} else {typ = 'get';}
	
	<?php if ($page) { ?>
		if (typs != 'ref') {
			get_data += '&page=<?php echo $page; ?>';
		}
	<?php } ?>
	
	<?php if ($limit) { ?>
		if (typs != 'ref') {
			get_data += '&limit=<?php echo $limit; ?>';
		}
	<?php } ?>
	
	<?php if ($sort) { ?>
		if (typs != 'ref') {
			get_data += '&sort=<?php echo $sort; ?>';
		}
	<?php } ?>
	
	<?php if ($order) { ?>
		if (typs != 'ref') {
			get_data += '&order=<?php echo $order; ?>';
		}
	<?php } ?>
	
	$.ajax({
		url: 'index.php?route=product/category&path=0&gofilter=1',
		type: typ,
		data: get_data,
		beforeSend: function(){
			$('body').prepend('<div class="gofilter_shadow_block"></div>');
		},
		success: function(data){
			
			generation_head_results('no_reset');

			$('<?php echo $id_content; ?>').children().not('#home_filter').not('.options_container_filter').not('.breadcrumb').not('#home_filter').not('h1').remove();

			var data = $(data);

			$('<?php echo $id_content; ?>').append(data.find('<?php echo $id_content; ?>').html());
			
			var top_content = $("<?php echo $id_content; ?>").offset().top - 200;
			$('html, body').animate({scrollTop: top_content}, 1000);

			$('<?php echo $id_content; ?>').removeClass('load');
			
			var browsers = '';
			
			var hrefing = window.location.href;
			browsers += 'gofilter/';
			browsers += data_seo;
			browsers += Seo_juxtaposition(data_seo_parametr);
			
			<?php if ($page) { ?>
			if (typs != 'ref') {
				if (window.location.href.indexOf('/page=') != '-1') {
					browsers = browsers.replace('page=' + window.location.href.split('/page=')[1], '');
					browsers += 'page=<?php echo $page; ?>/';
				}
			}
			<?php } ?>
			<?php if ($limit) { ?>
			if (typs != 'ref') {
				if (window.location.href.indexOf('/limit=') != '-1') {
					browsers = browsers.replace('page=' + window.location.href.split('/page=')[1], '');
					browsers = browsers.replace('limit=' + window.location.href.split('/limit=')[1], '');
					browsers += 'limit=<?php echo $limit; ?>/';
				}
			}
			<?php } ?>
			<?php if ($sort) { ?>
			if (typs != 'ref') {
				if (window.location.href.indexOf('/sort=') != '-1') {
					browsers = browsers.replace('page=' + window.location.href.split('/page=')[1], '');
					browsers = browsers.replace('sort=' + window.location.href.split('/sort=')[1], '');
					browsers += 'sort=<?php echo $sort; ?>/';
				}
			}
			<?php } ?>
			<?php if ($order) { ?>
			if (typs != 'ref') {
				if (window.location.href.indexOf('/order=') != '-1') {
					browsers = browsers.replace('page=' + window.location.href.split('/page=')[1], '');
					browsers = browsers.replace('order=' + window.location.href.split('/order=')[1], '');
					browsers += 'order=<?php echo $order; ?>/';
				}
			}
			<?php } ?>
			var mas_hrefing = get_data.split('&');
			mas_hrefing.forEach(function(item, i) {
				window.location.href.split('/').forEach(function(ite, i2) {
					if (item.indexOf('page=') != '-1' && ite.indexOf('page=') != '-1') {
						browsers = browsers.replace(ite + '/', '');
					}
					if (item.indexOf('sort=') != '-1' && ite.indexOf('sort=') != '-1') {
						browsers = browsers.replace(ite + '/', '');
					}
					if (item.indexOf('order=') != '-1' && ite.indexOf('order=') != '-1') {
						browsers = browsers.replace(ite + '/', '');
					}
					if (item.indexOf('limit=') != '-1' && ite.indexOf('limit=') != '-1') {
						browsers = browsers.replace(ite + '/', '');
					}
					
				});
				setTimeout(function () {
					if (item.indexOf('page=') != '-1') {
						browsers += 'page=' + item.split('=')[1];
						browsers += '/';
					}
					if (item.indexOf('sort=') != '-1') {
						browsers += 'sort=' + item.split('=')[1];
						browsers += '/';
					}
					if (item.indexOf('order=') != '-1') {
						browsers += 'order=' + item.split('=')[1];
						browsers += '/';
					}
					if (item.indexOf('limit=') != '-1') {
						browsers += 'limit=' + item.split('=')[1];
						browsers += '/';
					}
					
				}, 0);
				
			});
			<?php if ($seo_on) { ?>
				setTimeout(function () {
					window.history.pushState({urlPath:browsers}, '', browsers);
				}, 0);
			<?php } ?>
			
			$('#option_filter .pupop-filter').remove();
			
			setTimeout(function () {
				$('body .gofilter_shadow_block').remove();
			}, 500);
            
            $('h1+.breadcrumb').remove();
            $('h1+h1').remove();
			$('h1+h2').remove();
			
			<?php if(isset($filter_scripts)) {echo html_entity_decode($filter_scripts, ENT_QUOTES, 'UTF-8');} ?>
            
            $('.dropdown-toggle').dropdown();
			
			$('<?php echo $id_content; ?> #home_filter + #home_filter, <?php echo $id_content; ?> #home_filter + h1 + #home_filter, <?php echo $id_content; ?> .breadcrumb + .breadcrumb').remove();
		}
	});
}

function ajax_page_category_select(hrefing) {
	$.ajax({
		url: hrefing,
		type: 'get',
		beforeSend: function(){
			$('body').prepend('<div class="gofilter_shadow_block"></div>');
		},
		success: function(data){
			
			generation_head_results('no_reset');

			$('<?php echo $id_content; ?>').children().not('#home_filter').not('.options_container_filter').not('.breadcrumb').not('#home_filter').not('h1').remove();

			var data = $(data);

			$('<?php echo $id_content; ?>').append(data.find('<?php echo $id_content; ?>').html());

			$('<?php echo $id_content; ?>').removeClass('load');
            
            $('h1+.breadcrumb').remove();
            $('h1+h1').remove();
			$('h1+h2').remove();			
			
			<?php if(isset($filter_scripts)) {echo html_entity_decode($filter_scripts, ENT_QUOTES, 'UTF-8');} ?>
			
			$('#option_filter .pupop-filter').remove();
			
			setTimeout(function () {
				$('body .gofilter_shadow_block').remove();
			}, 500);
			
			<?php if ($seo_on) { ?>
				var browsers = window.location.href;
				var mas_hrefing = hrefing.split('&');
				mas_hrefing.forEach(function(item, i) {
					window.location.href.split('/').forEach(function(ite, i2) {
						if (ite.indexOf('sort=') != '-1') {
							browsers = browsers.replace('page=' + window.location.href.split('/page=')[1], '');
							browsers = browsers.replace('sort=' + ite.split('=')[1] + '/', '');
						}
						if (ite.indexOf('order=') != '-1') {
							browsers = browsers.replace('page=' + window.location.href.split('/page=')[1], '');
							browsers = browsers.replace('order=' + ite.split('=')[1] + '/', '');
						}
						if (ite.indexOf('limit=') != '-1') {
							browsers = browsers.replace('page=' + window.location.href.split('/page=')[1], '');
							browsers = browsers.replace('limit=' + ite.split('=')[1] + '/', '');
						}
						
					});
					setTimeout(function () {
						if (item.indexOf('sort=') != '-1') {
							browsers += 'sort=' + item.split('=')[1];
							browsers += '/';
						}
						if (item.indexOf('order=') != '-1') {
							browsers += 'order=' + item.split('=')[1];
							browsers += '/';
						}
						if (item.indexOf('limit=') != '-1') {
							browsers += 'limit=' + item.split('=')[1];
							browsers += '/';
						}
						window.history.pushState({urlPath:browsers}, '', browsers);
					}, 500);
					
				});
			<?php } ?>
		}

	});
}
var test_reset ='';
function show_reset() {
	if (test_reset == '') {
		if ($('<?php echo $id_content; ?>').find('.options_container_filter .filter_container').find('*').length != 0) {
			$('<?php echo $id_content; ?> .options_container_filter').prepend('<div class="reset_filter"><a <?php if ($set_cookie) { ?>href="<?php echo $set_cookie; ?>"<?php } else { ?>onclick="reset_filter();"<?php } ?>><i class="fa fa-close"></i>&nbsp;&nbsp;<?php echo $text_reset_all; ?></a></div>');
			if ($('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').html() == null) {
				$('<?php echo $id_content; ?> .options_container_filter').addClass('row');
			}
		} else {
			$('<?php echo $id_content; ?>').find('.options_container_filter .filter_container').empty();
		}
		test_reset = '1';
	}
}
function show_parent(count_group) {
	if ($('#show_parent' + count_group + ' .text_more').hasClass('none')) {
		$('#show_parent' + count_group + ' .text_more').removeClass("none");
	} else {
		$('#show_parent' + count_group + ' .text_more').addClass("none");
		$('.none.none' + count_group).removeClass("none");
	}
	if ($('#show_parent' + count_group + ' .text_hide').hasClass("none")) {
		$('#show_parent' + count_group + ' .text_hide').removeClass("none");
	} else {
		$('#show_parent' + count_group + ' .text_hide').addClass("none");
		$('.none' + count_group).addClass("none");
	}
}
function clear_popup_filter() {
	$('#home_filter').find('.pupop-filter').remove();
}
function remove_popup() {
	$('#option_filter .pupop-filter').remove();
}
$("#keywords_filter .btn").click(function() {
	if ($('#keywords_filter input[type=\'text\']').val() != '') {
		
	} else {
		$('#keywords_filter input[type=\'text\']').attr('placeholder', '<?php echo $text_keywords_placeholder_empty; ?>');
		$('#keywords_filter input[type=\'text\']').addClass('red_filter');
	}
});
$(document).mouseup(function (e) {
	if ($('#keywords_filter input[type=\'text\']').attr('placeholder') == '<?php echo $text_keywords_placeholder_empty; ?>' && $('#keywords_filter').has(e.target).length === 0) {
		$('#keywords_filter input[type=\'text\']').attr('placeholder', '<?php echo $text_keywords_placeholder; ?>');
		$('#keywords_filter input[type=\'text\']').removeClass('red_filter');
	}
});
function live_home_filter(category_id) {
	if (category_id != null && category_id != 'mobile') {
		$.ajax({
			url: 'index.php?route=extension/module/gofilter/live_home_filter',
			type: 'post',
			data: '&category_id=' + category_id<?php if ($route) { ?> + '&route_layout=<?php echo $route; ?>'<?php } ?>,
			beforeSend: function() {
				$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').addClass('load');
			},
			success: function(msg){
				setTimeout(function () {
					$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').removeClass('load');
					$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').empty();
					
					$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').append(msg);
					
					$('<?php echo $id_content; ?> #home_filter').empty();
					$('<?php echo $id_content; ?> #home_filter').append(msg);
					generetion_content();
				}, 500);
				
			}
		});
	} else if (category_id != 'mobile') {
		var options = <?php if ($route) { ?>'&route_layout=<?php echo $route; ?>'<?php } else { ?>''<?php } ?>;
		$.ajax({
			url: 'index.php?route=extension/module/gofilter/live_home_filter',
			type: 'post',
			data: options,
			beforeSend: function() {
				$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').addClass('load');
			},
			success: function(msg){
				get_data = this.data;
				setTimeout(function () {
					$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').removeClass('load');
					$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').empty();
					
					$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').append(msg);
					
					$('<?php echo $id_content; ?> #home_filter').empty();
					$('<?php echo $id_content; ?> #home_filter').append(msg);
					generetion_content();
					
				}, 500);
				setTimeout(function () {
					ajax_page_category(get_data);
				}, 0);
			}
		});
	} else if ($('.icon_mobile_filter').hasClass('oneclick')) {
		$('.go_filter_mobile_block').animate({left: "-300px"}, 500);
		$('.icon_mobile_filter').removeClass('oneclick');
		$('.icon_mobile_filter').addClass('returnclick');
		$('.close-mobile-filter').remove();
	} else if ($('.filter_cloud_mobile').text() == "") {
		generation_ajax('.filter_cloud_mobile');
		setTimeout(function () {
			$('.go_filter_mobile_block').prepend('<div class="close-mobile-filter" onclick="$(\'.icon_mobile_filter\').trigger(\'click\');"><i class="fa fa-close"></i></div>');
		}, 2000);
	} else if ($('.icon_mobile_filter').hasClass('returnclick')) {
		$('.go_filter_mobile_block').animate({left: "0px"}, 500);
		setTimeout(function () {
			$('.go_filter_mobile_block').prepend('<div class="close-mobile-filter" onclick="$(\'.icon_mobile_filter\').trigger(\'click\');"><i class="fa fa-close"></i></div>');
		}, 0);
		$('.icon_mobile_filter').removeClass('returnclick');
	} else {
		$('.go_filter_mobile_block').animate({left: "-300px"}, 500);
		$('.close-mobile-filter').remove();
		$('.icon_mobile_filter').addClass('returnclick');
	}
}
function generation_ajax(clas) {
	var categ = $('input.categ[name^=category_id]'); categ = categ.serialize();
	if (clas == '.filter_cloud_mobile') {
		$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').empty();
	} else {
		setTimeout(function () {
			$('.filter_cloud_mobile').empty();
		}, 1000);
	}
	var options = '&go_mobile=1<?php if ($route) { ?>&route_layout=<?php echo $route; ?>'<?php } else { ?>'<?php } ?>;
	$.ajax({
		url: 'index.php?route=extension/module/gofilter/live_home_filter',
		type: 'post',
		data: categ + options,
		beforeSend: function() {
			if (clas == '.filter_cloud_mobile') {
				$('.icon_mobile_filter .fa').removeClass('fa-filter').addClass('fa-spinner').addClass('wheel');
			} else {
				$('.go_filter_mobile_block').animate({left: "-300px"}, 500);
			}
		},
		success: function(msg){
			get_data = this.data;
			setTimeout(function () {
				$(clas).empty();
				$(clas).append(msg);
				if (clas == '.filter_cloud_mobile') {
					$('.icon_mobile_filter .fa').removeClass('fa-spinner').removeClass('wheel').addClass('fa-filter');
					$('.go_filter_mobile_block').animate({left: "0px"}, 500);
					$('.icon_mobile_filter').addClass('oneclick');
				} else {
					setTimeout(function () {
						$('.icon_mobile_filter').removeClass('oneclick');
						$('.icon_mobile_filter').addClass('returnclick');
						$('.filter_cloud_mobile').empty();
					}, 500);
					
				}
				
				
			}, 500);
		}
	});
}

function reset_filter() {
	var category_id = '';
	if ($('#home_filter').hasClass('filter_category_page')) {
		category_id = $('input.categ[name^=category_id]');
		category_id = category_id.serialize();
	}
	$.ajax({
		url: 'index.php?route=extension/module/gofilter/live_home_filter',
		type: 'post',
		data: <?php if ($route) { ?>'&route_layout=<?php echo $route; ?><?php } ?>&' + category_id,
		beforeSend: function() {
			$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').addClass('load');
		},
		success: function(msg){
			$('<?php echo $id_content; ?> #home_filter').addClass('content_filter');
			setTimeout(function () {
				$('<?php echo $id_content; ?> #home_filter, <?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').removeClass('load');
				$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').empty();
				$('<?php echo $id_content; ?> #home_filter').empty();
				$('<?php echo $id_column_left; ?> #home_filter, <?php echo $id_column_right; ?> #home_filter').append(msg);
				
				$('<?php echo $id_content; ?> #home_filter').css('opacity','0');
				$('<?php echo $id_content; ?> #home_filter').append(msg);
				generetion_content();
				$('<?php echo $id_content; ?> #home_filter').css('opacity','1');
				
				$('<?php echo $id_content; ?> .reset_filter').remove();
				$('<?php echo $id_content; ?> .options_container').remove();
			}, 500);
			setTimeout(function () {
				ajax_page_category(category_id, 'get');
			}, 1000);
		}
	});
}
function getting() {
	
	var select_value = '';
	if ($('select#category-option').val() != '') {
		select_value += ', select#category-option';
	}
	if ($('select#stock_status-option').val() != '') {
		select_value += ', select#stock_status-option';
	}
	if ($('select#manufacturers-option').val() != '') {
		select_value += ', select#manufacturers-option';
	}
	
	if ($('#keywords_filter input[type=\'text\']').val() != '') {var keyword = ', #keywords_filter input[type=\'text\']';} else {var keyword = '';}
	var data = $(' input[name^=manufacturers_filter\\[], .formCost input[type=\'text\'], #option_filter input[type=\'radio\'], input[name^=option_filter\\[], #filter_send input[name^=category_id], #option_filter input[type=\'checkbox\']:checked, #filter_send input[name^=old_category_id]' + keyword + select_value);
		
	var get_data = data.serialize();
	return get_data;
}

function live_home_clear_option_filter(option_id) {
	$('#option_filter .checkbox label[for="option-value-' + option_id + '"]').trigger('click');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_filter_filter(filter_id) {
	$('#option_filter .checkbox label[for="filter-value-' + filter_id + '"]').trigger('click');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_attributes_filter(attributes_id) {
	$('#option_filter .checkbox label[for="attribute-value-attribute-' + attributes_id + '"]').trigger('click');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_stock_filter(stock_id) {
	$('#option_filter .checkbox label[for="option-value-stock-' + stock_id + '"]').trigger('click');
	$('select option#common_stock_status:eq(0)').prop('selected', 'selected').trigger('change');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_rating_filter(rating) {
	$('#option_filter .checkbox label[for="option-value-rating-' + rating + '"]').trigger('click');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_manufacturers_filter(manufacturer) {
	$('#option_filter .checkbox label[for="option-value-manufacturers-' + manufacturer + '"]').trigger('click');
	$('select option#common_manufacturers:eq(0)').prop('selected', 'selected').trigger('change');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_category_filter(category) {
	$('#option_filter .checkbox label[for="option-value-category-' + category + '"]').trigger('click');
	$('#option_filter .radio label[for="option-value-category-' + category + '"]').trigger('click');
	$('select option#common_category:eq(0)').prop('selected', 'selected').trigger('change');
	$('#option_filter .radio a.category_filter').trigger('click');
}
function live_home_clear_keywords_filter(text, key) {
	var isset_keywords = '';
	$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value") + '<?php echo $delimitier; ?>');
	$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value").replace(text + '<?php echo $delimitier; ?>',''));
	<?php if ($delimitier == ",") { ?>$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value").replace(', ',','));<?php } ?>
	$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value").replace(<?php if ($delimitier == " ") { ?>/\s+$/<?php } ?><?php if ($delimitier == ",") { ?>','<?php } ?>,''));
	$('.option_cloud_keywords' + key).remove();
	if ($('#keywords_filter input').attr("value") != '') {isset_keywords = 'yes';} else {isset_keywords = 'no';}
	if (isset_keywords == 'yes') {
		setTimeout(function () {
			$('#keywords_filter .input-group-btn > .btn').trigger('click');
		}, 500);
	}
}
<?php if ($modul > 0) { ?>
	$('<?php echo $id_content; ?> .filter #option_filter h3').remove();
<?php } ?>
function clear_all_option_filter() {
	$('#option_filter .checkbox input:checked').trigger('click');
	setTimeout(function () {
		$('.pupop-filter').remove();
	}, 300);
}
function clear_all_option_filter_page_category() {
	$('#option_filter .checkbox input:checked').trigger('click');
	setTimeout(function () {
		$('.pupop-filter').remove();
	}, 300);
}
update_scrollbar();
function update_scrollbar() {
	$(document).ready(function(){
		$('<?php echo $id_column_left; ?> .checkbox-group-overflow, <?php echo $id_column_right; ?> .checkbox-group-overflow, .filter_cloud_mobile .checkbox-group-overflow').scrollbar();
	});
}
<?php if (!$go_mobile) { ?>
if ($('<?php echo $id_content; ?> #home_filter').hasClass('content_filter')) {
	
} else {
	generetion_content();
}
<?php } ?>
function generetion_content() {
	$('<?php echo $id_content; ?> #option_filter .checkbox-group .row, <?php echo $id_content; ?> #option_filter .checkbox-group-overflow-price .row').wrap('<div class="input-group-addon"></div>').parent().parent().find('.select-group').addClass('col-xs-12 col-sm-12');
	$('<?php echo $id_content; ?> #option_filter .checkbox-group .checkbox, <?php echo $id_content; ?> #option_filter .checkbox-group .radio').removeClass('none');
	$('<?php echo $id_content; ?> #option_filter .formCost label, <?php echo $id_content; ?> #option_filter #minCost, <?php echo $id_content; ?> #option_filter #maxCost').wrapAll('<div class="col-xs-12 col-sm-12 col-md-5"></div>');
	$('<?php echo $id_content; ?> #option_filter .formCost .clearfix').addClass('visible-xs visible-sm');
	$('<?php echo $id_content; ?> #option_filter .checkbox-group, <?php echo $id_content; ?> #option_filter .checkbox-group-overflow-price').wrapInner('<div class="input-group row"></div>').find('.formCost').addClass('col-xs-12 col-sm-12').find('.col-sm-12').removeClass('col-xs-12 col-sm-12').addClass('col-xs-12 col-sm-12 col-md-7');
	$('<?php echo $id_content; ?> #option_filter .filter_total').prepend('(').append(')');
	$('<?php echo $id_content; ?> input[type=\'checkbox\']:checked').parent().addClass('reding');
}
<?php if ($mobile_pult) { ?>
	if ($('.filter_cloud_mobile').length == false) {
		$('body').prepend('<div class="go_filter_mobile_block visible-xs"><div class="filter_cloud_mobile"></div></div>');
		$('<?php echo $id_button_mobile; ?>').after('<div class="icon_mobile_filter btn btn-primary visible-xs" onclick="live_home_filter(\'mobile\'); "><i class="fa fa-filter"></i> <?php echo $text_filter; ?></div>');
	}
<?php } ?>
<?php if ($seo_results) { ?>
	var get_data = getting();
	setTimeout(function () {
		ajax_page_category(get_data, 'get');
	}, 1500);
<?php } ?>
//--></script>
<style type="text/css">
#option_filter .checkbox-group-overflow {
<?php if (isset($max_height)) { ?>	
    max-height: <?php echo $max_height; ?>px;
<?php } else { ?>
	max-height: 215px;
<?php } ?>	
}
<?php echo $id_content; ?> #option_filter .checkbox-group-overflow {
	max-height: none;
}
<?php if (isset($color_caption)) { ?>
	#option_filter h3 {
		color: <?php echo $color_caption; ?>;
	}
<?php } ?>
<?php if (isset($color_group)) { ?>
	<?php echo $id_column_left; ?> #option_filter .checkbox-group h4,
	<?php echo $id_column_right; ?> #option_filter .checkbox-group h4,
	<?php echo $id_column_left; ?> #option_filter .checkbox-group-price h4,
	<?php echo $id_column_right; ?> #option_filter .checkbox-group-price h4	{
		color: <?php echo $color_group; ?>;
	}
<?php } ?>
<?php if (isset($bg_group)) { ?>
	<?php echo $id_column_left; ?> #option_filter .checkbox-group h4,
	<?php echo $id_column_right; ?> #option_filter .checkbox-group h4,
	<?php echo $id_column_left; ?> #option_filter .checkbox-group-price h4,
	<?php echo $id_column_right; ?> #option_filter .checkbox-group-price h4,
	<?php echo $id_content; ?> #option_filter .input-group-addon	{
		background: <?php echo $bg_group; ?>;
	}
<?php } ?>
<?php if (isset($color_product)) { ?>
	.filter .filter_total {
		background: <?php echo $color_product; ?>;
	}
	.filter .filter_total::after {
		border-color: transparent <?php echo $color_product; ?> transparent transparent;
	}
<?php } ?>
<?php if (isset($color_product_no)) { ?>
	.filter .filter_total.gray {
		background: <?php echo $color_product_no; ?>;
	}
	.filter .filter_total.gray::after {
		border-color: transparent <?php echo $color_product_no; ?> transparent transparent;
	}
<?php } ?>
<?php if (isset($bg_price)) { ?>
	.filter .ui-widget-header {
		background: <?php echo $bg_price; ?>;
	}
<?php } ?>
<?php if (!$popup_on or $go_mobile) { ?>
	.pupop-filter {
		display: none;
	}
<?php } ?>
<?php echo $id_column_left; ?> .filter #option_filter .formCost.checkbox,
<?php echo $id_column_right; ?> .filter #option_filter .formCost.checkbox {
	margin-bottom: 30px;
	padding-top: 15px;
}
<?php echo $id_content; ?> .filter .checkbox-group-price .checkbox label {
	padding-left: 0;
	margin-left: 7px;
}
<?php echo $id_content; ?> .filter .filter_total {
	background: none;
	color: inherit;
    font-size: 13px;
    position: initial;
}
<?php echo $id_content; ?> .filter .filter_total:after {
	display: none;
}
<?php echo $id_content; ?> #option_filter  .checkbox-group h4,
<?php echo $id_content; ?> #option_filter  .checkbox-group-price h4 {
	cursor: default;
}
#option_filter  .checkbox-group h4 strong,
#option_filter  .checkbox-group-price h4 strong {
	border-bottom: 1px dotted #000000;
}
<?php echo $id_content; ?> #option_filter h4 {
	border-top: 0 none;
	border-bottom: 0 none;
}
<?php echo $id_content; ?> #option_filter .checkbox-group + .checkbox-group,
<?php echo $id_content; ?> #option_filter .checkbox-group-price + .checkbox-group {
	border-top: 1px solid #ddd;
}
<?php echo $id_content; ?> #option_filter .input-group .input-group-addon {
	border: 0 none;
    min-width: 160px;
    text-align: left;
}
<?php echo $id_content; ?> #option_filter .checkbox-group-overflow-price .ui-slider {
	margin-top: -14px;
}
<?php echo $id_column_left; ?> #option_filter h4 .fa,
<?php echo $id_column_right; ?> #option_filter h4 .fa {
	color: #d60000;
    font-size: 13px;
    line-height: 15px;
    margin-right: 9px;
}
<?php echo $id_content; ?> #option_filter h4 .fa {
	display: none;
}
<?php echo $id_content; ?> #option_filter .checkbox-group .fa-close {
	top: 2px;
}
<?php echo $id_content; ?> #option_filter .checkbox-group-overflow {
	max-height: auto;
	position: relative;
}
<?php echo $id_content; ?> #option_filter .checkbox-group-overflow.owl-carousel {
	padding-right: 50px;
    right: -15px;
}
<?php echo $id_column_left; ?> #option_filter .checkbox-group .row + .select-group,
<?php echo $id_column_right; ?> #option_filter .checkbox-group .row + .select-group {
	margin-bottom: 15px;
}
<?php echo $id_content; ?> #option_filter .checkbox-group-overflow,
<?php echo $id_content; ?> #option_filter .formCost,
<?php echo $id_content; ?> #option_filter .select-group,
<?php echo $id_content; ?> #option_filter .text_more_group {
	max-height: none;
}
<?php echo $id_content; ?> #option_filter .select-group {
	margin: 5px 0;
}
<?php echo $id_content; ?> #option_filter .checkbox-group .row,
<?php echo $id_content; ?> #option_filter .checkbox-group-price .row {
	
}
<?php echo $id_content; ?> #option_filter .checkbox-group-overflow {
	overflow: hidden;
}
<?php echo $id_content; ?> #option_filter .checkbox-group-overflow .checkbox-group-overflow {
	width: 100% !important;
}
<?php echo $id_column_right; ?> .pupop-filter {
	right: 100%;
	left: auto;
}
<?php echo $id_content; ?> .pupop-filter {
	display: none !important;
}
<?php echo $id_content; ?> .load {
	background: url('loading.gif') center center no-repeat;
}
<?php echo $id_content; ?> #home_filter.load {
	background: none;
}
<?php echo $id_content; ?> #home_filter + #home_filter,
<?php echo $id_content; ?> #home_filter + #home_filter,
<?php echo $id_content; ?> .options_container_filter .reset_filter + .reset_filter {
	display: none;
}
<?php echo $id_column_left; ?> .formCost input.form-control,
<?php echo $id_column_right; ?> .formCost input.form-control {
    background: none;
    border: 1px solid #999999;
    border-radius: 3px;
    color: #434343;
    float: left;
    font-size: 14px;
    height: 28px;
    padding-right: 10px;
    text-align: right;
    top: -2px;
}
<?php echo $id_content; ?> .input-group .formCost input#maxCost.form-control {
	width: 70px;
}
<?php echo $id_content; ?> .filter .ui-slider-horizontal .ui-slider-handle {
    margin-left: -21px;
}
<?php echo $id_column_left; ?> .formCost input.form-control,
<?php echo $id_column_right; ?> .formCost input.form-control {
	width: 75px;
}
<?php echo $id_content; ?> .filter .checkbox,
<?php echo $id_content; ?> .filter .radio {  
    display: inline-block;
    margin: 10px 0 5px 15px;
	border: 1px solid #ddd;
	border-radius: 3px;
	padding: 4px 10px 4px 8px;
	position: relative;
}
<?php echo $id_content; ?> .filter .categories_filter .checkbox,
<?php echo $id_content; ?> .filter .categories_filter .radio {
	
}
<?php echo $id_content; ?> .filter a.category_filter {
	
}
<?php echo $id_content; ?> .filter a.category_filter .fa {
	left: 8px;
    position: absolute;
    top: 8px;
}
<?php echo $id_content; ?> .filter a.category_filter label {
	padding-right: 0px;
}
<?php echo $id_content; ?> .filter a.category_filter .fa + input + label,
<?php echo $id_content; ?> .filter a.category_filter .fa + input + input + label {
	padding-left: 25px;
}
<?php echo $id_content; ?> .filter .not-active-link {
	display: none;
}
<?php echo $id_content; ?> .filter .checkbox-group-overflow-price .checkbox {
	border: 0 none;
	margin: 0;
	padding: 13px 0 0;
}
<?php echo $id_content; ?> .checkbox-group-overflow.owl-carousel {
	display: inline-block;
}
<?php echo $id_content; ?> #option_filter .text_more_group {
	display: none;
}
<?php echo $id_content; ?> #option_filter .col-sm-12:nth-child(2n) {
	clear:left;
}
<?php echo $id_content; ?> #option_filter .checkbox.reding {
	border-color: #c54448;
}
<?php echo $id_column_left; ?> .options_container_filter,
<?php echo $id_column_right; ?> .options_container_filter {
	display: none;
}
<?php echo $id_content; ?> #home_filter .column_filt,
<?php echo $id_column_left; ?> #home_filter .content_filt, <?php echo $id_column_right; ?> #home_filter .content_filt {
	display: none;
}
<?php echo $id_column_left; ?> #option_filter .collapse_filter .select-group,
<?php echo $id_column_right; ?> #option_filter .collapse_filter .select-group,
<?php echo $id_column_left; ?> #option_filter .collapse_filter .checkbox-group-overflow,
<?php echo $id_column_right; ?> #option_filter .collapse_filter .checkbox-group-overflow,
<?php echo $id_column_left; ?> #option_filter .collapse_filter .checkbox-group-price,
<?php echo $id_column_right; ?> #option_filter .collapse_filter .checkbox-group-price,
<?php echo $id_column_left; ?> #option_filter .collapse_filter .checkbox-group,
<?php echo $id_column_right; ?> #option_filter .collapse_filter .checkbox-group,
<?php echo $id_column_left; ?> #option_filter .collapse_filter .text_more_group,
<?php echo $id_column_right; ?> #option_filter .collapse_filter .text_more_group {
	display: none;
}
@media (max-width: 991px) {
	.input-group .formCost input.form-control {
		max-width: 130px;
		width: auto;
	}
	<?php echo $id_content; ?> #option_filter .checkbox-group-overflow-price .ui-slider {
		margin: -5px 0 15px;
	}
	<?php echo $id_content; ?> .filter .ui-slider-horizontal .ui-slider-handle {
		margin-left: -5px;
	}
	<?php echo $id_content; ?> .filter .ui-slider .ui-slider-handle + .ui-slider-handle {
		margin-left: -15px;
	}
}
@media (max-width: 768px) {
	<?php echo $id_content; ?> .input-group .formCost input.form-control {
		max-width: 100px;
		width: auto;
	}
}
@media (max-width: 520px) {
	<?php echo $id_content; ?> .input-group .formCost input.form-control {
		max-width: 80px;
	}
	<?php echo $id_content; ?> #option_filter .input-group .input-group-addon {
		min-width: 130px;
	}
}
@media (max-width: 1200px) {
	<?php echo $id_column_left; ?> .formCost input.form-control,
	<?php echo $id_column_right; ?> .formCost input.form-control {
		width: 55px;
	}
}
@media (max-width: 991px) {
	<?php echo $id_column_left; ?> .formCost input.form-control,
	<?php echo $id_column_right; ?> .formCost input.form-control {
		margin-bottom: 13px;
		width: 73px;
	}
}
<?php echo $id_column_left; ?> #option_filter .row, <?php echo $id_column_right; ?> #option_filter .row {
	width: auto;
}
<?php echo $id_content; ?> #option_filter .col-sm-12:nth-child(2n) {
	clear:left;
}
<?php echo $id_content; ?> #option_filter .checkbox.reding {
	border-color: #c54448;
}
<?php echo $id_content; ?> #option_filter .input-group-addon h4 {
	margin-top: 0;
}
</style>
<?php echo $gofilter_cloud; ?>
<?php } ?>