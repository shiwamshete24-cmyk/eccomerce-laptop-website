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

Connection conn = DbConnection.getConnection();
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Manage Laptops</title>

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

<link href="css/admin_laptops.css" rel="stylesheet">

</head>

<body>

	<!-- SIDEBAR -->

	<div class="sidebar">

		<h1 class="logo">TechLaptop</h1>

		<ul class="sidebar-menu">

			<li><a href="admin_dashboard.jsp"> <i
					class="bi bi-grid-fill"></i> Dashboard

			</a></li>

			<li><a href="admin_profile.jsp"> <i
					class="bi bi-person-circle"></i> Profile

			</a></li>

			<li><a href="admin_users.jsp"> <i class="bi bi-people-fill"></i>

					Users

			</a></li>

			<li><a href="admin_laptops.jsp" class="active"> <i
					class="bi bi-laptop"></i> Laptops

			</a></li>

			<li><a href="admin_orders.jsp"> <i
					class="bi bi-bag-check-fill"></i> Orders

			</a></li>

			<li><a href="Logout"> <i class="bi bi-box-arrow-right"></i>

					Logout

			</a></li>

		</ul>

	</div>

	<!-- MAIN -->

	<div class="main">

		<!-- TOPBAR -->

		<div class="topbar">

			<h2>Manage Laptops</h2>

			<a href="add_laptop.jsp" class="add-btn"> <i
				class="bi bi-plus-circle-fill"></i> Add Laptop

			</a>

		</div>

		<!-- BRAND FILTER -->

		<div class="brand-navbar">

			<a href="admin_laptops.jsp"> All </a> <a
				href="admin_laptops.jsp?brand=Dell"> Dell </a> <a
				href="admin_laptops.jsp?brand=HP"> HP </a> <a
				href="admin_laptops.jsp?brand=Asus"> Asus </a> <a
				href="admin_laptops.jsp?brand=Lenovo"> Lenovo </a> <a
				href="admin_laptops.jsp?brand=Acer"> Acer </a> <a
				href="admin_laptops.jsp?brand=MSI"> MSI </a> <a
				href="admin_laptops.jsp?brand=Apple"> Apple </a> <a
				href="admin_laptops.jsp?brand=Samsung"> Samsung </a> <a
				href="admin_laptops.jsp?brand=Alienware"> Alienware </a> <a
				href="admin_laptops.jsp?brand=Razer"> Razer </a>

		</div>

		<!-- TABLE -->

		<div class="table-box">

			<div class="table-header">

				<h3>All Laptops</h3>

				<form method="get" class="filter-form">

					<div class="search-box">

						<i class="bi bi-search"></i> <input type="text" name="search"
							placeholder="Search name, brand, category...">

					</div>

					<select name="status" class="status-filter">

						<option value="">All Status</option>

						<option value="available">Available</option>

						<option value="out">Out Of Stock</option>

					</select>

					<button type="submit" class="filter-btn">

						<i class="bi bi-funnel-fill"></i> Filter

					</button>

				</form>

			</div>

			<div class="table-responsive">

				<table class="table">

					<thead>

						<tr>

							<th>ID</th>

							<th>Laptop</th>

							<th>Brand</th>

							<th>Category</th>

							<th>Price</th>

							<th>Stock</th>

							<th>Status</th>

							<th>Action</th>

						</tr>

					</thead>

					<tbody>

						<%
						String search = request.getParameter("search");

						String brand = request.getParameter("brand");

						String status = request.getParameter("status");

						String sql = "select * from laptops where 1=1";

						if (search != null && !search.trim().equals("")) {

							sql += " and (name like ? or brand like ? or category like ?)";

						}

						if (brand != null && !brand.equals("") && !brand.equals("All")) {

							sql += " and brand=?";

						}

						if (status != null && status.equals("available")) {

							sql += " and stock > 0";

						}

						if (status != null && status.equals("out")) {

							sql += " and stock <= 0";

						}

						sql += " order by id desc";

						PreparedStatement ps = conn.prepareStatement(sql);

						int paramIndex = 1;

						if (search != null && !search.trim().equals("")) {

							ps.setString(paramIndex++, "%" + search + "%");

							ps.setString(paramIndex++, "%" + search + "%");

							ps.setString(paramIndex++, "%" + search + "%");

						}

						if (brand != null && !brand.equals("") && !brand.equals("All")) {

							ps.setString(paramIndex++, brand);

						}

						ResultSet rs = ps.executeQuery();

						while (rs.next()) {

							int stock = rs.getInt("stock");
						%>

						<tr>

							<td>#LAP<%=rs.getInt("id")%>

							</td>

							<td>

								<div class="laptop-box">

									<img src="images/laptops/<%=rs.getString("image1")%>"
										class="laptop-img">

									<div>

										<b> <%=rs.getString("name")%>

										</b>

									</div>

								</div>

							</td>

							<td><%=rs.getString("brand")%></td>

							<td><%=rs.getString("category")%></td>

							<td>₹ <%=rs.getDouble("price")%>

							</td>

							<td><%=stock%></td>

							<td><span
								class="status
						<%=stock > 0 ? "available" : "out"%>">

									<%=stock > 0 ? "Available" : "Out Of Stock"%>

							</span></td>

							<td>

								<div class="action-group">

									<a href="edit_laptop.jsp?id=<%=rs.getInt("id")%>"
										class="action-btn edit-btn"> <i class="bi bi-pencil-fill"></i>

										Edit

									</a> <a href="DeleteLaptop?id=<%=rs.getInt("id")%>"
										class="action-btn delete-btn"
										onclick="return confirm('Are you sure you want to delete this laptop?')">

										<i class="bi bi-trash-fill"></i> Delete

									</a>

								</div>

							</td>

						</tr>

						<%
						}
						%>

					</tbody>

				</table>

			</div>

		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
		
	</script>

</body>

</html>