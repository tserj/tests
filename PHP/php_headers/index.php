<?php

echo 'HTTP_ACCEPT = '.          $_SERVER['HTTP_ACCEPT']."<br>";
echo 'HTTP_ACCEPT_LANGUAGE = '. $_SERVER['HTTP_ACCEPT_LANGUAGE']."<br>";
echo 'HTTP_HOST = '.            $_SERVER['HTTP_HOST']."<br>";
echo 'HTTP_REFERER = '.         $_SERVER['HTTP_REFERER']."<br>";
echo 'HTTP_USER_AGENT = '.      $_SERVER['HTTP_USER_AGENT']."<br>";
echo 'REMOTE_ADDR = '.          $_SERVER['REMOTE_ADDR']."<br>";
echo 'SCRIPT_FILENAME = '.      $_SERVER['SCRIPT_FILENAME']."<br>";
echo 'SERVER_NAME = '.          $_SERVER['SERVER_NAME']."<br>";
echo 'HTTP_HOST = '.            $_SERVER['HTTP_HOST']."<br>";
echo 'SERVER_ADDR = '.          $_SERVER['SERVER_ADDR']."<br>";
echo 'SERVER_PORT = '.          $_SERVER['SERVER_PORT']."<br>";
echo 'SERVER_SOFTWARE = '.      $_SERVER['SERVER_SOFTWARE']."<br>";
echo 'SERVER_PROTOCOL = '.      $_SERVER['SERVER_PROTOCOL']."<br>";
echo 'REQUEST_METHOD = '.       $_SERVER['REQUEST_METHOD']."<br>";
echo 'QUERY_STRING = '.         $_SERVER['QUERY_STRING']."<br>";
echo 'PHP_SELF = '.             $_SERVER['PHP_SELF']."<br>";
echo 'REQUEST_URI = '.          $_SERVER['REQUEST_URI']."<br>"; 
echo 'SCRIPT_NAME = '.          $_SERVER['SCRIPT_NAME']."<hr>"; 
 
print_r($_SERVER);

?>
