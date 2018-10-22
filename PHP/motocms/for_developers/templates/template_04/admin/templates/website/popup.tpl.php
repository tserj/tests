<?php
	$this->extend('layout');
?>

<?php $this->set('title', $websiteTitlePrefix . " " . $page->title) ?>

<?php if (!empty($websiteTitlePrefix)): ?>
<?php $this->set('websiteTitle', $websiteTitlePrefix) ?>
<?php endif; ?>

<?php if (!empty($page->title)): ?>
<?php $this->set('pageTitle', $page->title) ?>
<?php endif; ?>

<?php echo $pageData ?>

<?php if ($this->has('content')): ?>
<?php $this->output('content') ?>
<?php endif; ?>