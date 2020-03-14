<?php 
	require "db.php"; 
?>
<!DOCTYPE html>
<html lang = "ru">
<head>
     <title>Библиотека</title>
     <meta charset="UTF-8">
     <link rel="stylesheet" type="text/css" href="style.css">
     <link rel="shortcut icon" href="screens/favicon.ico" type="image/x-icon">
</head>
<body>
<div id="body">
<?php if(isset($_SESSION['logged_user'])) : //Вывод содержимого сайта если пользователь авторизован иначе вывод ссылок на авторизацию и регистрацию?>
	Вы авторизованы<br><br>
<?php
	echo "<div class='tables_list'>";
	echo "<a href='index.php?ID=1'>Таблица пользователей</a><br>";
	echo "<a href='index.php?ID=2'>Таблица в перспективе1</a><br>";
	echo "<a href='index.php?ID=3'>Таблица в перспективе2</a><br></div>";
?>

<?php
	$label = 'ID';//получение ID страницы
	if (  !empty( $_GET[ $label ] )  )//проверка на наличие
	{
  		$page_id = $_GET[ $label ];//ID страницы записывается в переменную
	}
	if($page_id==1)//если id страницы = 1
	{
    	echo "<table><tr><td>ID</td><td>Логин</td><td>email</td><td>Пароль</td><td>Телефон</td><td>Баллы</td><td>Книги</td><td colspan='2'></td></tr><tr>";
     	$rows_job = R::getAll('SELECT * FROM users');//получение всех полей из таблицы users

	foreach ($rows_job as $row)//цикл в котором за один проход записываются в переменную row данные ОДНОЙ строки в таблице по порядку
		{
			echo '<td>'.$row['uid'] .'</td>';
			echo '<td>'.$row['login'] .'</td>';
			echo '<td>'.$row['email'] .'</td>';
			echo '<td>'.$row['password'] .'</td>';
			echo '<td>'.$row['phone'] .'</td>';
			echo '<td>'.$row['points'] .'</td>';
			echo '<td>'.$row['taken_books'] .'</td>';
			$id=$row['id'];//записываем в переменную $id id номер строки, это нужно для идентификации строки, если мы будем редактировать её или удалять
			echo "<td><a href=''>Редактировать</a></td><td><a href='user_delete.php?ID=".$id."'>Удалить</a></td>";//перенаправление на страницу user_delete.php с передачей id строки
			echo '</tr>';
    	}
    	echo "</table>";
	}
?>


<div class="exit">
<a href="/logout.php">Выйти</a></div>
<?php else : ?> 
<?php header('Location: C:\Users\itcub\Desktop\ячсми\ospanel\domains\localhost\login.php');//перенаправление на страницу авторизации?>
<?php endif; ?>
</body>
</html>