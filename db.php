<?php
require "lib/rb.php"; // подключаем библиотеку redbeanphp

R::setup( 'mysql:host=localhost;dbname=local_users','mysql', 'mysql' );// вход в базу 'users' по логину 'root' и паролю '1'
//array($data['login']='login');
//$rows_job = R::findOne('users','login = ?', array($data['login']));
//echo $rows_job;
session_start();//начало сессии


