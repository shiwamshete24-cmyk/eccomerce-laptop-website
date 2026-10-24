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

@WebServlet("/RemoveCartItem")
public class RemoveCartItem extends HttpServlet {

	@Override
	protected void doGet(
	HttpServletRequest request,
	HttpServletResponse response)

	throws ServletException, IOException {

		try {

			// GET CART ID

			int cartId =
			Integer.parseInt(
			request.getParameter("id"));

			// DATABASE CONNECTION

			Connection conn =
			DbConnection.getConnection();

			/* =========================
			   DELETE CART ITEM
			========================= */

			String sql =
			"DELETE FROM cart WHERE id=?";

			PreparedStatement ps =
			conn.prepareStatement(sql);

			ps.setInt(1, cartId);

			ps.executeUpdate();

			/* =========================
			   REDIRECT
			========================= */

			response.sendRedirect("cart.jsp");

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}