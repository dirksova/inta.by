<div class="<?php echo $amazon ? 'yum-amazon ' : ''; ?><?php echo $box_class_hm; ?> menu-collapsed" id="yumenu-<?php echo $module; ?>">
  <div class="iheader"><?php echo $title; ?></div>
  <div class="icontent">
    <ul class="inav">
      <?php if ($custom_items) {
        echo $items;
      } else {
        $menu = function ($items,$column,$full_width,$i=1) use (&$menu) {
          if($items) {
            foreach ($items as $item) {
              echo '<li class="mi '.$item['class'];
              if (isset($item['children'])) {
                echo ' iparent';
                if (!$full_width) {
                  echo ' irel';
                }
              }
              if ($item['active']) {
                echo ' active';
              }
              echo '">';

              echo '<a class="ilink';
              if ($item['current']) {
                echo ' icurrent';
              }
              if (isset($item['children']) && !$item['href'] || isset($item['children']) && $item['empty']) {
                echo ' itoggle';
              }
              echo '"';
              if ($item['href']) {
                echo ' href="'.$item['href'].'"';
              }
              echo '>';
              if ($i != '1') {
                if ($item['img']) {
                  echo '<div class="iimage"><img src="'.$item['img'].'" alt="'.$item['title'].'" title="'.$item['title'].'" /></div>';
                }
              }
              echo '<div class="ititle';
              if ($item['count']) {
                echo ' icount';
              }
              echo '">'.$item['title'];
              if ($item['count']) {
                echo '<span class="ibadge">'.$item['count'].'</span>';
              }
              echo '</div>';

              echo '</a>';

              if (isset($item['children'])) {
                if ($column < 2) {
                  if ($i == '1') {
                    if (count($item['children']) < 11) {
                      echo '<div class="isub ilist"><ul>';
                      echo $menu($item['children'],$column,$full_width,$i+1);
                      echo '</ul></div>';
                    } else {
                      echo '<div class="isub ilists"><div>';
                      foreach (array_chunk($item['children'], 3) as $children) {
                        echo '<ul>';
                        echo $menu($children,3,$full_width,$i+1);
                        echo '</ul>';
                      }
                      echo '</div></div>';
                    }
                  } else {
                    echo '<div class="isub ilist"><ul>';
                    echo $menu($item['children'],$column,$full_width,$i+1);
                    echo '</ul></div>';
                  }
                } else {
                  if ($i == '1') {
                    echo '<div class="isub ilists"><div>';
                    foreach (array_chunk($item['children'], $column) as $children) {
                      echo '<ul>';
                      echo $menu($children,$column,$full_width,$i+1);
                      echo '</ul>';
                    }
                    echo '</div></div>';
                  } else {
                    echo '<div class="ilist"><ul>';
                    echo $menu($item['children'],$column,$full_width,$i+1);
                    echo '</ul></div>';
                  }
                }
              }

              echo '</li>';
            }
          }
        };
        $menu($items,$column_hm,$full_width);
      } ?>
    </ul>
  </div>
</div>
<script type="text/javascript"><!--
$('#yumenu-<?php echo $module; ?> .iheader').click(function() {
  $(this).parent().toggleClass('menu-expanded menu-collapsed');
  if ($(window).width() < 768) {
    $(this).next().slideToggle(200);
  } else {
    $('#yumenu-<?php echo $module; ?> .icontent').show();
    var height = $(this).next().outerHeight();
    $(this).next().find('.ilink').next('.isub').css('min-height',height);
  }
  return false;
});

<?php if ($amazon) { ?>
$('#yumenu-<?php echo $module; ?> .itoggle').click(function(e) {
  e.preventDefault();
  if ($(window).width() < 768) {
    $(this).next().slideToggle(200);
    $(this).parent().toggleClass('mob-sub-open');
    $(this).parent().siblings('.mob-sub-open').removeClass('mob-sub-open').find('>div').not('.ilink').slideToggle(200);
  } else {
    $(this).parent().toggleClass('sub-open');
    $(this).parent().siblings('.sub-open').removeClass('sub-open');
    $(this).next('.ilist').not('.isub').slideToggle(200);
  }
});

$('#yumenu-<?php echo $module; ?> .inav, #yumenu-<?php echo $module; ?> .inav > .igroup > ul').menuAim({
  submenuDirection: $('#yumenu-<?php echo $module; ?>').parents().is('#column-right') ? 'left' : 'right',
  activate: function(item){
    if ($(window).width() > 767) {
      $(item).addClass('active sub-open');
      $(item).siblings('.active').removeClass('active');
      $(item).closest('.igroup').siblings('.sub-open').removeClass('active sub-open');

      if ($(item).is('.iparent')) {
        var container = $(item).closest('.container');
        var container_pos = container.offset();
        var sub = $(item).find('>.ilink').next();
        var sub_width = sub.outerWidth();
        var sub_pos = sub.offset();
        var fly = (container_pos.left+container.outerWidth()-15)-sub_pos.left;

        if (sub_width > fly || <?php echo $full_width; ?>) {
          $(item).find('>.isub').outerWidth(fly);
          $(item).find('>.isub > div > ul').css({'flex-wrap':'wrap','width':'100%'}).children().css('flex-grow','1');
        }
      }
    }
  },
  deactivate: function(item){
    $(item).removeClass('active sub-open');
  },
  exitMenu: function(list){
    // $(list).children().find('>.isub:visible').fadeOut(200);
    return true;
  }
});

<?php } else { ?>


function submargin(el) {
  if ($(window).width() > 767) {
    if (<?php echo $full_width; ?>) {
        var menu_w = $('#yumenu-<?php echo $module; ?>').outerWidth();
        $('#yumenu-<?php echo $module; ?> .inav > .mi > .ilists').outerWidth(menu_w);
    } else {
      var menu = $('#yumenu-<?php echo $module; ?>');
      var menu_pos = menu.offset();
      var sub = el.find('>.isub');
      var sub_pos = sub.offset();

      var outside = (sub_pos.left + sub.outerWidth()) - (menu_pos.left + menu.outerWidth());

      if (outside > 5) {
        if (el.closest('.isub').length == 0) {
          sub.css('margin-left', '-'+(outside)+'px');
        } else {
          var pad = Math.round((sub.outerWidth()-sub.width())/2);
          sub.css({'margin-left': '-'+(sub.outerWidth()-pad)+'px', 'margin-top':el.height()+'px'});
        }
      }
    }
  }
}

$('#yumenu-<?php echo $module; ?> .iparent').not('.ilists .iparent')
.mouseenter(function() {
  $(this).addClass('sub-open');
  submargin($(this));
})
.mouseleave(function() {
  $(this).removeClass('sub-open');
});

$('#yumenu-<?php echo $module; ?> .itoggle').click(function(e) {
  e.preventDefault();
  if ($(window).width() < 768) {
    $(this).next().slideToggle(200);
    $(this).parent().toggleClass('mob-sub-open');
    $(this).parent().siblings('.mob-sub-open').removeClass('mob-sub-open').find('>div').not('.ilink').slideToggle(200);
  } else {
    $(this).parent().toggleClass('sub-open');
    $(this).next('.ilist').not('.isub').slideToggle(200);

    if ($(this).closest('.isub').is('.ilists').length == 0) {submargin($(this).parent());}
  }
});
<?php } ?>
//--></script>
