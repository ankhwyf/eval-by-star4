<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome!</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/modals.css">
<link rel="stylesheet" href="css/login.css">
<!--<link rel="stylesheet" href="css/cursor.css">-->
<script type="text/javascript" src="js/tools/jquery-1.12.2.min.js"></script>
<script type="text/javascript" src="js/tools/bootstrap.js"></script>
<script type="text/javascript" src="js/modal.js"></script>
<script type="text/javascript" src="js/login.js"></script>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#" id="brand-a"> <img alt="Brand"
					src="img/logo.png">
				</a> <span class="title">教师考核平台</span>
			</div>
		</div>
	</nav>
	<div class="main">

		<form class="login" action="login" method="post">
			<c:if test="${loginError}">
				<div class="login-panel__msg input-msg">
					<img src="img/error.png" alt=""> <span>登录名或登录密码不正确</span>
				</div>
			</c:if>
			<div class="form-group">
				<label for="user" class="control-label">登录名:</label> <input
					type="text" class="input-user form-control"
					placeholder="邮箱/工号" name="login_name">
			</div>
			<div class="form-group">
				<label for="user" class="control-label">登录密码:</label> <a
					class="login-panel__forget" href="#">忘记登录密码？</a> <input
					type="password" class="input-pass form-control"
					placeholder="登录密码" name="login_pwd">
			</div>

			<div class="form-group">
				<input type="submit"
					class="login-panel__submit input-submit  btn btn-primary"
					value="登录">
			</div>
		</form>

	</div>
	<div class="footer">
		© 2018 <img src="img/heart.png" alt=""> 杭州师范大学
	</div>

	<script>
		$('.login-panel__submit').click(function() {
			modals.loadingShow();
		});
	</script>
</body>

</html>
