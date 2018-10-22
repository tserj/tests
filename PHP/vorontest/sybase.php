<?php
//$db = sybase_connect('ase64k2', 'amolsky_dev', 'compaq', 'UTF8');
//sybase_select_db('k2',$db);

$obl = "Ростовск.";
$city = "Каменск";

print "	<html>
		<head>
			<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />
			<script type=\"text/javascript\">
				function inputText(fId,lId) {
					alert (lId + '   ' + fId + document.all[fId].value);
				}
			</script>
		</head>
		<body>
		
		<table style='border: 0px;'>
					<tr><td id=fRegion>Регион</td><td>$obl</td></tr>
					<tr><td id=lRegion>Город</td><td>$city</td></tr>
					
					<tr><td><input type=text name=city id=lCity onclick=\"inputText('fCity','lCity');\"><td></tr>
					</table>
</body>					
</html>					
					";
					
					
die();

					
$action = $_GET['action'];

switch ($action) {
	case 'edit':
		echo 'edit';
		break;
	case 'show':
		$contract = $_REQUEST['contract'];
		if ($contract == '') {
			$contract = $_GET['contract'];
		}
		$q = sybase_query("SELECT tpr_cas_id, tco_id, tco_number, tpr_born_place, t_person.* FROM t_person inner join t_contract on tpr_id = tco_tpr_id where tco_number in ('".$contract."')", $db);
    	while($row = sybase_fetch_row($q)) {
    		$bplace = str_replace (" ", "_", $row[3]);
        	print "	<table style='border: 1px solid black;width:50%;'>
        			<tr><td>Договор</td><td>$row[2]</td></tr>
        			<tr><td>Фамилия</td><td>$row[9]</td><td><a href=index.php?action=esurname&contract=$contract&value=$row[9]>Изменить</a></td></tr>
        			<tr><td>Имя</td><td>$row[7]</td><td><a href=index.php?action=ename&contract=$contract&value=$row[7]>Изменить</a></td></tr>
        			<tr><td>Отчество</td><td>$row[8]</td><td><a href=index.php?action=emidname&contract=$contract&value=$row[8]>Изменить</a></td></tr>
        			<tr><td>Страховое</td><td>$row[15]</td></tr>
        			<tr><td>Дата рождения</td><td>$row[13]</td><td></td></tr>
        			<tr><td>Место рождения</td><td>$row[3]</td><td><a href=index.php?action=ebplace&contract=$contract&value=$bplace>Изменить</a></td></tr>
        			</table>";
        	//print_r ($row);
        }
        
		$q = sybase_query("select cad_region, cad_city, cad_point, cad_district, cad_street, cad_block, cad_house, cad_corpus, cad_apartment, cad_postal_code FROM t_address, t_cat_address_type, t_person WHERE cad_tpr_id = tpr_id and cat_id = cad_cat_id and cad_tpr_id = (select tco_tpr_id from t_contract where tco_number = '".$contract."') and cad_cat_id = 2");
		while($row = sybase_fetch_row($q)) {
			for ($i=0;$i<count($row);$i++) {
				$value .= str_replace (" ", "_",$row[$i])."|";
			}
			
				
			//print_r ($row);
		}
		print "	<form action=\"index.php?action=show\" method=post>
				<input name=contract type=text>
				<input type=submit value=\"Найти договор\">";
		break;
	case 'esurname':
		$contract = $_GET['contract'];
		print "	<form action=\"index.php?action=usurname&contract=$contract\" method=post>
				<table style='border: 1px solid black;width:50%;'>
				<tr><td>Старое значение</td><td>Новое значение</td><td></td><tr>
				<tr><td>".$_GET['value']."</td><td><input type=text name=newvalue></td><td><input type=submit value=\"Изменить\"</td><tr>
				</table>
				</form>
				<a href=index.php?action=show&contract=$contract>Назад</a>";
		break;
	case 'ename':
		$contract = $_GET['contract'];
		print "	<form action=\"index.php?action=uname&contract=$contract\" method=post>
				<table style='border: 1px solid black;width:50%;'>
				<tr><td>Старое значение</td><td>Новое значение</td><td></td><tr>
				<tr><td>".$_GET['value']."</td><td><input type=text name=newvalue></td><td><input type=submit value=\"Изменить\"</td><tr>
				</table>
				</form>
				<a href=index.php?action=show&contract=$contract>Назад</a>";
		break;
	case 'emidname':
		$contract = $_GET['contract'];
		print "	<form action=\"index.php?action=umidname&contract=$contract\" method=post>
				<table style='border: 1px solid black;width:50%;'>
				<tr><td>Старое значение</td><td>Новое значение</td><td></td><tr>
				<tr><td>".$_GET['value']."</td><td><input type=text name=newvalue></td><td><input type=submit value=\"Изменить\"</td><tr>
				</table>
				</form>
				<a href=index.php?action=show&contract=$contract>Назад</a>";
		break;
	case 'ebdate':
		$contract = $_GET['contract'];
		print "	<form action=\"index.php?action=ubdate&contract=$contract\" method=post>
				<table style='border: 1px solid black;width:50%;'>
				<tr><td>Старое значение</td><td>Новое значение</td><td></td><tr>
				<tr><td>".$_GET['value']."</td><td><input type=text name=newvalue></td><td><input type=submit value=\"Изменить\"</td><tr>
				</table>
				</form>
				<a href=index.php?action=show&contract=$contract>Назад</a>";
		break;
	case 'ebplace':
		$contract = $_GET['contract'];
		$bplace = $_GET['value'];
		$bplace = str_replace ("_", " ", $bplace);
		print "	<form action=\"index.php?action=ubplace&contract=$contract\" method=post>
				<table style='border: 1px solid black;width:50%;'>
				<tr><td>Старое значение</td><td>Новое значение</td><td></td><tr>
				<tr><td>".$bplace."</td><td><input type=text name=newvalue></td><td><input type=submit value=\"Изменить\"</td><tr>
				</table>
				</form>
				<a href=index.php?action=show&contract=$contract>Назад</a>";
		break;
	case 'eaddress':
		$contract = $_GET['contract'];
		$address = $_GET['value'];
		$address = explode ("|",$address);
		print_r ($address);
		print "	<form action=\"index.php?action=uaddress\" method=post>
				<table style='border: 1px solid black;width:50%;'>
					<tr><td>Регион</td><td id=fRegion>$address[0]</td><td><input type=text name=region id=lRegion onclick=\"inputText('fRegion','lRegion');\"></td></tr>
					<tr><td>Город</td><td id=fCity>$address[1]</td><td><input type=text name=city id=lCity onclick=\"inputText('fCity','lCity');\"></td></tr>
					<tr><td>Point</td><td>$address[2]</td></tr>
					<tr><td>Disctrict</td><td>$address[3]</td></tr>
					<tr><td>Улица</td><td>$row[4]</td></tr>
					<tr><td>Block</td><td>$address[5]</td></tr>
					<tr><td>Дом</td><td>$address[6]</td></tr>
					<tr><td>Строение</td><td>$address[7]</td></tr>
					<tr><td>Квартира</td><td>$address[8]</td></tr>
					<tr><td>Индекс</td><td>$address[9]</td></tr>
					<tr><td align=right colspan=2><a href=index.php?action=eaddress&contract=$contract&value=$value>Изменить адрес</a></td></tr>
					</table>
					</form>";
		break;
	case 'usurname':
		$contract = $_GET['contract'];
		$newValue = $_REQUEST['newvalue'];
		$q = "update t_person set tpr_last_name = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')";
		if (sybase_query ("update t_person set t_person.tpr_last_name = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')")) {
			echo "<br>Данные успешно обновлены<br><a href=index.php?action=show&contract=$contract>Назад</a>";
		}
		else {
			echo $q."<br>ЭВМ ошиблась";
		}
		break;
	case 'uname':
		$contract = $_GET['contract'];
		$newValue = $_REQUEST['newvalue'];
		$q = "update t_person set tpr_first_name = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')";
		if (sybase_query ("update t_person set tpr_first_name = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')")) {
			echo "<br>Данные успешно обновлены<br><a href=index.php?action=show&contract=$contract>Назад</a>";
		}
		else {
			echo $q."<br>ЭВМ ошиблась";
		}
		break;
	case 'umidname':
		$contract = $_GET['contract'];
		$newValue = $_REQUEST['newvalue'];
		$q = "update t_person set tpr_middle_name = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')";
		if (sybase_query ("update t_person set tpr_middle_name = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')")) {
			echo "<br>Данные успешно обновлены<br><a href=index.php?action=show&contract=$contract>Назад</a>";
		}
		else {
			echo $q."<br>ЭВМ ошиблась";
		}
		break;
	case 'ubplace':
		$contract = $_GET['contract'];
		$newValue = $_REQUEST['newvalue'];
		$q = "update t_person set tpr_born_place = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')";
		if (sybase_query ("update t_person set tpr_born_place = '$newValue' where tpr_id = (select tco_tpr_id from t_contract where tco_number = '$contract')")) {
			echo "<br>Данные успешно обновлены<br><a href=index.php?action=show&contract=$contract>Назад</a>";
		}
		else {
			echo $q."<br>ЭВМ ошиблась";
		}
		break;

	
	default:
		print '
				<form action="index.php?action=show" method=post>
				<input name=contract type=text>
				<input type=submit value="Найти договор">';
}
print '
		</body>
		</html>';

//sybase_close($db);

die();

?> 
