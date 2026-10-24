<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="in.sp.model.User"%>
<%@ page import="java.sql.*"%>
<%@ page import="in.sp.connection.DbConnection"%>

<%
User user = (User) session.getAttribute("userData");

if (user == null) {
	response.sendRedirect("login.html");
	return;
}

// =========================
// DYNAMIC DATA
// =========================

int totalOrders = 0;
int totalCartProducts = 0;

Connection con = null;
PreparedStatement ps1 = null;
PreparedStatement ps2 = null;
ResultSet rs1 = null;
ResultSet rs2 = null;

try {

	con = DbConnection.getConnection();

	// =========================
	// TOTAL ORDERS
	// =========================

	String orderQuery =
	"SELECT COALESCE(SUM(oi.quantity),0) " +
	"FROM orders o " +
	"INNER JOIN order_items oi ON o.id = oi.order_id " +
	"WHERE o.user_email=?";

	ps1 = con.prepareStatement(orderQuery);

	ps1.setString(1, user.getEmail().trim());

	rs1 = ps1.executeQuery();

	if (rs1.next()) {

		totalOrders = rs1.getInt(1);

	}

	// =========================
	// TOTAL CART PRODUCTS
	// =========================

	String cartQuery =
	"SELECT COALESCE(SUM(quantity),0) " +
	"FROM cart " +
	"WHERE user_email=?";

	ps2 = con.prepareStatement(cartQuery);

	ps2.setString(1, user.getEmail().trim());

	rs2 = ps2.executeQuery();

	if (rs2.next()) {

		totalCartProducts = rs2.getInt(1);

	}

} catch (Exception e) {

	e.printStackTrace();

} finally {

	try {

		if (rs1 != null)
			rs1.close();

		if (rs2 != null)
			rs2.close();

		if (ps1 != null)
			ps1.close();

		if (ps2 != null)
			ps2.close();

		if (con != null)
			con.close();

	} catch (Exception e) {

		e.printStackTrace();

	}

}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Profile</title>

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

<!-- CSS -->

<link rel="stylesheet" href="css/profile.css">

</head>

