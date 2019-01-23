<div id="cart" class=" text-center">
  
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 512 512" enable-background="new 0 0 512 512" width="26px" height="26px">
  <g>
    <g>
      <g>
        <g>
          <polygon points="311.2,365.5 63,365.5 11,126.7 250.7,126.7 250.7,146.5 36.5,146.5 79.9,345.7 296.3,345.7 416.2,11 501,11       501,31.9 431,31.9     " fill="#525252"/>
        </g>
        <g>
          <g>
            <path d="m262.4,501c-29.7,0-54.1-24-54.1-54.2 0-30.2 24.4-54.2 54.1-54.2s54.1,24 54.1,54.2c0,30.2-24.4,54.2-54.1,54.2zm0-87.6c-19.1,0-33.9,15.6-33.9,33.4 0,18.8 14.8,33.4 33.9,33.4s33.9-15.6 33.9-33.4c5.68434e-14-18.8-15.9-33.4-33.9-33.4z" fill="#525252"/>
          </g>
          <g>
            <path d="m108.6,501c-29.7,0-54.1-24-54.1-54.2 0-30.2 24.4-54.2 54.1-54.2s54.1,24 54.1,54.2c0,30.2-24.4,54.2-54.1,54.2zm0-87.6c-19.1,0-33.9,15.6-33.9,33.4 0,18.8 14.8,33.4 33.9,33.4s33.9-15.6 33.9-33.4c-1-18.8-15.9-33.4-33.9-33.4z" fill="#525252"/>
          </g>
        </g>
      </g>
    </g>
  </g>
</svg>

  <span id="cart-total"><?php echo $text_items; ?></span>
 <!-- 
  <ul class="dropdown-menu pull-right">
    <?php if ($products || $vouchers) { ?>
    <li>
      <table class="table table-striped">
        <?php foreach ($products as $product) { ?>
        <tr>
          <td class="text-center"><?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
            <?php } ?></td>
          <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            <?php if ($product['option']) { ?>
            <?php foreach ($product['option'] as $option) { ?>
            <br />
            - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
            <?php } ?>
            <?php } ?>
            <?php if ($product['recurring']) { ?>
            <br />
            - <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
            <?php } ?></td>
          <td class="text-right">x <?php echo $product['quantity']; ?></td>
          <td class="text-right"><?php echo $product['total']; ?></td>
          <td class="text-center"><button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
          <td class="text-center"></td>
          <td class="text-left"><?php echo $voucher['description']; ?></td>
          <td class="text-right">x&nbsp;1</td>
          <td class="text-right"><?php echo $voucher['amount']; ?></td>
          <td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
        </tr>
        <?php } ?>
      </table>
    </li>
    <li>
      <div>
        <table class="table table-bordered">
          <?php foreach ($totals as $total) { ?>
          <tr>
            <td class="text-right"><strong><?php echo $total['title']; ?></strong></td>
            <td class="text-right"><?php echo $total['text']; ?></td>
          </tr>
          <?php } ?>
        </table>
        <p class="text-right"><a href="<?php echo $cart; ?>"><strong><i class="fa fa-shopping-cart"></i> <?php echo $text_cart; ?></strong></a>&nbsp;&nbsp;&nbsp;<a href="<?php echo $checkout; ?>"><strong><i class="fa fa-share"></i> <?php echo $text_checkout; ?></strong></a></p>
      </div>
    </li>
    <?php } else { ?>
    <li>
      <p class="text-center"><?php echo $text_empty; ?></p>
    </li>
    <?php } ?>
  </ul>
  -->
</div>
