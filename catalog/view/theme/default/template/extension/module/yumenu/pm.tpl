<div id="yumenu-<?php echo $module; ?>" class="<?php echo $box_class; ?>">
  <?php if ($title) { ?>
  <div class="<?php echo $title_class ? $title_class : ''; ?> <?php echo $minimized ? 'menu-collapsed' : 'menu-expanded'; ?> toggle-heading"><?php echo $title; ?></div>
  <?php } ?>
  <div class="yum-pm" <?php echo $minimized ? 'style="display:none"' : ''; ?>>
    <ul>
      <?php if ($custom_items) {
        echo $items;
      } else {
        $menu = function ($items,$column,$i=0) use (&$menu) {
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
                echo '<ul><li class="iparent active"><a class="ilink itoggle pm-prev">';
                echo '<div class="ititle';
                if ($item['count']) {
                  echo ' icount';
                }
                echo '">'.$item['title'];
                if ($item['count']) {
                  echo '<span class="ibadge">'.$item['count'].'</span>';
                }
                echo '</div></a></li>';
                $menu($item['children'],$column,$i+1);
                echo '</ul>';
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
$('#yumenu-<?php echo $module; ?> .yum-pm > ul').show().parent().css('overflow', 'hidden');
$('#yumenu-<?php echo $module; ?> .itoggle').not('.pm-prev').click(function(e,act) {
  e.preventDefault();
  if (act=='active') {
    $(this).parents('ul').addClass('pm-invisible').show();
    $(this).next().show();
  } else {
    $(this).parents('ul').show().addClass('pm-invisible pm-trans');
    $(this).next().fadeIn(200);
  }
  $(this).parent().siblings().find('>ul').hide();

  var height = $(this).next().outerHeight(true);

  if (act=='active') {
    $('#yumenu-<?php echo $module; ?> .yum-pm > ul').parent().height(height);
  } else {
    $('#yumenu-<?php echo $module; ?> .yum-pm > ul').parent().animate({'height': height}, 200);
  }
});

$('#yumenu-<?php echo $module; ?> .pm-prev').on('click', function(e) {
  e.preventDefault();
  var height = $(this).closest('.pm-invisible').outerHeight(true);
  $(this).parents('ul.pm-invisible').addClass('pm-trans');
  $('#yumenu-<?php echo $module; ?> .yum-pm > ul').parent().animate({'height': height}, 200);
  $(this).closest('.pm-invisible').find('>li.active').not('li.active:first').removeClass('active');
  $(this).closest('.pm-invisible').removeClass('pm-invisible');
  $(this).closest('ul').fadeOut(200);
});

$('#yumenu-<?php echo $module; ?> li > .icurrent').each(function() {
  if ($(this).hasClass('itoggle')) {
    $(this).trigger('click', ['active']);
  } else {
    $(this).closest('ul').parents('ul').addClass('pm-invisible').show();
    $(this).closest('ul').show();
    $(this).parent().removeClass('active');

    var height = $(this).closest('ul').outerHeight(true);
    $('#yumenu-<?php echo $module; ?> .yum-pm > ul').parent().height(height);
  }
});

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