package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

import model.Pua_detalle_pedido;
import model.Pua_menu;
import model.Pua_pedido;

public class Pua_pedidoDao {
	private DbConnection conn;
	
	public Pua_pedidoDao(DbConnection conn) {
		this.conn = conn;
	}
	
	public int insert(Pua_pedido pedido) {
		int id = 0;
		String sql = "INSERT INTO pua_pedido (ped_usu_id_i, ped_fecha_d) VALUES (?, ? )";
		try {
			PreparedStatement ps = conn.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, pedido.getPed_usu_id_i());
			ps.setString(2, pedido.getPed_fecha_d());
			ps.executeUpdate();
		
			ResultSet rs = ps.getGeneratedKeys();
			
			if(rs.next()){
				id = rs.getInt(1);
			}
			return id;
		} catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
			return 0;
		}
	}
	
	
	public boolean insertDetalle(Pua_detalle_pedido pua_detalle_pedido) {
		String sql = "INSERT INTO  pua_detalle_pedido (dep_ped_id_i	, dep_menu_id_i, dep_valor_v,dep_cantidad_i) VALUES (?, ?, ?, ? )";
		try {
			PreparedStatement ps = conn.getConnection().prepareStatement(sql);
			ps.setInt(1, pua_detalle_pedido.getDep_ped_id_i());
			ps.setInt(2, pua_detalle_pedido.getDep_menu_id_i());
			ps.setString(3, pua_detalle_pedido.getDep_valor_v());
			ps.setInt(4, pua_detalle_pedido.getDep_cantidad_i());
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
			return false;
		}
	}
	
	
}
