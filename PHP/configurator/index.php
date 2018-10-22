<?php
    require_once   "functions.php";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr"> 
<head>
    <title>Конфигуратор</title>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />

    <link href="css/main.css" rel="stylesheet" type="text/css" />
    <link href="css/notes.css" rel="stylesheet" type="text/css" />
    
	<script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/notes.js"></script>
    <script type="text/javascript" src="js/ajax.js"></script>

    <script type="text/javascript" src="js/niftycube.js"></script>
    <script type="text/javascript">
        window.onload=function(){
            Nifty("div.color","transparent bottom left right top big");
        }
    </script>
</head>

<body>

<table id="main" cellpadding="0" cellspacing="0" class="centerTable">
    <tr>
        <td width="130px">
            <table id="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="section">
                    	<?php showType(); ?>
                    </td>
                </tr>
                <tr>
                    <td class="section">                    	
                        <?php showSize(); ?>
                    </td>
                </tr>
                <tr>
                    <td class="section">
                        <?php showBuckleType(); ?>
                    </td>
                </tr>
                <tr>
                    <td class="section">
                        <?php showLining(); ?>
                    </td>
                </tr>
                <tr>
                    <td class="section">
                        <?php showPrice(); ?>
                    </td>
                </tr>
            </table>
        </td>

        <td width="520px" >
            <table id="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="bigsection" colspan="4">
                        <table cellpadding="0" cellspacing="0">
                            <tr><td width="2px"><div class="bgBigLeft" /></td><td><?php showMain(); ?></td><td width="2px"><div class="bgBigRight" /></td></tr>
                            <tr height="2px"><td></td><td><div class="bgBigBottom"/></td><td></td></tr>
                        </table>
                    </td>
                </tr>
                <tr>                    
                    <td class="section">
                        <?php showLines(); ?>
                    </td>
                    <td class="section">
                        <?php showNodeType(); ?>
                    </td>
                    <td class="section">
                        <?php showThickness(); ?>
                    </td>
                    <td class="section">
                        <?php showLabel(); ?>
                    </td>
                </tr>
            </table>
        </td>

        <td width="130px" >
            <table id="right" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="longsection">
                        <?php showColors(); ?>                        
                    </td>
                </tr>
                <tr>
                    <td class="section">                        
                        <?php showFinish(); ?>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<script>btn1Vars()</script>

</body>
</html>
