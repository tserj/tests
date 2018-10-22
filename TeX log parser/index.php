<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
   <meta http-equiv="content-type" content="text/html; charset=windows-1251">
   <title>Errors</title>
</head>
<body text="#000000" bgcolor="#ffffff" background="">

<?php

function key_compare_func($key1, $key2)
{
    if ($key1 == $key2)
        return 0;
    else if ($key1 > $key2)
        return 1;
    else
        return -1;
}

    $SEPARATOR = "|^|";
    $txt_arr = array();
    $arr = array();
    $idx = 0;

    $filesdir = scandir(".");
    foreach ($filesdir as $fname) 
        if ($fname != "." && $fname != ".." && $fname != "index.php" && $fname != "errors.txt") {
            
            $arr = file( $fname ) or $arr="";
            $cnt = count($arr); 
            $cdname = "";

            for ($i=0; $i<$cnt; $i++) 
                if (strstr($arr[$i], "teximages") && strlen($cdname) < 1) {
                    $str = $arr[$i];
                    $str = preg_replace("/(.+?)?teximages\/\w/is", "", $str);
                    $str = preg_replace("/-(.+)?/is", "", $str);
                    $cdname = $str;
                    break;
                }

            $txt = "";
            for ($i=0; $i<$cnt; $i++) 
                if (strstr($arr[$i], "!")) {
                    if (strlen($cdname)>0) $txt .= "[$cdname]$SEPARATOR";
                    else $txt .= "[logfile: $fname]$SEPARATOR";

                    $txt .= $arr[$i]; 

                    $txt_arr[$idx] = $txt;
                    $idx++; 
                    $txt = "";
                }
        }
    
    
    // delete doubles
    $txt_arr = array_unique($txt_arr);
    $arr = array();
    $txt_arr_out = array();
    $idx = 0;

    // unpack arrays
    foreach ($txt_arr as $str) {
       $arr = explode($SEPARATOR, $str);
       $txt_arr_out[$idx] = array("$arr[0]" => "$arr[1]");
       $idx++;
    }
    
    // find all queries
    $queries = array();
    foreach ($txt_arr_out as $k=>$v) {
        $arr = array_values($v);
        $queries[] = $arr[0];
    }
    
    // delete queries doubles
    $queries = array_unique($queries);
            
    //sort and show 
    $txt = "";
    echo '<table border="1"><th>Articles</th><th>Bug</th>';
    foreach ($queries as $query) {
        echo "<tr><td>";
        $txt .= "*******************************************\n";
        $txt .= "|  BUG : ".$query;
        $txt .= "-------------------------------------------\n";
        foreach ($txt_arr_out as $k=>$v) {
            $arr = array_values($v);
            if ($query == $arr[0]) {
                $arr = array_keys($v);
                echo $arr[0]."<br/>";
                $txt .= "$arr[0]\n";
            }
        }
        $query = preg_replace("/\</is", "&lt;", $query);
        $query = preg_replace("/\>/is", "&gt;", $query);
        echo "</td><td align=\"center\">$query</td></tr>";
        $txt .= "*******************************************\n\n\n";
    }
    echo '</table>';
    
    //save results to txt file
    $filename = "./errors.txt";
    $fp = @fopen($filename, "w+");
    @fputs($fp, $txt);
    @fclose($fp);
    @ob_flush; 
    @flush();
?>


</body>
</html>
