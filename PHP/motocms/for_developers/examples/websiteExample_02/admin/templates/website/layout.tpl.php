<?php
if (!isset($isFaceBook))
{
    $isFaceBook = false;
	if (defined('TEMPLATE_TYPE') && TEMPLATE_TYPE == 'facebook')
		$isFaceBook = true;
}
if (!isset($app_id) || $app_id == '')
{
	$app_id = '189613811101522';
	if (defined('FACEBOOK_APPLICATION_ID') && FACEBOOK_APPLICATION_ID != '')
		$app_id = FACEBOOK_APPLICATION_ID;
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title><?php $this->output('title') ?></title>
	<meta content="IE=8" http-equiv="X-UA-Compatible" />
<?php if (isset($pageFavicon))
{
	foreach($pageFavicon as $favicon)
	{
		echo '<link '
			. (isset($favicon["rel"]) && $favicon["rel"]!="" ? ' rel="' . $favicon["rel"] . '"':'')
			. (isset($favicon["href"]) && $favicon["href"]!="" ? ' href="' . $favicon["href"] . '"':'')
			. (isset($favicon["type"]) && $favicon["type"]!="" ? ' type="' . $favicon["type"] . '"':'')
			. " />\n";
	}
} ?>

    <meta http-equiv="Content-Type" content="text/html; charset=<?php echo $this->getCharset() ?>" />
    <?php if ($this->has('meta-description')): ?>
    <meta name="description" content="<?php $this->output('meta-description') ?>" />
    <?php endif; ?>

    <?php if ($this->has('meta-keywords')): ?>
    <meta name="keywords" content="<?php $this->output('meta-keywords') ?>" />
    <?php endif; ?>

    <?php if ($this->has('meta-robots')): ?>
    <meta name="robots" content="<?php $this->output('meta-robots') ?>" />
    <?php endif; ?>

    <?php if ($this->has('meta-google-webmaster-tools')): ?>
    <meta name="verify-v1" content="<?php $this->output('meta-google-webmaster-tools') ?>" />
    <meta name="google-site-verification" content="<?php $this->output('meta-google-webmaster-tools') ?>" />
    <?php endif; ?>

    <?php $this->javascripts->add('assets/swfobject/swfobject.js') ?>
    <?php $this->javascripts->add('assets/swfaddress/swfaddress.js') ?>
	<?php $this->javascripts->add('http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js') ?>
    <?php $this->javascripts->add('assets/motoResize.js') ?>
    <?php $this->javascripts->add('assets/htmlWidget/htmlWidget.js') ?>
    <?php $this->stylesheets->add('style.css'); ?>
	<?php
	$filename = dirname(__FILE__) . '/header.tpl.php';
	if (file_exists($filename))
	{
		try
		{
			error_reporting(E_ALL ^ E_NOTICE);
			include_once($filename);
		}
		catch(Exception $e)
		{
		}
	}
	?>	
    <?php echo $this->javascripts ?>
    <?php echo $this->stylesheets ?>

    <?php if (isset($isUserBgColor) && $isUserBgColor):?>
<style type="text/css">
<!--
body {background-color: <?php echo $bgColor?>;}
-->
</style>
    <?php endif;?>

	<?php if (isset($useFlashScroll) && strtolower($useFlashScroll) == 'true'):?>
<style type="text/css">
html
{
	//overflow-y:hidden;
}
</style>
    <?php endif;?>

    <script type="text/javascript">
        var isDynamicHeight = <?php echo ( defined('DYNAMIC_HEIGHT') ? DYNAMIC_HEIGHT : 'false') ?>;
        var pageHeight = null;
		var useFlashScroll = <?php echo (isset($useFlashScroll) ? $useFlashScroll : 'false') ?>;
		var minWidth = <?php echo $websiteMinWidth ?>;
		var minHeight = <?php echo $websiteMinHeight ?>;

        var flashvars = {
            url: "<?php echo $pageURL ?>",
            basePath: "<?php echo $basePath ?>",
            configurationFile: "config.xml?time=<?php echo time()?>"<?php
			if (isset($swfobject) && isset($swfobject['flashvars']))
			{
				foreach($swfobject['flashvars'] as $name => $value)
				{
					echo ",\n            " . $name . ': "' . $value . '" ' . "\n";
				}
				
			}
?>
        };
        
		var params = {
            <?php 
                if (isset($wmode) && $wmode != '')
                    echo 'wmode: "' . $wmode . '",' ."\n";
            ?>
            menu: "false",
            bgcolor: "<?php echo $bgColor ?>",
            allowScriptAccess: "always",
            scale: "noscale",
            allowFullScreen: "true"<?php
			if (isset($swfobject) && isset($swfobject['params']))
			{
				foreach($swfobject['params'] as $name => $value)
				{
					echo ",\n            " . $name . ': "' . $value . '" ' . "\n";
				}
				
			}
?>
        };
		
        var attributes = {
            id: "website_swf"
		};		
		
       	swfobject.embedSWF("<?php echo $this->assets->getUrl('moto.swf') ?>", "flashcontent", "<?php echo $websiteWidth ?>", "<?php echo $websiteHeight ?>", "<?php echo $flashPlayerVersionRequired ?>", "<?php echo $this->assets->getUrl('assets/swfobject/expressinstall.swf') ?>", flashvars, params, attributes);
		if (swfobject.hasFlashPlayerVersion("6.0.0")) {
			swfobject.addDomLoadEvent(createFullBrowserFlash);
		}
        
    </script>
	
<?php if ($isFaceBook) { ?>
<style type="text/css">
<!--
body,html {margin:0;padding:0;border:0;overflow-x:hidden;background:white;}
#container{width:520px;margin:0 auto;}
-->
</style>
<?php } ?>

  </head>
  <body <?php echo (isset($useFlashScroll) && strtolower($useFlashScroll) == 'true' ?  'style="overflow-y:hidden"' : '') ?>>

<?php if ($isFaceBook) { ?>
<div id="fb-root"></div>
<script type="text/javascript" src="https://connect.facebook.net/en_US/all.js"></script>
<script type="text/javascript">
if (document.location.protocol == 'https:')
	FB._https = true;
FB.init({appId:'<?php echo $app_id?>',cookie:true,status:true,xfbml:true, oauth: true});
function setScreenHeight(value)
{
    if (!useFlashScroll)
    {
		$(window).scrollTop(0);
        $('#'+attributes.id).height(value);
        minHeight = value;
		FB.Canvas.setSize({height: value+2});
        return true;
    }
    return false;
}
function getScreenRect()
{
	var w = {};
	var onFB = false;
	if (typeof FB != 'undefined' && typeof FB.Canvas != 'undefined' && typeof FB.Canvas.getPageInfo() != 'undefined')
	{
		var info = FB.Canvas.getPageInfo();
		if (typeof info.clientHeight != 'undefined' && typeof info.clientWidth != 'undefined' && info.clientHeight > 0 && info.clientWidth > 0)
			onFB = true;
	}
	var swf = $('#'+attributes.id);
	var div = swf.parent();
	if (onFB)
	{
		var _w = FB.Canvas.getPageInfo();
		for(var i in _w)
			w[i] = _w[i];
		w.scrollTop -= w.offsetTop;
		if (w.scrollTop < 0)
			w.scrollTop = 0;
	}
	else
	{
		w.scrollLeft = $(window).scrollLeft();
		w.scrollTop = $(window).scrollTop();
		w.clientHeight = Math.min(div.height(), swf.height());
	}
	return [w.scrollLeft, w.scrollTop, Math.min(div.width(), swf.width()), w.clientHeight];
}
</script>
<?php } ?>


        <div id="htmlContainer" class="absolute"></div>
        <div id="container">
<?php

	$content = '';
	$content .= '<div id="flashcontent">';

	$content .= '<div id="page_content">';

	if ($this->has('websiteTitle'))
		$content .= "<h1>" . $this->get('websiteTitle') . "</h1>";

	if ($this->has('pageTitle'))
		$content .= "<h2>" . $this->get('pageTitle') . "</h2>";

	if ($this->has('navigation'))
		$content .= '<ul id="navigation" class="menu">' . $this->get('navigation') . '</ul>';

	$content .= "\n" . '<div id="alternateContent">';
	$content .= str_replace('<font>','', trim($this->get('content')));
	$content .= "\n" . '</div>';

	$content .= '</div>'; /// id="page_content"
	/*
	$content.=<<<__END__TXT__
	      <div class="error">
			<br /><br />Please <a href="http://www.adobe.com/go/getflashplayer" target="_blank"><b>get your Flash Player</b></a> to view the animated version of this website.
	      </div>
__END__TXT__;
*/
	$content.=<<<__END__TXT__
		<div class="poweredby">
			<br /><a href="http://www.motocms.com/why/" target="_blank">Flash website</a> powered by <a href="http://www.motocms.com/" target="_blank">Moto CMS</a>	      
		</div>
__END__TXT__;

	$content .= '</div>';
	$tmplfile = dirname(__FILE__) . '/design.tpl.php';
	if ((file_exists($tmplfile)) && (filesize($tmplfile) > 0))
	{
		$content = str_replace('%TEMPLATE_CONTENT%', $content, implode('', file($tmplfile)));
	}
	echo $content;
	?>

    </div>
    <?php if ($this->has('googleAnalytics')): ?>
    <?php $this->output('googleAnalytics') ?>
    <?php endif; ?>
  </body>
</html>
