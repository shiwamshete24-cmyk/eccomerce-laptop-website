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

@WebServlet("/DeleteUser")

public class DeleteUser extends HttpServlet{

	@Override
	protected void doGet(
	HttpServletRequest request,
	HttpServletResponse response)

	throws ServletException, IOException{

		try{

			int id =
			Integer.parseInt(
			request.getParameter("id"));

			Connection conn =
			DbConnection.getConnection();

			/* DELETE USER */

			PreparedStatement ps =
			conn.prepareStatement(
			"delete from users where id=?");

			ps.setInt(1, id);

			int rowCount =
			ps.executeUpdate();

			if(rowCount > 0){

				response.sendRedirect(
				"admin_users.jsp");

			}
			else{

				response.getWriter().println(
				"User Not Deleted");

			}

		}
		catch(Exception e){

			e.printStackTrace();

		}

	}

}