<body>

	<!-- NAVBAR -->

	<nav class="navbar navbar-expand-lg navbar-dark">

		<div class="container-fluid">

			<a class="navbar-brand" href="profiles.jsp">
				TechLaptop
			</a>

			<button class="navbar-toggler"
				data-bs-toggle="collapse"
				data-bs-target="#menu">

				<span class="navbar-toggler-icon"></span>

			</button>

			<div class="collapse navbar-collapse"
				id="menu">

				<ul class="navbar-nav ms-auto">

					<li class="nav-item">

						<a class="nav-link active"
							href="home.jsp">

							Home

						</a>

					</li>

					<li class="nav-item">

						<a class="nav-link"
							href="laptops.jsp">

							Laptops

						</a>

					</li>

					<li class="nav-item">

						<a class="nav-link"
							href="about.jsp">

							About

						</a>

					</li>

					<li class="nav-item">

						<a class="nav-link"
							href="orders.jsp">

							Orders

						</a>

					</li>

					<li class="nav-item">

						<a class="nav-link"
							href="cart.jsp">

							Cart

						</a>

					</li>

				</ul>

				<ul class="navbar-nav ms-4 align-items-center">

					<li class="nav-item">

						<a href="Logout"
							class="logout-btn">

							<i class="bi bi-box-arrow-right"></i>

							Logout

						</a>

					</li>

				</ul>

			</div>

		</div>

	</nav>

	<!-- PROFILE HERO -->

	<section class="profile-hero">

		<div class="container">

			<div class="profile-card">

				<div class="row align-items-center">

					<!-- LEFT -->

					<div class="col-12 col-lg-4 text-center">

						<div class="profile-image-box">

							<img
							src="img/<%=user.getImage()%>"
							class="profile-img">

							<div class="online-status"></div>

						</div>

						<h2 class="profile-name">

							<%=user.getName()%>

						</h2>

					</div>

					<!-- RIGHT -->

					<div class="col-12 col-lg-8">

						<div class="profile-info">

							<div class="row g-4">

								<div class="col-12 col-md-6">

									<div class="info-box">

										<h5>

											<i class="bi bi-person-fill"></i>

											Full Name

										</h5>

										<p>

											<%=user.getName()%>

										</p>

									</div>

								</div>

								<div class="col-12 col-md-6">

									<div class="info-box">

										<h5>

											<i class="bi bi-envelope-fill"></i>

											Email

										</h5>

										<p>

											<%=user.getEmail()%>

										</p>

									</div>

								</div>

								<div class="col-12 col-md-6">

									<div class="info-box">

										<h5>

											<i class="bi bi-telephone-fill"></i>

											Phone

										</h5>

										<p>

											<%=user.getPhone()%>

										</p>

									</div>

								</div>

								<div class="col-12 col-md-6">

									<div class="info-box">

										<h5>

											<i class="bi bi-geo-alt-fill"></i>

											Account Type

										</h5>

										<p>

											<%=user.getAccountType()%>

										</p>

									</div>

								</div>

							</div>

							<div class="profile-buttons">

								<button class="edit-btn">

									<i class="bi bi-pencil-square"></i>

									<a href="profile_edit.jsp"
										style="color:white;text-decoration:none;">

										Edit Profile

									</a>

								</button>

								<button class="password-btn">

									<i class="bi bi-lock-fill"></i>

									<a href="change_password.jsp"
										style="text-decoration:none;color:white;">

										Change Password

									</a>

								</button>

							</div>

						</div>

					</div>

				</div>

			</div>

		</div>

	</section>

	<!-- STATS -->

	<section class="container pb-5">

		<div class="row g-4">

			<!-- TOTAL ORDERS -->

			<div class="col-12 col-md-6 col-xl-3">

				<div class="stats-card">

					<i class="bi bi-bag-check-fill"></i>

					<h2>

						<%=totalOrders%>

					</h2>

					<p>Total Orders</p>

				</div>

			</div>

			<!-- CART PRODUCTS -->

			<div class="col-12 col-md-6 col-xl-3">

				<div class="stats-card">

					<i class="bi bi-cart-check-fill"></i>

					<h2>

						<%=totalCartProducts%>

					</h2>

					<p>Cart Products</p>

				</div>

			</div>

			<!-- RATINGS -->

			<div class="col-12 col-md-6 col-xl-3">

				<div class="stats-card">

					<i class="bi bi-star-fill"></i>

					<h2>4.9</h2>

					<p>Ratings</p>

				</div>

			</div>

			<!-- MEMBERSHIP -->

			<div class="col-12 col-md-6 col-xl-3">

				<div class="stats-card">

					<i class="bi bi-award-fill"></i>

					<h2>Gold</h2>

					<p>Membership</p>

				</div>

			</div>

		</div>

	</section>

	<!-- PERSONAL INFORMATION -->

	<section class="container pb-5">

		<div class="personal-box">

			<h2 class="section-title d-inline">

				Personal Information

			</h2>

			<div class="row g-4">

				<div class="col-12 col-md-6 col-xl-4">

					<div class="personal-card">

						<i class="bi bi-person-fill"></i>

						<h5>Gender</h5>

						<p>

							<%=user.getGender()%>

						</p>

					</div>

				</div>

				<div class="col-12 col-md-6 col-xl-4">

					<div class="personal-card">

						<i class="bi bi-calendar-event-fill"></i>

						<h5>Date Of Birth</h5>

						<p>

							<%=user.getDob()%>

						</p>

					</div>

				</div>

				<div class="col-12 col-md-6 col-xl-4">

					<div class="personal-card">

						<i class="bi bi-globe-central-south-asia"></i>

						<h5>Country</h5>

						<p>

							<%=user.getCountry()%>

						</p>

					</div>

				</div>

				<div class="col-12 col-md-6 col-xl-4">

					<div class="personal-card">

						<i class="bi bi-translate"></i>

						<h5>Language</h5>

						<p>

							<%=user.getLanguage()%>

						</p>

					</div>

				</div>

				<div class="col-12 col-md-6 col-xl-4">

					<div class="personal-card">

						<i class="bi bi-buildings-fill"></i>

						<h5>City</h5>

						<p>

							<%=user.getCity()%>

						</p>

					</div>

				</div>

				<div class="col-12 col-md-6 col-xl-4">

					<div class="personal-card">

						<i class="bi bi-mailbox2"></i>

						<h5>Pincode</h5>

						<p>

							<%=user.getPincode()%>

						</p>

					</div>

				</div>

				<div class="col-12">

					<div class="address-card">

						<div class="address-top">

							<i class="bi bi-geo-alt-fill"></i>

							<h4>Full Address</h4>

						</div>

						<p>

							<%=user.getAddress()%>

						</p>

					</div>

				</div>

			</div>

		</div>

	</section>

	<!-- FOOTER -->

	<footer class="footer">

		<div class="container">

			<div class="row">

				<div class="col-12 col-lg-4">

					<h2 class="footer-logo">

						TechLaptop

					</h2>

					<p>

						Premium ecommerce platform for gaming and business laptops.

					</p>

				</div>

				<div class="col-6 col-lg-2">

					<h4>Links</h4>

					<ul class="footer-links">

						<li><a href="home.jsp">Home</a></li>

						<li><a href="laptops.jsp">Laptops</a></li>

						<li><a href="orders.jsp">Orders</a></li>

					</ul>

				</div>

				<div class="col-6 col-lg-3">

					<h4>Categories</h4>

					<ul class="footer-links">

						<li><a href="#">Gaming</a></li>

						<li><a href="#">Business</a></li>

						<li><a href="#">Student</a></li>

					</ul>

				</div>

				<div class="col-12 col-lg-3">

					<h4>Contact</h4>

					<p>

						<i class="bi bi-envelope"></i>

						support@techlaptop.com

					</p>

					<p>

						<i class="bi bi-telephone"></i>

						+91 9325342724

					</p>

				</div>

			</div>

		</div>

	</footer>

	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
	</script>

</body>

</html>