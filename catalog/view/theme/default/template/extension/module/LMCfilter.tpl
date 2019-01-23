<?php if ($price_slider) { ?>
  <script src="catalog/view/javascript/LMCfilter/noUiSlider/nouislider.min.js" type="text/javascript"></script>
  <link href="catalog/view/javascript/LMCfilter/noUiSlider/nouislider.min.css" rel="stylesheet" />
  <link href="catalog/view/theme/default/stylesheet/LMCfilter.css" rel="stylesheet" />
<?php } ?>
 <div class="panel panel-default">
  
  <div class="list-group">
    <?php foreach ($filter_groups as $filter_group) { ?>
    <a class="list-group-item"><?php echo $filter_group['name']; ?></a>
    <div class="list-group-item gray">
      <div id="filter-group<?php echo $filter_group['filter_group_id']; ?>">
        <?php if ($filter_group['LMCfilter_mode'] == null) { ?>
			<?php foreach ($filter_group['filter'] as $filter) { ?>
			<div class="checkbox">
			  <label>
				<?php if (in_array($filter['filter_id'], $filter_category)) { ?>
				<input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" checked="checked" />
				<?php echo $filter['name']; ?>
				<?php } else { ?>
				<input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" />
				<?php echo $filter['name']; ?>
				<?php } ?>
			  </label>
			</div>
			<?php } ?>
        <?php } ?>
        <?php if ($filter_group['LMCfilter_mode'] == 'price') { ?>
		<div style="padding: 5px 20px;">
            <div class="LMCfilter_price" data-min="<?php echo $filter_group['LMCfilter_data']['min_price']; ?>" data-max="<?php echo $filter_group['LMCfilter_data']['max_price']; ?>" data-step="<?php echo $filter_group['LMCfilter_data']['step']; ?>"></div>
        </div>
		<?php } ?>
      </div>
    </div>
    <?php } ?>
    
  </div>
  <div class="panel-footer text-right">
    <button type="button" id="button-filter" class="btn btn-primary"><?php echo $button_filter; ?></button>
  </div>
</div>
<script type="text/javascript"><!--

(function() {
    var price_filters = document.getElementsByClassName('LMCfilter_price');
    var price_slider_formatter = function(value) {
        return Math.floor(value);
    };
    var captured = /filter_price=([^&]+)/.exec(window.location.href);
    var price_filter_values = (captured ? captured[1] : '').split(',');
    for (var i = 0; i < price_filters.length; i++) {
        var min = parseFloat(price_filters[i].getAttribute('data-min'));
        var max = parseFloat(price_filters[i].getAttribute('data-max'));
        var step = parseFloat(price_filters[i].getAttribute('data-step'));
        var v1 = min, v2 = max;
        if (price_filter_values.length > 1) {
            v1 = parseInt(price_filter_values[0]);
            v2 = parseInt(price_filter_values[1]);
            v1 = isNaN(v1) ? min : v1;
            v2 = isNaN(v2) ? max : v2;
        }
        noUiSlider.create(price_filters[i], {
            start: [v1, v2],
            step: step,
            //format: {
            //  to: price_slider_formatter,
            //  from: price_slider_formatter,
            //},
            //padding: 0,
            tooltips: true,
            connect: true,
            range: {
                'min': min,
                'max': max,
            },
            //margin: 0,
        });
    }
})();

$('#button-filter').on('click', function() {
	var filter = [];

	$('input[name^=\'filter\']:checked').each(function(element) {
		filter.push(this.value);
	});
    
    var price_filters = document.getElementsByClassName('LMCfilter_price');
    
    if (price_filters.length > 0) {
        var filter_price_values = price_filters[0].noUiSlider.get();
        location = '<?php echo $action; ?>&filter=' + filter.join(',') + '&filter_price=' + filter_price_values.join(',');
    } else {
        location = '<?php echo $action; ?>&filter=' + filter.join(',');
    }
});
//--></script>
