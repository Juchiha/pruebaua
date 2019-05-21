package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import model.Pua_usuarios;

public class Pua_usuariosDao {
	private DbConnection conn;
	
	public Pua_usuariosDao(DbConnection conn) {
		this.conn = conn;
	}
	
	public boolean insert(Pua_usuarios usuario) {
		String sql = "INSERT INTO pua_usuarios (usu_nombre_v, usu_password_v, usu_usuario_v, usu_rol_id_i) VALUES (?, md5(?), ?, ?)";
		try {
			PreparedStatement ps = conn.getConnection().prepareStatement(sql);
			ps.setString(1, usuario.getUsu_nombre_v());
			ps.setString(2, usuario.getUsu_password_v());
			ps.setString(3, usuario.getUsu_usuario_v());
			ps.setInt(4, usuario.getUsu_rol_id_i());
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
			return false;
		}
	}
	
	public boolean update(Pua_usuarios usuario) {
		String sql = "UPDATE pua_usuarios SET usu_nombre_v = ?, usu_usuario_v = ?, usu_rol_id_i = ? WHERE usu_id_i = ?";
		try {
			PreparedStatement ps = conn.getConnection().prepareStatement(sql);
			ps.setString(1, usuario.getUsu_nombre_v());
			ps.setString(2, usuario.getUsu_usuario_v());
			ps.setInt(3, usuario.getUsu_rol_id_i());
			ps.setInt(4, usuario.getUsu_id_i());
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
			return false;
		}
	}
	
	public List<Pua_usuarios> getUsuarios(){
		String sql = "SELECT * FROM pua_usuarios JOIN pua_rol ON rol_id_i = usu_rol_id_i   ORDER BY usu_nombre_v";
		PreparedStatement pd;
		List<Pua_usuarios> usuarios = new LinkedList<>();
		try {
			pd = conn.getConnection().prepareStatement(sql);
			ResultSet rs = pd.executeQuery();
			
			Pua_usuarios usuario;
			while (rs.next()) {
				usuario = new Pua_usuarios();
				usuario.setUsu_id_i(rs.getInt("usu_id_i"));
				usuario.setUsu_nombre_v(rs.getString("usu_nombre_v"));
				usuario.setUsu_password_v(rs.getString("usu_password_v"));
				usuario.setUsu_usuario_v(rs.getString("usu_usuario_v"));
				usuario.setUsu_ultimo_login_d(rs.getDate("usu_ultimo_login_d"));
				usuario.setRol_nombre_v(rs.getString("rol_nombre_v"));
				usuarios.add(usuario);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return usuarios;
	}
	
	public Pua_usuarios login(String user, String pass) {
		String sql = "SELECT * FROM pua_usuarios JOIN pua_rol ON rol_id_i = usu_rol_id_i WHERE usu_usuario_v = ? AND usu_password_v = md5(?)";
		PreparedStatement pd;
		Pua_usuarios usuario = null ;
		try {
			pd = conn.getConnection().prepareStatement(sql);
			pd.setString(1, user);
			pd.setString(2, pass);
			ResultSet rs = pd.executeQuery();
		
			while (rs.next()) {
				usuario = new Pua_usuarios();
				usuario.setUsu_id_i(rs.getInt("usu_id_i"));
				usuario.setUsu_nombre_v(rs.getString("usu_nombre_v"));
				usuario.setUsu_password_v(rs.getString("usu_password_v"));
				usuario.setUsu_usuario_v(rs.getString("usu_usuario_v"));
				usuario.setUsu_ultimo_login_d(rs.getDate("usu_ultimo_login_d"));
				usuario.setRol_nombre_v(rs.getString("rol_nombre_v"));
				usuario.setUsu_rol_id_i(rs.getInt("usu_rol_id_i"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return usuario;
	}
	
	public Pua_usuarios getUsuarioById(String userId) {
		String sql = "SELECT * FROM pua_usuarios JOIN pua_rol ON rol_id_i = usu_rol_id_i WHERE usu_id_i = ?";
		PreparedStatement pd;
		Pua_usuarios usuario = null ;
		try {
			pd = conn.getConnection().prepareStatement(sql);
			pd.setString(1, userId);
			ResultSet rs = pd.executeQuery();
		
			while (rs.next()) {
				usuario = new Pua_usuarios();
				usuario.setUsu_id_i(rs.getInt("usu_id_i"));
				usuario.setUsu_nombre_v(rs.getString("usu_nombre_v"));
				usuario.setUsu_password_v(rs.getString("usu_password_v"));
				usuario.setUsu_usuario_v(rs.getString("usu_usuario_v"));
				usuario.setUsu_ultimo_login_d(rs.getDate("usu_ultimo_login_d"));
				usuario.setRol_nombre_v(rs.getString("rol_nombre_v"));
				usuario.setUsu_rol_id_i(rs.getInt("usu_rol_id_i"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return usuario;
	}
	
	public int borrarUsuario(String usuarioId) {
		String sql = "DELETE FROM pua_usuarios WHERE usu_id_i = ?";
		PreparedStatement pd;
		int rows = 0;
		try {
			pd = conn.getConnection().prepareStatement(sql);
			pd.setString(1, usuarioId);
			rows = pd.executeUpdate();
		}catch (SQLException e) {
			System.out.print("Error => " + e.getMessage());
		}
		return rows;
	}
}
