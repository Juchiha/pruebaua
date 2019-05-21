package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	/*Declaramos las variables de acceso a la base de datos*/
	static String datB = "prueba_uniatlantico";
	static String user = "root";
	static String pass = "123456";
	static String serv = "jdbc:mysql://localhost:3306/"+datB;
	
	//Variable para la conexion
	Connection conn = null;
	
	public DbConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(serv, user, pass);
			if(conn != null) {
				//System.out.print("Estamos conectados!");
			}
		}catch (SQLException e) {
			System.out.print("este es el error, conexion => " + e.getMessage());
		}catch(ClassNotFoundException e) {
			System.out.print("este es el error, clase no encontrada => " + e.getMessage());
		}
	}
	
	/*Recuperamos la conecion*/
	public Connection getConnection() {
		return conn;
	}
	
	/*Desconectamos de la base de datos*/
	public void desconectar() {
		if(conn != null) {
			try {
				conn.close();
			}catch (SQLException e) {
				System.out.print("este es el error, conexion => " + e.getMessage());
			}
		}
	}
}
