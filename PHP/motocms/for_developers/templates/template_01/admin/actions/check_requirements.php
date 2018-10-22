<?php
if (file_exists('./../config/ProjectConfig.php'))
	require_once './../config/ProjectConfig.php';
if (class_exists("ProjectConfig"))
	ProjectConfig::startSession();

if (!defined("MOTO_ROOT_DIR"))
	define('MOTO_ROOT_DIR', str_replace('\\', '/', realpath(dirname(__FILE__) . '/../..')));
if (!defined("MOTO_ADMIN_DIR"))
	define('MOTO_ADMIN_DIR', str_replace('\\', '/', realpath(dirname(__FILE__) . '/..')));

define('PARAMETERS_DILIMITER', '@data:');
define('DATA_PARAMETERS_DILIMITER', ';');

error_reporting(E_ALL);
ini_set('display_errors', 'off');
ini_set('log_errors', 'on');
ini_set('error_log', MOTO_ADMIN_DIR . '/logs/php_error.log');

require_once MOTO_ADMIN_DIR . '/libs/Moto/MotoRequirements.php';

$requirements = new MotoRequirements();

/* PHP configuration */
$requirements->addValidator('mail_function', array(
    'fail_message' => 'Warning: SERVER_TEST_MAIL_ERROR
							SERVER_TEST_MAIL_ERROR_DETAILS'
));

$requirements->addValidator('php_version', array(
    'min' => '5.2.1',
    'fail_message' => 'Error: SERVER_TEST_PHP_VERSION_ERROR'. PARAMETERS_DILIMITER .'"%php_version%"'. DATA_PARAMETERS_DILIMITER . '"%min%"
							SERVER_TEST_PHP_VERSION_ERROR_DETAILS'
));

$requirements->addValidator('php_upload_file_size', array(
    'min' => '2M',
    'fail_message' => 'Warning: SERVER_TEST_MAXIMUM_UPLOAD_FILE_SIZE' . PARAMETERS_DILIMITER . '"%upload_max_size%"' . DATA_PARAMETERS_DILIMITER . '"%min%"
                       SERVER_TEST_MAXIMUM_UPLOAD_FILE_SIZE_DETAILS',
));

$requirements->addValidator('php_upload_enabled', array(
    'fail_message' => 'Warning: SERVER_TEST_UPLOAD_DISABLED
                       SERVER_TEST_UPLOAD_DISABLED_DETAILS',
));

$requirements->addValidator('php_extension_loaded', array(
    'extension' =>  'spl',
    'fail_message' => 'Error:SERVER_TEST_EXTENSION_NOT_LOADED' . PARAMETERS_DILIMITER . '"%extension%"'
));

$requirements->addValidator('php_extension_loaded', array(
    'extension' =>  'gd',
    'fail_message' => 'Warning:SERVER_TEST_EXTENSION_NOT_LOADED' . PARAMETERS_DILIMITER . '"%extension%"'
));

$requirements->addValidator('php_extension_loaded', array(
    'extension' =>  'dom',
    'fail_message' => 'Error:SERVER_TEST_EXTENSION_NOT_LOADED' . PARAMETERS_DILIMITER . '"%extension%"'
));

$requirements->addValidator('php_extension_loaded', array(
    'extension' =>  'reflection',
    'fail_message' => 'Error:SERVER_TEST_EXTENSION_NOT_LOADED' . PARAMETERS_DILIMITER . '"%extension%"'
));

$requirements->addValidator('php_extension_loaded', array(
    'extension' =>  'mcrypt',
    'fail_message' => 'Error:SERVER_TEST_EXTENSION_NOT_LOADED' . PARAMETERS_DILIMITER . '"%extension%"'
));

$requirements->addValidator('php_extension_loaded', array(
    'extension' =>  'curl',
    'fail_message' => 'Error:SERVER_TEST_EXTENSION_NOT_LOADED' . PARAMETERS_DILIMITER . '"%extension%"'
));

$requirements->addValidator('php_extension_loaded', array(
    'extension' =>  'Zend Optimizer|Zend Guard Loader',
    'fail_message' => 'Error:SERVER_TEST_EXTENSION_NOT_LOADED' . PARAMETERS_DILIMITER . '"%extension%"'
));

/* File system */
$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/',
    'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/xml/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_readable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/',
    'fail_message' => 'Error: SERVER_TEST_DIRECTORY_READ_ERROR' . PARAMETERS_DILIMITER . '"/xml/"
                  SERVER_TEST_DIRECTORY_READ_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/modules',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/xml/modules/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/media/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/media/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/fonts/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/fonts/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/images/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/images/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/music/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/music/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/video/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/video/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

/* files */
$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/assets.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/xml/assets.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/admin/xml/system.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/xml/system.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/settings.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/xml/settings.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/content.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/xml/content.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/fonts.xml',
	'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/xml/fonts.xml"
				SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ROOT_DIR . '/xml/menus.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/xml/menus.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

/* ADMIN */

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ADMIN_DIR . '/logs/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/logs/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ADMIN_DIR . '/xml/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/xml/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ADMIN_DIR . '/data/',
	'fail_message' => 'Error: SERVER_TEST_DIRECTORY_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/data/"
                 SERVER_TEST_DIRECTORY_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ADMIN_DIR . '/data/users.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/data/users.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ADMIN_DIR . '/config.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/config.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ADMIN_DIR . '/xml/config.xml',
        'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/xml/config.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->addValidator('file_writable', array(
    'file' =>  MOTO_ADMIN_DIR . '/xml/mediaLibrary.xml',
    'fail_message' => 'Error: SERVER_TEST_FILE_WRITE_ERROR' . PARAMETERS_DILIMITER . '"/admin/xml/mediaLibrary.xml"
                 SERVER_TEST_FILE_WRITE_ERROR_DETAILS'
));

$requirements->check();
header('Content-Type: text/xml');
?>
<?php echo '<?xml version="1.0" encoding="utf-8"?>' ?>
<response>
  <serverIsValid><?php echo $requirements->isValid() ? 'true' : 'false'; ?></serverIsValid>
  <errors>
    <?php foreach ($requirements->getMessages() as $message): ?>
      <error>
        <type><?php echo $message[0]; ?></type>
        <message><?php echo $message[1]; ?></message>
        <details><?php echo $message[2]; ?></details>
      </error>
    <?php endforeach; ?>
  </errors>
</response>