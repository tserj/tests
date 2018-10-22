<?php
require_once 'Zend/Loader.php';
Zend_Loader::loadClass('Zend_Gdata');
Zend_Loader::loadClass('Zend_Gdata_ClientLogin');
Zend_Loader::loadClass('Zend_Gdata_Calendar');

// Пример использования
//	addNewEvent ('alex.molskiy@gmail.com', 'password', 'Eto_bydet_otpravleno_v_sms', 'Opisanie', 'Mesto_toje_bydet_v_sms', '2010-06-28', '15:20', '2010-06-28', '15:30', '+04', '1' );


function getEvent($client, $eventId)
{
  $gdataCal = new Zend_Gdata_Calendar($client);
  $query = $gdataCal->newEventQuery();
  $query->setUser('default');
  $query->setVisibility('private');
  $query->setProjection('full');
  $query->setEvent($eventId);

  try {
    $eventEntry = $gdataCal->getCalendarEventEntry($query);
    return $eventEntry;
  } catch (Zend_Gdata_App_Exception $e) {
    var_dump($e);
    return null;
  }
}

function createEvent ($client, $title = '',
    $desc='', $where = '',
    $startDate = '2012-12-31', $startTime = '23:59',
    $endDate = '2013-01-01', $endTime = '00:01', $tzOffset = '+04')
{
  $gdataCal = new Zend_Gdata_Calendar($client);
  $newEvent = $gdataCal->newEventEntry();
  
  $newEvent->title = $gdataCal->newTitle($title);
  $newEvent->where = array($gdataCal->newWhere($where));
  $newEvent->content = $gdataCal->newContent("$desc");
  
  $when = $gdataCal->newWhen();
  $when->startTime = "{$startDate}T{$startTime}:00.000{$tzOffset}:00";
  $when->endTime = "{$endDate}T{$endTime}:00.000{$tzOffset}:00";
  $newEvent->when = array($when);

  // Upload the event to the calendar server
  // A copy of the event as it is recorded on the server is returned
  $createdEvent = $gdataCal->insertEvent($newEvent);
  return $createdEvent->id->text;
}

function setReminder($client, $eventId, $minutes)
{
  $gc = new Zend_Gdata_Calendar($client);
  $method = "sms";
  if ($event = getEvent($client, $eventId)) {
    $times = $event->when;
    foreach ($times as $when) {
        $reminder = $gc->newReminder();
        $reminder->setMinutes($minutes);
        $reminder->setMethod($method);
        $when->reminders = array($reminder);
    }
    $eventNew = $event->save();
    return $eventNew;
  } else {
    return null;
  }
}

function addNewEvent ($user, $pass, $title, $desc, $where, $startDate, $startTime, $endDate, $endTime, $tzOffset, $minutes)
{
	//Авторизируемся в гугле
	$service = Zend_Gdata_Calendar::AUTH_SERVICE_NAME;
	$client = Zend_Gdata_ClientLogin::getHttpClient($user,$pass,$service);
	//Закончили авторизироваться
	
	//Создаем событие
	echo createEvent($client, $title, $desc, $where, $startDate, $startTime, $endDate, $endTime, $tzOffset, $minutes); 
	//Создаем к событию напоминалку
	setReminder($client, $eventId, $minutes);
}	


?>