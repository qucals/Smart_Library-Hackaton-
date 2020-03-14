<?php 
	require "db.php"; 
?>
<!DOCTYPE html>
<html style="background:linear-gradient(120deg, #FFD692, #E16363); height:100%;" lang = "ru">
<head>
     <title>Библиотека</title>
     <meta charset="UTF-8">
     <link rel="stylesheet" type="text/css" href="style.css">
     <link rel="shortcut icon" href="screens/favicon.ico" type="image/x-icon">
</head>
<body>
<div class="img"></div>
<?php
	$data=$_POST;
	if(isset($data['do_login']))//проверка нажатия кнопки Войти
	{
		$errors=array();
		$user=R::findOne('admin',"login = ?", array($data['login']));
		$pass=R::findOne('admin',"password = ?", array($data['password']));//поиск логина в базе
		if($user)
		{
			if($data['password']==$pass->password)// если логин существует идет проверка пароля
			{
				$_SESSION['logged_user'] = $user;//если логин и пароль существуют в базе, то сессия закрепляется за пользователем по логину
				echo '<a href="index.php">На главную страницу</a>';
				//header("Location: http://localhost/index.php");//переход на страницу index.php
			}else
			{
				$errors[] = 'Пароль введен неверно';//запись ошибки в массив
			}
		}else
		{
			$errors[] = 'Пользователь не найден!';
	}}
?>


	<form action="login.php" method="POST" class="form1">
	<center>Авторизация</center><hr><br>
	Логин:<br>
	<input type="text" name="login" value="<?php echo @$data['login'];?>"><br><br>
	Пароль: <br>
	<input type="password" name="password"><br><br>
	<button type="submit" name="do_login">Войти</button><br><br>
	<?php
	if(! empty($errors))
	{
		echo '<div style="color: red;">'.array_shift($errors).'</div>';//если массив ошибок не пуст, то ввыводится записанная в массив ошибка
	}?>
	 <button><a href="register.php">У меня нет аккаунта</a></button>
	
	</form>
	
	
</body>
</html>