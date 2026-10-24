<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta
name="viewport"
content="width=device-width, initial-scale=1.0">

<title>

	Change Password

</title>

<!-- BOOTSTRAP -->

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

<!-- ICONS -->

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<!-- GOOGLE FONT -->

<link
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
rel="stylesheet">

<link href="css/change_password.css" rel="stylesheet">

<style >

body{

	min-height:100vh;

	background:
	linear-gradient(
	rgba(0,0,0,0.65),
	rgba(0,0,0,0.65)
	),

	url("img/myimg3.jpg");

	background-size:cover;

	background-position:center;

	background-repeat:no-repeat;

	overflow-x:hidden;

	display:flex;

	align-items:center;

	justify-content:center;

	padding:30px;

}

</style>

</head>

<body>

<div class="password-box">

	<h1>

		Change Password

	</h1>

	<p>

		Update your account password securely

	</p>

	<form
	action="ChangePassword"
	method="post">

		<!-- EMAIL -->

		<div class="form-group">

			<label>

				Email Address

			</label>

			<div class="input-box">

				<i class="bi bi-envelope-fill"></i>

				<input
				type="email"
				name="email"
				placeholder="Enter your email"
				required>

			</div>

		</div>

		<!-- OLD PASSWORD -->

		<div class="form-group">

			<label>

				Old Password

			</label>

			<div class="input-box">

				<i class="bi bi-lock-fill"></i>

				<input
				type="password"
				name="old_password"
				placeholder="Enter old password"
				required>

			</div>

		</div>

		<!-- NEW PASSWORD -->

		<div class="form-group">

			<label>

				New Password

			</label>

			<div class="input-box">

				<i class="bi bi-shield-lock-fill"></i>

				<input
				type="password"
				name="new_password"
				placeholder="Enter new password"
				required>

			</div>

		</div>

		<!-- CONFIRM PASSWORD -->

		<div class="form-group">

			<label>

				Confirm New Password

			</label>

			<div class="input-box">

				<i class="bi bi-check-circle-fill"></i>

				<input
				type="password"
				name="confirm_password"
				placeholder="Confirm new password"
				required>

			</div>

		</div>

		<!-- BUTTON -->

		<button
		type="submit"
		class="change-btn">

			<i class="bi bi-shield-lock-fill"></i>

			Change Password

		</button>

	</form>

	<!-- BACK -->

	<div class="back-link">

		<a href="profiles.jsp">

			<i class="bi bi-arrow-left"></i>

			Back To Profile

		</a>

	</div>

</div>

</body>

</html>