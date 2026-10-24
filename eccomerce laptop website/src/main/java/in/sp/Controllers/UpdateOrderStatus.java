package in.sp.Controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import in.sp.connection.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateOrderStatus")

public class UpdateOrderStatus extends HttpServlet{

	@Override
	protected void doPost(
	HttpServletRequest request,
	HttpServletResponse response)

	throws ServletException, IOException{

		try{

			/* GET DATA */

			int orderId =
			Integer.parseInt(
			request.getParameter("orderId"));

			String status =
			request.getParameter("status");

			/* DATABASE CONNECTION */

			Connection conn =
			DbConnection.getConnection();

			/* UPDATE QUERY */

			PreparedStatement ps =
			conn.prepareStatement(

			"update orders set order_status=? where id=?"

			);

			ps.setString(1, status);

			ps.setInt(2, orderId);

			int rowCount =
			ps.executeUpdate();

			if(rowCount > 0){

				response.sendRedirect(
				"admin_orders.jsp");

			}
			else{

				response.getWriter().println(
				"Order Status Not Updated");

			}

		}
		catch(Exception e){

			e.printStackTrace();

		}

	}

}