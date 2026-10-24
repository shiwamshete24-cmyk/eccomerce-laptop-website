<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="in.sp.model.User"%>
<%@ page import="java.sql.*"%>
<%@ page import="in.sp.connection.DbConnection"%>

<%
User user = (User) session.getAttribute("userData");

if (user == null) {

	response.sendRedirect("login.html");

}

Connection conn = DbConnection.getConnection();

String sql = "select cart.quantity, laptops.* " + "from cart " + "join laptops on cart.laptop_id=laptops.id "
		+ "where cart.user_email=? " + "and cart.status='active'";

PreparedStatement ps = conn.prepareStatement(sql);

ps.setString(1, user.getEmail());

ResultSet rs = ps.executeQuery();

double subtotal = 0;

while (rs.next()) {

	subtotal += rs.getInt("quantity") * rs.getDouble("price");

}

/* =========================
   PRICE CALCULATION
========================= */

double shipping = 499;

double discount = 1500;

double finalTotal = subtotal + shipping - discount;
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Checkout</title>

<!-- BOOTSTRAP -->

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- ICONS -->

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<!-- GOOGLE FONT -->

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: #edf1f5;
	color: #111827;
}

/* =========================
   NAVBAR
========================= */
.navbar {
	background: white;
	padding: 18px 35px;
	box-shadow: 0 2px 20px rgba(0, 0, 0, 0.05);
}

.navbar-brand {
	font-size: 32px;
	font-weight: 800;
	color: #0077ff !important;
}

/* =========================
   PAGE TITLE
========================= */
.page-title {
	text-align: center;
	padding: 50px 0 30px;
}

.page-title h1 {
	font-size: 55px;
	font-weight: 800;
}

.page-title span {
	color: #0077ff;
}

.page-title p {
	color: #6b7280;
	margin-top: 12px;
}

/* =========================
   FORM BOX
========================= */
.checkout-box {
	background: white;
	padding: 35px;
	border-radius: 24px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.05);
}

.checkout-box h2 {
	font-size: 32px;
	font-weight: 800;
	margin-bottom: 30px;
}

.form-label {
	font-weight: 600;
	margin-bottom: 10px;
}

.form-control, .form-select {
	height: 55px;
	border-radius: 14px;
	border: 1px solid #d1d5db;
}

textarea.form-control {
	height: auto;
}

.form-control:focus, .form-select:focus {
	box-shadow: none;
	border-color: #0077ff;
}

/* =========================
   SUMMARY
========================= */
.summary-box {
	background: white;
	padding: 30px;
	border-radius: 24px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.05);
	position: sticky;
	top: 20px;
}

.summary-box h2 {
	font-size: 30px;
	font-weight: 800;
	margin-bottom: 25px;
}

.product-item {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 1px solid #eee;
}

.product-item img {
	width: 80px;
	height: 80px;
	object-fit: contain;
	background: #fff;
	border-radius: 14px;
	border: 1px solid #eee;
	padding: 5px;
}

.product-item h5 {
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 6px;
}

.product-item p {
	font-size: 14px;
	color: #6b7280;
	margin: 0;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 18px;
	font-size: 17px;
}

.discount {
	color: #00b67a;
	font-weight: 700;
}

.total {
	font-size: 24px;
	font-weight: 800;
}

.checkout-btn {
	width: 100%;
	background: #ff9f00;
	color: white;
	border: none;
	padding: 16px;
	border-radius: 14px;
	font-size: 18px;
	font-weight: 700;
	margin-top: 25px;
	transition: 0.3s;
}

.checkout-btn:hover {
	background: #f59e0b;
	transform: translateY(-3px);
}

/* =========================
   MOBILE
========================= */
@media ( max-width :991px) {
	.summary-box {
		position: relative;
		top: 0;
		margin-top: 30px;
	}
}

@media ( max-width :576px) {
	.page-title h1 {
		font-size: 40px;
	}
	.checkout-box {
		padding: 25px;
	}
}
</style>

