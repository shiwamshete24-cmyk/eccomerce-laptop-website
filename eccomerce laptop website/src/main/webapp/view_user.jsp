<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="in.sp.connection.DbConnection"%>
<%@ page import="in.sp.model.User"%>

<%
User admin = (User) session.getAttribute("admin_details");

if (admin == null) {

	response.sendRedirect("admin_login.html");

}

/* USER ID */

int userId = Integer.parseInt(request.getParameter("id"));

Connection conn = DbConnection.getConnection();

/* USER DETAILS */

PreparedStatement ps = conn.prepareStatement("select * from users where id=?");

ps.setInt(1, userId);

ResultSet rs = ps.executeQuery();

String name = "";
String email = "";

if (rs.next()) {

	name = rs.getString("name");

	email = rs.getString("email");

}

/* TOTAL ORDERS */

PreparedStatement totalOrderPs = conn.prepareStatement("select count(*) from orders where user_email=?");

totalOrderPs.setString(1, email);

ResultSet totalOrderRs = totalOrderPs.executeQuery();

int totalOrders = 0;

if (totalOrderRs.next()) {

	totalOrders = totalOrderRs.getInt(1);

}

/* PENDING ORDERS */

PreparedStatement pendingPs = conn
		.prepareStatement("select count(*) from orders where user_email=? and order_status='pending'");

pendingPs.setString(1, email);

ResultSet pendingRs = pendingPs.executeQuery();

int pendingOrders = 0;

if (pendingRs.next()) {

	pendingOrders = pendingRs.getInt(1);

}

/* DELIVERED ORDERS */

PreparedStatement deliveredPs = conn
		.prepareStatement("select count(*) from orders where user_email=? and order_status='delivered'");

deliveredPs.setString(1, email);

ResultSet deliveredRs = deliveredPs.executeQuery();

int deliveredOrders = 0;

if (deliveredRs.next()) {

	deliveredOrders = deliveredRs.getInt(1);

}

/* CART ITEMS */

PreparedStatement cartPs = conn.prepareStatement("select count(*) from cart where user_email=?");

cartPs.setString(1, email);

ResultSet cartRs = cartPs.executeQuery();

int cartCount = 0;

if (cartRs.next()) {

	cartCount = cartRs.getInt(1);

}

/* TOTAL SPENDING */

PreparedStatement spendPs = conn.prepareStatement("select sum(total_amount) from orders where user_email=?");

spendPs.setString(1, email);

ResultSet spendRs = spendPs.executeQuery();

double totalSpending = 0;

if (spendRs.next()) {

	totalSpending = spendRs.getDouble(1);

}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Details</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<link href="css/view_user.css" rel="stylesheet">

</head>

<body>

	<!-- SIDEBAR -->

	<div class="sidebar">

		<h1 class="logo">TechLaptop</h1>

		<ul class="sidebar-menu">

			<li><a href="admin_dashboard.jsp"> <i
					class="bi bi-grid-fill"></i> Dashboard

			</a></li>

			<li><a href="admin_users.jsp"> <i class="bi bi-people-fill"></i>

					Users

			</a></li>

			<li><a href="admin_orders.jsp"> <i
					class="bi bi-bag-check-fill"></i> Orders

			</a></li>

		</ul>

	</div>

	<!-- MAIN -->

	<div class="main">

		<!-- TOPBAR -->

		<div class="topbar">

			<h2>User Analytics</h2>

		</div>

		<!-- PROFILE -->

		<div class="profile-box">

			<div class="profile-header">

				<div class="profile-image">

					<%=name.substring(0, 1).toUpperCase()%>

				</div>

				<div class="profile-info">

					<h1>

						<%=name%>

					</h1>

					<p>

						<%=email%>

					</p>

					<p>TechLaptop Customer</p>

				</div>

			</div>

		</div>

		<!-- ANALYTICS -->

		<div class="row g-4">

			<div class="col-md-6 col-xl-3">

				<div class="analytics-card">

					<div class="card-icon bg1">

						<i class="bi bi-bag-fill"></i>

					</div>

					<h5>Total Orders</h5>

					<h1>

						<%=totalOrders%>

					</h1>

				</div>

			</div>

			<div class="col-md-6 col-xl-3">

				<div class="analytics-card">

					<div class="card-icon bg2">

						<i class="bi bi-clock-fill"></i>

					</div>

					<h5>Pending Orders</h5>

					<h1>

						<%=pendingOrders%>

					</h1>

				</div>

			</div>

			<div class="col-md-6 col-xl-3">

				<div class="analytics-card">

					<div class="card-icon bg3">

						<i class="bi bi-check-circle-fill"></i>

					</div>

					<h5>Delivered Orders</h5>

					<h1>

						<%=deliveredOrders%>

					</h1>

				</div>

			</div>

			<div class="col-md-6 col-xl-3">

				<div class="analytics-card">

					<div class="card-icon bg4">

						<i class="bi bi-cart-fill"></i>

					</div>

					<h5>Cart Items</h5>

					<h1>

						<%=cartCount%>

					</h1>

				</div>

			</div>

		</div>

		<!-- TOTAL SPENDING -->

		<div class="table-box">

			<h2 class="table-title">Total Spending</h2>

			<h1 style="font-size: 50px; font-weight: 800; color: #10b981;">

				₹
				<%=totalSpending%>

			</h1>

		</div>

		<!-- RECENT ORDERS -->

		<div class="table-box">

			<h2 class="table-title">Recent Orders</h2>

			<div class="table-responsive">

				<table class="table">

					<thead>

						<tr>

							<th>Order ID</th>

							<th>Status</th>

							<th>Payment</th>

							<th>Total</th>

						</tr>

					</thead>

					<tbody>

						<%
						PreparedStatement orderPs = conn.prepareStatement("select * from orders where user_email=? order by id desc");

						orderPs.setString(1, email);

						ResultSet orderRs = orderPs.executeQuery();

						while (orderRs.next()) {
						%>

						<tr>

							<td>#ORD<%=orderRs.getInt("id")%>

							</td>

							<td><span
								class="status <%=orderRs.getString("order_status").equals("delivered") ? "delivered" : "pending"%>">

									<%=orderRs.getString("order_status")%>

							</span></td>

							<td><%=orderRs.getString("payment_method")%></td>

							<td>₹ <%=orderRs.getDouble("total_amount")%>

							</td>

						</tr>

						<%
						}
						%>

					</tbody>

				</table>

			</div>

		</div>

		<!-- BUTTONS -->

		<div class="action-buttons">

			<a href="admin_users.jsp" class="action-btn btn1"> <i
				class="bi bi-arrow-left"></i> Back

			</a> <a href="DeleteUser?id=<%=rs.getInt("id")%>"
				class="action-btn delete-btn"> <i class="bi bi-trash-fill"></i>

				Delete

			</a>

		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
		
	</script>

</body>

</html>