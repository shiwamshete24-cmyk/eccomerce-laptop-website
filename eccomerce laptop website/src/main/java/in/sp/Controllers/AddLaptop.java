package in.sp.Controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

import in.sp.connection.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/AddLaptop")

@MultipartConfig

public class AddLaptop extends HttpServlet {

	@Override
	protected void doPost(
	HttpServletRequest request,
	HttpServletResponse response)

	throws ServletException, IOException {

		try {

			/* =========================
			   GET FORM DATA
			========================= */

			String brand =
			request.getParameter("brand");

			String name =
			request.getParameter("name");

			/* PRICE */

			String priceValue =
			request.getParameter("price");

			double price = 0;

			if(priceValue != null
			&&
			!priceValue.trim().equals("")) {

				price =
				Double.parseDouble(priceValue);

			}

			/* OLD PRICE */

			String oldPriceValue =
			request.getParameter("old_price");

			double oldPrice = 0;

			if(oldPriceValue != null
			&&
			!oldPriceValue.trim().equals("")) {

				oldPrice =
				Double.parseDouble(oldPriceValue);

			}

			String processor =
			request.getParameter("processor");

			String ram =
			request.getParameter("ram");

			String storage =
			request.getParameter("storage");

			String graphics =
			request.getParameter("graphics");

			String displaySize =
			request.getParameter("display_size");

			String displayType =
			request.getParameter("display_type");

			String battery =
			request.getParameter("battery");

			String operatingSystem =
			request.getParameter("operating_system");

			String color =
			request.getParameter("color");

			String weight =
			request.getParameter("weight");

			String warranty =
			request.getParameter("warranty");

			/* STOCK */

			String stockValue =
			request.getParameter("stock");

			int stock = 0;

			if(stockValue != null
			&&
			!stockValue.trim().equals("")) {

				stock =
				Integer.parseInt(stockValue);

			}

			String category =
			request.getParameter("category");

			String description =
			request.getParameter("description");

			/* =========================
			   IMAGE PARTS
			========================= */

			Part part1 =
			request.getPart("image1");

			Part part2 =
			request.getPart("image2");

			Part part3 =
			request.getPart("image3");

			String image1 = "";
			String image2 = "";
			String image3 = "";

			if(part1 != null
			&&
			part1.getSize() > 0) {

				image1 =
				Paths.get(
				part1.getSubmittedFileName())
				.getFileName()
				.toString();

			}

			if(part2 != null
			&&
			part2.getSize() > 0) {

				image2 =
				Paths.get(
				part2.getSubmittedFileName())
				.getFileName()
				.toString();

			}

			if(part3 != null
			&&
			part3.getSize() > 0) {

				image3 =
				Paths.get(
				part3.getSubmittedFileName())
				.getFileName()
				.toString();

			}

			/* =========================
			   UPLOAD FOLDER
			========================= */

			String uploadPath =
			getServletContext()
			.getRealPath("/")
			+
			"images"
			+
			File.separator
			+
			"laptops";

			File uploadDir =
			new File(uploadPath);

			if(!uploadDir.exists()) {

				uploadDir.mkdirs();

			}

			/* =========================
			   SAVE IMAGE 1
			========================= */

			if(image1 != null
			&&
			!image1.equals("")) {

				part1.write(
				uploadPath
				+
				File.separator
				+
				image1);

			}

			/* =========================
			   SAVE IMAGE 2
			========================= */

			if(image2 != null
			&&
			!image2.equals("")) {

				part2.write(
				uploadPath
				+
				File.separator
				+
				image2);

			}

			/* =========================
			   SAVE IMAGE 3
			========================= */

			if(image3 != null
			&&
			!image3.equals("")) {

				part3.write(
				uploadPath
				+
				File.separator
				+
				image3);

			}

			/* =========================
			   DATABASE CONNECTION
			========================= */

			Connection conn =
			DbConnection.getConnection();

			PreparedStatement ps =
			conn.prepareStatement(

			"insert into laptops(name, brand, price, old_price, processor, ram, storage, graphics, display_size, display_type, battery, operating_system, color, weight, warranty, stock, category, description, image1, image2, image3) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

			);

			ps.setString(1, name);

			ps.setString(2, brand);

			ps.setDouble(3, price);

			ps.setDouble(4, oldPrice);

			ps.setString(5, processor);

			ps.setString(6, ram);

			ps.setString(7, storage);

			ps.setString(8, graphics);

			ps.setString(9, displaySize);

			ps.setString(10, displayType);

			ps.setString(11, battery);

			ps.setString(12, operatingSystem);

			ps.setString(13, color);

			ps.setString(14, weight);

			ps.setString(15, warranty);

			ps.setInt(16, stock);

			ps.setString(17, category);

			ps.setString(18, description);

			ps.setString(19, image1);

			ps.setString(20, image2);

			ps.setString(21, image3);

			/* =========================
			   EXECUTE QUERY
			========================= */

			int rowCount =
			ps.executeUpdate();

			if(rowCount > 0) {

				response.sendRedirect(
				"admin_laptops.jsp");

			}
			else {

				response.getWriter().println(
				"Laptop Not Added");

			}

		}
		catch(Exception e) {

			e.printStackTrace();

		}

	}

}