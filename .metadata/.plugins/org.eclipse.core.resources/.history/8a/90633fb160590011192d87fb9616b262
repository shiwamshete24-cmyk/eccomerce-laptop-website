package in.sp.Controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import in.sp.connection.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ChangePassword")

public class ChangePassword extends HttpServlet{

	@Override
	protected void doPost(
	HttpServletRequest request,
	HttpServletResponse response)

	throws ServletException, IOException{

		try{

			String email =
			request.getParameter("email");

			String oldPassword =
			request.getParameter("old_password");

			String newPassword =
			request.getParameter("new_password");

			String confirmPassword =
			request.getParameter("confirm_password");

			/* PASSWORD MATCH CHECK */

			if(!newPassword.equals(confirmPassword)){

				response.getWriter().println(

				"<script>alert('New Password and Confirm Password do not match');window.location='change_password.jsp';</script>"

				);

				return;

			}

			/* DATABASE CONNECTION */

			Connection conn =
			DbConnection.getConnection();

			/* CHECK OLD PASSWORD */

			PreparedStatement checkPs =
			conn.prepareStatement(

			"select * from users where email=? and password=?"

			);

			checkPs.setString(1, email);

			checkPs.setString(2, oldPassword);

			ResultSet rs =
			checkPs.executeQuery();

			if(rs.next()){

				/* UPDATE PASSWORD */

				PreparedStatement updatePs =
				conn.prepareStatement(

				"update users set password=? where email=?"

				);

				updatePs.setString(
				1,
				newPassword);

				updatePs.setString(
				2,
				email);

				int rowCount =
				updatePs.executeUpdate();

				if(rowCount > 0){

					response.getWriter().println(

					"<script>alert('Password Changed Successfully');window.location='login.html';</script>"

					);

				}
				else{

					response.getWriter().println(

					"<script>alert('Password Not Changed');window.location='change_password.jsp';</script>"

					);

				}

			}
			else{

				response.getWriter().println(

				"<script>alert('Old Password Incorrect');window.location='change_password.jsp';</script>"

				);

			}

		}
		catch(Exception e){

			e.printStackTrace();

		}

	}

}