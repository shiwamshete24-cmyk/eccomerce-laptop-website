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

@WebServlet("/DeleteLaptop")

public class DeleteLaptop extends HttpServlet{

	@Override
	protected void doGet(
	HttpServletRequest request,
	HttpServletResponse response)

	throws ServletException, IOException{

		try{

			/* GET ID */

			int id =
			Integer.parseInt(
			request.getParameter("id"));

			/* DATABASE CONNECTION */

			Connection conn =
			DbConnection.getConnection();

			/* DELETE QUERY */

			PreparedStatement ps =
			conn.prepareStatement(

			"delete from laptops where id=?"

			);

			ps.setInt(1, id);

			int rowCount =
			ps.executeUpdate();

			if(rowCount > 0){

				response.sendRedirect(
				"admin_laptops.jsp");

			}
			else{

				response.getWriter().println(
				"Laptop Not Deleted");

			}

		}
		catch(Exception e){

			e.printStackTrace();

		}

	}

}