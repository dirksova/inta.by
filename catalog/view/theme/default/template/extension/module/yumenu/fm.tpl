<div id="yumenu-<?php echo $module; ?>" class="<?php echo $box_class; ?>" style="position: relative;">
  <?php if ($title) { ?>
  <div class="<?php echo $title_class ? $title_class : ''; ?> <?php echo $minimized ? 'menu-collapsed' : 'menu-expanded'; ?> toggle-heading"><?php echo $title; ?></div>
  <?php } ?>
  <div <?php echo $minimized ? 'style="display:none"' : ''; ?>>
    <ul class="yum-fm<?php echo $column < '2' ? ' ilist' : ''; ?>">
      <?php if ($custom_items) {
        echo $items;
      } else {
        $menu = function ($items,$column,$i=1) use (&$menu) {
          if($items) {
            foreach ($items as $item) {
              echo '<li class="'.$item['class'];
              if (isset($item['children'])) {
                echo ' iparent';
              }
              if ($item['active']) {
                echo ' active';
              }
              echo '">';

              echo '<a class="ilink';
              if (isset($item['children']) && !$item['href'] || isset($item['children']) && $item['empty']) {
                echo ' itoggle';
              }
              if ($item['current']) {
                echo ' icurrent';
              }
              echo '"';
              if ($item['href']) {
                echo ' href="'.$item['href'].'"';
              }
              echo '>';

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
                  echo '<ul>';
                 $menu($item['children'],$column,$i+1);
                  echo '</ul>';
                } else {
                  if ($i == 1) {
                    echo '<div class="isub">';
                    foreach (array_chunk($item['children'], $column) as $children) {
                      echo '<ul>';
                      $menu($children,$column,$i+1);
                      echo '</ul>';
                    }
                    echo '</div>';
                  } else if ($i == 2) {
                    echo '<div class="isub-list"><ul>';
                    $menu($item['children'],$column,$i+1);
                    echo '</ul></div>';
                  }
                }
              }

              echo '</li>';
            }
          }
        };
        $menu($items,$column);
      } ?>
    </ul>
  </div>
</div>
<script type="text/javascript"><!--
$('#yumenu-<?php echo $module; ?> .yum-fm, #yumenu-<?php echo $module; ?> .yum-fm.ilist ul').menuAim({
  submenuDirection: $('#yumenu-<?php echo $module; ?>').parents().is('#column-right') ? 'left' : 'right',
  activate: function(item){
    var height = $(item).parent('ul.yum-fm').parent().parent().outerHeight();
    $(item).find('>.ilink').next('.isub').css('min-height',height);

    $(item).addClass('active sub-open');
    $(item).siblings('.active').removeClass('active');

    $(item).find('>.ilink').next().show();
    $(item).siblings('.iparent').find('>.ilink').next().hide();
  },
  deactivate: function(item){
    $(item).removeClass('active sub-open');
    $(item).find('>.ilink').next().fadeOut(200);
  },
  exitMenu: function(list){
    $(list).children().find('>.isub:visible').fadeOut(200);
    return true;
  }
});

$('#yumenu-<?php echo $module; ?> .itoggle').click(function(e) {
  e.preventDefault();
  if ($(window).width() < 768) {
    $(this).next().slideToggle(200);
    $(this).parent().toggleClass('mob-sub-open');
    $(this).parent().siblings('.mob-sub-open').removeClass('mob-sub-open').find('>div').not('.ilink').slideToggle(200);
  } else {
    $(this).parent().toggleClass('sub-open');
    $(this).parent().siblings('.sub-open').removeClass('sub-open');
    $(this).next().fadeToggle(200);
  }
});

$(window).on('resize', function() {
  var container = $('#yumenu-<?php echo $module; ?>').closest('.container').width();
  var menu = $('#yumenu-<?php echo $module; ?>').outerWidth();
  $('#yumenu-<?php echo $module; ?> .yum-fm > li > .isub').outerWidth(container+1-menu);
}).resize();

var toggle = $('#yumenu-<?php echo $module; ?> .toggle-heading');

if (<?php echo $save_view; ?>) {
  if (!localStorage.getItem('yumenu-<?php echo $module; ?>')) {
    if (<?php echo $minimized; ?>) {
      localStorage.setItem('yumenu-<?php echo $module; ?>', 'collapsed');
    } else {
      localStorage.setItem('yumenu-<?php echo $module; ?>', 'expanded');
    }
  }

  $(toggle).click(function() {
    $(this).toggleClass('menu-expanded menu-collapsed').next().slideToggle(200);
    if ($(this).hasClass('menu-expanded')) {
      localStorage.setItem('yumenu-<?php echo $module; ?>', 'expanded');
    } else {
      localStorage.setItem('yumenu-<?php echo $module; ?>', 'collapsed');
    }
  });

  if (localStorage.getItem('yumenu-<?php echo $module; ?>') == 'expanded') { 
    toggle.addClass('menu-expanded').removeClass('menu-collapsed').next().show();
  } else {
    toggle.addClass('menu-collapsed').removeClass('menu-expanded').next().hide();
  }
} else {
  localStorage.removeItem('yumenu-<?php echo $module; ?>');
  $(toggle).click(function() {
    $(this).toggleClass('menu-expanded menu-collapsed').next().slideToggle(200);
  });
}
//--></script>