</head>

<body>

	<!-- NAVBAR -->

	<nav class="navbar navbar-expand-lg navbar-light">

		<div class="container-fluid">

			<a class="navbar-brand" href="home.jsp"> TechLaptop </a>

		</div>

	</nav>

	<!-- TITLE -->

	<section class="page-title">

		<div class="container">

			<h1>

				Checkout <span>Page</span>

			</h1>

			<p>Complete your order with delivery details.</p>

		</div>

	</section>

	<!-- MAIN -->

	<section class="container pb-5">

		<div class="row g-4">

			<!-- LEFT SIDE -->

			<div class="col-12 col-lg-7">

				<div class="checkout-box">

					<h2>Delivery Details</h2>

					<form action="PlaceOrder" method="post">

						<!-- NAME -->

						<div class="mb-4">

							<label class="form-label"> Full Name </label> <input type="text"
								name="fullName" class="form-control" required>

						</div>

						<!-- PHONE -->

						<div class="mb-4">

							<label class="form-label"> Phone Number </label> <input
								type="text" name="phone" class="form-control" required>

						</div>

						<!-- ADDRESS -->

						<div class="mb-4">

							<label class="form-label"> Address </label>

							<textarea name="address" class="form-control" rows="4" required></textarea>

						</div>

						<!-- CITY -->

						<div class="mb-4">

							<label class="form-label"> City </label> <input type="text"
								name="city" class="form-control" required>

						</div>

						<!-- STATE -->

						<div class="mb-4">

							<label class="form-label"> State </label> <input type="text"
								name="state" class="form-control" required>

						</div>

						<!-- PINCODE -->

						<div class="mb-4">

							<label class="form-label"> Pincode </label> <input type="text"
								name="pincode" class="form-control" required>

						</div>

						<!-- PAYMENT -->

						<div class="mb-4">

							<label class="form-label"> Payment Method </label> <select
								name="paymentMethod" class="form-select" required>

								<option value="">Select Payment Method</option>

								<option value="Cash On Delivery">Cash On Delivery</option>

								<option value="UPI">UPI</option>

								<option value="Credit Card">Credit Card</option>

								<option value="Debit Card">Debit Card</option>

							</select>

						</div>

						<!-- BUTTON -->

						<button type="submit" class="checkout-btn">Place Order</button>

					</form>

				</div>

			</div>

			<!-- RIGHT SIDE -->

			<div class="col-12 col-lg-5">

				<div class="summary-box">

					<h2>Order Summary</h2>

					<%
					PreparedStatement summaryPs = conn.prepareStatement(sql);

					summaryPs.setString(1, user.getEmail());

					ResultSet summaryRs = summaryPs.executeQuery();

					while (summaryRs.next()) {
					%>

					<div class="product-item">

						<img
							src="<%=request.getContextPath()%>/images/laptops/<%=summaryRs.getString("image1")%>">

						<div>

							<h5>

								<%=summaryRs.getString("name")%>

							</h5>

							<p>

								Qty :
								<%=summaryRs.getInt("quantity")%>

							</p>

							<p>

								₹<%=summaryRs.getDouble("price")%>

							</p>

						</div>

					</div>

					<%
					}
					%>

					<hr>

					<div class="summary-item">

						<span> Subtotal </span> <span> ₹<%=subtotal%>

						</span>

					</div>

					<div class="summary-item">

						<span> Shipping </span> <span> ₹<%=shipping%>

						</span>

					</div>

					<div class="summary-item">

						<span> Discount </span> <span class="discount"> - ₹<%=discount%>

						</span>

					</div>

					<hr>

					<div class="summary-item total">

						<span> Total </span> <span> ₹<%=finalTotal%>

						</span>

					</div>

				</div>

			</div>

		</div>

	</section>

	<!-- BOOTSTRAP -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
		
	</script>

</body>

</html>