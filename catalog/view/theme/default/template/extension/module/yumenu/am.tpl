<div id="yumenu-<?php echo $module; ?>" class="<?php echo $box_class; ?>">
  <?php if ($title) { ?>
  <div class="<?php echo $title_class ? $title_class : ''; ?> <?php echo $minimized ? 'menu-collapsed' : 'menu-expanded'; ?> toggle-heading"><?php echo $title; ?></div>
  <?php } ?>
  <div class="yum-am" <?php echo $minimized ? 'style="display:none"' : ''; ?>>
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
              if ($i>0) {
                echo ' style="padding-left:'.($i+.5).'em"';
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

              if (isset($item['children'])) {
                echo '<div class="ibtn itoggle"></div>';
              }

              echo '</a>';

              if (isset($item['children'])) {
                echo '<ul>';
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
$('#yumenu-<?php echo $module; ?> .itoggle').click(function(e) {
  e.preventDefault();

  var li = $(this).closest('li');
  var ch = li.find('>ul').height();
  var ah = li.find('>ul').css('height','auto').height();

  if (ah>ch) {
    li.addClass('active').find('>ul').height(ch).animate({'height':ah}, 200);
  } else {
    li.removeClass('active').find('>ul').animate({'height':0}, 200);
  }

  li.closest('ul').css('height','auto');
  li.siblings('.active').removeClass('active').find('>ul').css('height','auto').animate({'height':0}, 200);
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
