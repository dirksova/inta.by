<?php if ($histories) { ?>
  <div class="btn-group">
    <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
      <i class="fa fa-trash-o"></i> <?php echo $button_delete_menu; ?> <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" role="menu">
      <li><a onclick="delete_all();"><?php echo $button_delete_all; ?></a></li>
      <li><a onclick="delete_all_selected();"><?php echo $button_delete_selected; ?></a></li>
    </ul>
  </div>
  <div class="special_margin"></div>
<?php } ?>
<div class="table-responsive">
  <table class="table table-bordered">
    <thead>
      <tr>
        <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
        <td class="text-left"><?php echo $column_cart_visitor_info; ?></td>
        <td class="text-left"><?php echo $column_cart_products_in_cart; ?></td>
        <td class="text-left"><?php echo $column_cart_date_time; ?></td>
        <td class="text-center"><?php echo $column_cart_action; ?></td>
      </tr>
    </thead>
    <tbody>
    <?php if ($histories) { ?>
      <?php foreach ($histories as $history) { ?>
      <tr>
        <td style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $history['cart_id']; ?>" /></td>
        <td class="text-left">
          <p><strong><?php echo $text_email; ?></strong> <?php echo $history['email']; ?></p>
          <p><strong><?php echo $text_ip; ?></strong> <?php echo $history['ip']; ?> <button onclick="window.open('http://www.checkip.com/ip/<?php echo $history['ip']; ?>','_blank');return false;" class="btn btn-default btn-xs" data-toggle="tooltip" title="<?php echo $button_check_ip; ?>" data-placement="right"><i class="fa fa-info-circle"></i> <?php echo $text_check; ?></button></p>
        </td>
        <td>
          <button type="button" id="button-call-modal-<?php echo $history['cart_id']; ?>" class="btn btn-primary btn-sm" data-loading-text="Loading..." onclick="button_loading(<?php echo $history['cart_id']; ?>);" data-toggle="modal" data-target="#madal-products-<?php echo $history['cart_id']; ?>" autocomplete="off"><?php echo $button_view_products; ?> (<?php echo count($history['products']) ?>)</button>
          <!-- Modal -->
          <div class="modal fade" id="madal-products-<?php echo $history['cart_id']; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="myModalLabel"><?php echo $text_saved_cart_heading; ?></h4>
                </div>
                <div class="modal-body">
                  <?php if ($history['products']) { ?>
                  <div class="table-responsive">
                    <table class="table table-bordered" style="margin-bottom:0">
                      <thead>
                        <tr>
                          <td class="text-center"><?php echo $column_product_id; ?></td>
                          <td class="text-center"><?php echo $column_product_image; ?></td>
                          <td class="text-left"><?php echo $column_product_name; ?></td>
                          <td class="text-left"><?php echo $column_product_quantity; ?></td>
                          <td class="text-left"><?php echo $column_product_total; ?></td>
                        </tr>
                      </thead>
                      <tbody>
                      <?php foreach ($history['products'] as $product) { ?>
                        <tr>
                          <td class="text-center"><?php echo $product['product_id']; ?></td>
                          <td class="text-center"><img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></td>
                          <td class="text-left">
                            <strong><a href="<?php echo $product['href']; ?>" target="blanck"><?php echo $product['name']; ?></a></strong>
                            <?php if ($product['options']) { ?>
                              <div class="options">
                                <?php foreach ($product['options'] as $option) { ?>
                                  - <?php echo $option['name']; ?>: <?php echo $option['value'] ?></br>
                                <?php } ?>
                              </div>
                            <?php } ?>
                          </td>
                          <td class="text-left">x <?php echo $product['quantity']; ?></td>
                          <td class="text-left"><?php echo $product['total']; ?></td>
                        </tr>
                      <?php } ?>
                      </tbody>
                    </table>
                  </div>
                  <?php } ?>
                </div>
              </div>
            </div>
          </div>
        </td>
        <td class="text-left">
          <?php echo $history['date_added']; ?>
        </td>
        <td class="text-center">
          <a onclick="confirm('Are you sure?') ? delete_selected('<?php echo $history['cart_id']; ?>') : false;" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="<?php echo $button_delete; ?>"><i class="fa fa-trash-o"></i></a>
        </td>
      </tr>
      <?php } ?>
      <?php } else { ?>
        <tr>
          <td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
        </tr>
      <?php } ?>
    </tbody>
  </table>
</div>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
