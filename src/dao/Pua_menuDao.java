package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import model.Pua_menu;
import model.Pua_usuarios;

public class Pua_menuDao {
	
	private DbConnection conn;
	
	public Pua_menuDao(DbConnection conn) {
		this.conn = conn;
	}
	
	public boolean insert(Pua_menu menu) {
		String sql = "INSERT INTO pua_menu (men_nombre_v, men_descripcion_v, men_valor_v) VALUES (?, ?, ? )";
		try {
			PreparedStatement ps = conn.getConnection().prepareStatement(sql);
			ps.setString(1, menu.getMen_nombre_v());
			ps.setString(2, menu.getMen_descripcion_v());
			ps.setString(3, menu.getMen_valor_v());
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
			return false;
		}
	}
	
	public boolean update(Pua_menu menu) {
		String sql = "UPDATE pua_menu SET men_nombre_v = ?, men_valor_v = ?, men_descripcion_v = ? WHERE men_id_i = ?";
		try {
			PreparedStatement ps = conn.getConnection().prepareStatement(sql);
			ps.setString(1, menu.getMen_nombre_v());
			ps.setString(3, menu.getMen_descripcion_v());
			ps.setString(2, menu.getMen_valor_v());
			ps.setInt(4, menu.getMen_id_i());
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
			return false;
		}
	}

	public List<Pua_menu> getMenu(){
		String sql = "SELECT * FROM pua_menu ORDER BY men_valor_v ASC LIMIT 20";
		PreparedStatement pd;
		List<Pua_menu> menus = new LinkedList<>();
		try {
			pd = conn.getConnection().prepareStatement(sql);
			ResultSet rs = pd.executeQuery();
			
			Pua_menu menu;
			while (rs.next()) {
				menu = new Pua_menu();
				menu.setMen_id_i(rs.getInt("men_id_i"));
				menu.setMen_nombre_v(rs.getString("men_nombre_v"));
				menu.setMen_ruta_imagen_v(rs.getString("men_ruta_imagen_v"));
				menu.setMen_valor_v(rs.getString("men_valor_v"));
				menu.setMen_descripcion_v(rs.getString("men_descripcion_v"));
				menus.add(menu);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return menus;
	}
	
	public Pua_menu getMenuById(String menuId){
		String sql = "SELECT * FROM pua_menu WHERE men_id_i = ?";
		PreparedStatement pd;
		Pua_menu menu = null;
		
		try {
			pd = conn.getConnection().prepareStatement(sql);
			pd.setString(1, menuId);
			ResultSet rs = pd.executeQuery();
			menu = new Pua_menu();
			while (rs.next()) {
				menu.setMen_id_i(rs.getInt("men_id_i"));
				menu.setMen_nombre_v(rs.getString("men_nombre_v"));
				menu.setMen_ruta_imagen_v(rs.getString("men_ruta_imagen_v"));
				menu.setMen_valor_v(rs.getString("men_valor_v"));
				menu.setMen_descripcion_v(rs.getString("men_descripcion_v"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return menu;
	}
	
	public int borrarMenu(String menuId) {
		String sql = "DELETE FROM pua_menu WHERE men_id_i = ?";
		PreparedStatement pd;
		int rows = 0;
		try {
			pd = conn.getConnection().prepareStatement(sql);
			pd.setString(1, menuId);
			rows = pd.executeUpdate();
		}catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
		}
		return rows;
	}
}
