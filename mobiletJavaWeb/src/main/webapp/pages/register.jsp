<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fa" dir="rtl">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ثبت نام</title>

<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/bootstrap.rtl.min.css">
<link rel="stylesheet" href="assets/css/output.css" />
<link rel="stylesheet" href="assets/css/font.css">
<style>
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}
</style>
</head>

<body class="bg-gray-50">
	<div
		class="flex justify-center items-center text-right h-screen w-96 mx-auto">
		<div class="shadow-xl rounded-2xl p-8 bg-white">
			<%
			if (request.getParameter("error") != null) {
				if (request.getParameter("error").equals("0")) {
			%>
			<div class="text-center text-lg bg-yellow-100 opacity-50 mb-2">
				نام کابری یافت نشد ابتدا ثبت‌نام کنید
			</div>
			<%
			}
			%>
			<%
			if (request.getParameter("error").equals("1")) {
			%>
			<div class="text-center text-lg bg-red-100 opacity-30 mb-2">شماره تلفن وارد شده قبلا ثبت شده است</div>
			<%
			}
			}
			%>
			<form action="CheckRegister" method="post">
				<div class="mb-2">
					<a href="./index.jsp"> <img src="assets/img/Artboard 1@2x.png"
						alt="" class="w-44 mx-auto">
					</a>
				</div>
				<div class="opacity-80 text-lg mb-5">ثبت نام</div>
				<div class="text-xs opacity-70 mb-2">نام:</div>
				<div class="mb-2">
					<input name="name"
						class="w-full drop-shadow-lg outline-none rounded-2xl py-2 text-center"
						type="text">
				</div>
				<div class="text-xs opacity-70 mb-2">نام خانوادگی:</div>
				<div class="mb-2">
					<input name="family"
						class="w-full drop-shadow-lg outline-none rounded-2xl py-2 text-center"
						type="text">
				</div>
				<div class="text-xs opacity-70 mb-2">شماره همراه خود را وارد
					کنید:</div>
				<div class="mb-2">
					<input name="phoneNumber"
						class="w-full drop-shadow-lg outline-none rounded-2xl py-2 text-center"
						type="number">
				</div>
				<div class="text-xs opacity-70 mb-2">رمز عبور:</div>
				<div class="mb-2">
					<input name="password"
						class="w-full drop-shadow-lg outline-none rounded-2xl py-2 text-center"
						type="password">
				</div>
				<div class="text-center mt-5 mb-3">
					<button
						class="bg-blue-500 hover:bg-blue-600 transition text-white opacity-80 rounded-2xl w-full py-2"
						type="submit" name="submit" value="submit">ثبت‌نام</button>
				</div>
				<div class="text-xs opacity-80">
					ثبت نام یا ورود شما به منظور پذیرش <a href="#"
						class="text-blue-500">قوانین و مقررات</a> موبلایت میباشد.
				</div>
			</form>
		</div>
	</div>
	<script src="assets/js/jQuery.js"></script>
	<script src="assets/js/owl.carousel.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/index.js"></script>
</body>

</html>