package in.sp.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
	
	public static Connection getConnection() {
		
		Connection conn = null ;
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/laptop_website" , "root" , "Shiwam@2003");
			
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return conn;
	}

}
