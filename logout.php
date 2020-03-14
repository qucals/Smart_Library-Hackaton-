<?php
require "db.php";
unset($_SESSION['logged_user']);//удаление пользователя из сессии
echo "<a href='login.php'>На страницу авторизации</a><br>";
//header('Location: /');//переход на главную страницу
?>