<?php
require "db.php";
$label = 'ID';//получаем ID строки
$id = false;
if (  !empty( $_GET[ $label ] )  )//проверка наличия переданного id
{
  $id = $_GET[ $label ];//запись id в переменную $id
  $m = R::load('users', $id);
  R::trash($m);//Удаляем поле
}
header('Location: /index.php?ID=1');//автоматическое перенаправление на главную страницу
?>