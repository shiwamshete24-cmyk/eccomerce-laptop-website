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
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Manage Users</title>

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

<link href="css/admin_users.css" rel="stylesheet">

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

			<li><a href="admin_users.jsp" class="active"> <i
					class="bi bi-people-fill"></i> Users

			</a></li>

			<li><a href="admin_laptops.jsp"> <i class="bi bi-laptop"></i>

					Laptops

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

			<h2>Manage Users</h2>

		</div>

		<!-- TABLE BOX -->

		<div class="table-box">

			<div class="table-header">

				<h3>All Registered Users</h3>

				<!-- SEARCH FORM -->

				<form method="get">

					<div class="search-box">

						<i class="bi bi-search"></i> <input type="text" name="search"
							placeholder="Search users..."
							value="<%=request.getParameter("search") == null ? "" : request.getParameter("search")%>">

					</div>

				</form>

			</div>

			<div class="table-responsive">

				<table class="table">

					<thead>

						<tr>

							<th>ID</th>

							<th>User</th>

							<th>Email</th>

							<th>Status</th>

							<th>Action</th>

						</tr>

					</thead>

					<tbody>

						<%
						Connection conn = DbConnection.getConnection();

						/* SEARCH VALUE */

						String search = request.getParameter("search");

						PreparedStatement ps;

						/* SEARCH QUERY */

						if (search != null && !search.trim().equals("")) {

							ps = conn.prepareStatement(

							"select * from users where name like ? or email like ?"

							);

							ps.setString(1, "%" + search + "%");

							ps.setString(2, "%" + search + "%");

						} else {

							ps = conn.prepareStatement("select * from users");

						}

						ResultSet rs = ps.executeQuery();

						while (rs.next()) {
						%>

						<tr>

							<td>#USR<%=rs.getInt("id")%>

							</td>

							<td>

								<div class="user-box">

									<div class="user-img">

										<%=rs.getString("name").substring(0, 1).toUpperCase()%>

									</div>

									<div>

										<b> <%=rs.getString("name")%>

										</b>

									</div>

								</div>

							</td>

							<td><%=rs.getString("email")%></td>

							<td><span class="status active-status"> Active </span></td>

							<td><a href="view_user.jsp?id=<%=rs.getInt("id")%>"
								class="action-btn view-btn"> <i class="bi bi-eye-fill"></i>

									Details

							</a> <a href="DeleteUser?id=<%=rs.getInt("id")%>"
								class="action-btn delete-btn"> <i class="bi bi-trash-fill"></i>

									Delete

							</a></td>

						</tr>

						<%
						}
						%>

					</tbody>

				</table>

			</div>

		</div>

	</div>

	<!-- BOOTSTRAP -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
		
	</script>

</body>

</html>