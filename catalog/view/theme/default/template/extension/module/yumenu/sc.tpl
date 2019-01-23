<div class="<?php echo $sc_box_class; ?>" id="sc-<?php echo $module; ?>">
  <?php if ($title) { ?>
  <div class="sc-heading sc-expanded"><?php echo $title; ?></div>
  <?php } ?>
  <div class="sc-content">
    <ul class="sc-nav sc-<?php echo $sc_subview; ?>">
      <?php if ($custom_items) {
        echo $items;
      } else {
        $showcase = function ($items,$pos,$limit,$view,$more,$all,$i=1) use (&$showcase) {
          if($items) {
            foreach ($items as $item) {
              echo '<li class="sci '.$item['class'];
              if ($view == 'grid' || $view == 'list' && $i == '1') {
                echo ' img-'.$pos;
              }
              if (isset($item['children'])) {
                echo ' sc-parent';
              }
              if ($item['active']) {
                echo ' active';
              }
              echo '">';

              echo '<a class="sc-link';
              if ($item['current']) {
                echo ' sc-current';
              }
              if (isset($item['children']) && !$item['href'] || isset($item['children']) && $item['empty']) {
                echo ' sc-toggle';
              }
              echo '"';
              if ($item['href']) {
                echo ' href="'.$item['href'].'"';
              }
              echo '>';

              if ($view == 'grid' || $view == 'list' && $i == '1') {
                if ($item['img'] ) {
                  echo '<div class="sc-image"><img src="'.$item['img'].'" alt="'.$item['title'].'" title="'.$item['title'].'" /></div>';
                }
              }

              if ($i == '1' && $view == 'list' && $pos == 'left' || $i == '1' && $view == 'list' && $pos == 'right') {
                echo '</a><div class="sc-info"><a class="sc-link"';
                if ($item['href']) {
                  echo ' href="'.$item['href'].'"';
                }
                echo '>';
              }

              echo '<div class="sc-title';
              if ($item['count']) {
                echo ' sc-count';
              }
              echo '">'.$item['title'];
              if ($item['count']) {
                echo '<span class="sc-badge">'.$item['count'].'</span>';
              }
              echo '</div>';

              echo '</a>';

              if (isset($item['children'])) {
                echo '<div class="sc-sub">';
                  echo '<ul>';

                  if ($limit > 0) {
                    echo $showcase(array_slice($item['children'],0,$limit),$pos,$limit,$view,$more,$all,$i+1);
                  } else {
                    echo $showcase($item['children'],$pos,$limit,$view,$more,$all,$i+1);
                  }

                  if ($more && $item['href']) {
                    if ($view == 'grid' || $view == 'list' && $i == '1') {
                      echo '<li class="sci sc-more"><a class="sc-link" href="'.$item['href'].'"><div class="sc-title">'.$all.'</div></a><li>';
                    }
                  }

                  echo '</ul>';
                echo '</div>';
              }

              if ($i == '1' && $view == 'list' && $pos == 'left' || $i == '1' && $view == 'list' && $pos == 'right') {
                echo '</div>';
              }

              echo '</li>';
            }
          }
        };
        $showcase($items,$img_position,$sc_sublimit,$sc_subview,$sc_more,$text_all);
      } ?>
    </ul>
  </div>
</div>
<script type="text/javascript"><!--
$('#sc-<?php echo $module; ?> .sc-heading').click(function() {
  $(this).toggleClass('sc-expanded sc-collapsed').next().slideToggle(300);
});

$('#sc-<?php echo $module; ?> .sc-list .sc-sub .sc-toggle').click(function(e) {
  e.preventDefault();

  $(this).parent().toggleClass('sc-sub-open');
  $(this).parent().siblings('.sc-sub-open').removeClass('sc-sub-open').find('>.sc-sub').slideUp(300);;
  $(this).next().slideToggle(300);
});

$('#sc-<?php echo $module; ?> .sc-grid .sc-toggle').map(function(i) {
  $(this).addClass('sc-toggle-'+(i+1)).next('.sc-sub').addClass('sc-target-'+(i+1));

  $('#sc-<?php echo $module; ?> .sc-toggle-'+(i+1)).click(function(e) {
    e.preventDefault();

    var list = $(this).closest('ul');
    var item = $(this).parent();
    var items = list.children();
    var sub = $(this).next();
    var current_pos = item.position();

    items.removeClass('sc-end-row');

    if (item.nextAll('.sci').length > 0) {
      item.nextAll('.sci').each(function() {
        var item_pos = $(this).position();

        if (item_pos.left < current_pos.left || item_pos.top > current_pos.top) {
          $(this).prev().addClass('sc-end-row');
          return false;
        }
      });

      if (list.find('>.sc-end-row').length == 0) {
        items.last('.sci').addClass('sc-end-row');
      }

      if (list.find('>.sc-target-'+(i+1)).length == 0) {
        sub.clone(true).insertAfter(list.find('>.sc-end-row'));
      }
    } else {
      if (list.find('>.sc-target-'+(i+1)).length == 0) {
        sub.clone(true).insertAfter(item);
      }
    }

    $(this).parent().toggleClass('sc-sub-open');
    $(this).parent().siblings('.sc-sub-open').removeClass('sc-sub-open');

    $('#sc-<?php echo $module; ?> .sc-target-'+(i+1)).not(sub).slideToggle(300).siblings('.sc-sub:visible').hide(300);
    $('#sc-<?php echo $module; ?> .sc-target-'+(i+1)).not(sub).siblings('.sc-sub:hidden').remove();
  });
});
//--></script>