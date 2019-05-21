package model;

import java.util.Date;

public class Pua_usuarios {
	private int usu_id_i;
	private String usu_nombre_v;
	private String usu_password_v;
	private String usu_usuario_v;
	private int usu_rol_id_i;
	private String rol_nombre_v;
	private Date usu_ultimo_login_d;
	
	public Pua_usuarios() {
		
	}
	
	public int getUsu_id_i() {
		return usu_id_i;
	}
	public void setUsu_id_i(int usu_id_i) {
		this.usu_id_i = usu_id_i;
	}
	public String getUsu_nombre_v() {
		return usu_nombre_v;
	}
	public void setUsu_nombre_v(String usu_nombre_v) {
		this.usu_nombre_v = usu_nombre_v;
	}
	public String getUsu_password_v() {
		return usu_password_v;
	}
	public void setUsu_password_v(String usu_password_v) {
		this.usu_password_v = usu_password_v;
	}
	public String getUsu_usuario_v() {
		return usu_usuario_v;
	}
	public void setUsu_usuario_v(String usu_usuario_v) {
		this.usu_usuario_v = usu_usuario_v;
	}
	public int getUsu_rol_id_i() {
		return usu_rol_id_i;
	}
	public void setUsu_rol_id_i(int usu_rol_id_i) {
		this.usu_rol_id_i = usu_rol_id_i;
	}
	public String getRol_nombre_v() {
		return rol_nombre_v;
	}
	public void setRol_nombre_v(String rol_nombre_v) {
		this.rol_nombre_v = rol_nombre_v;
	}
	public Date getUsu_ultimo_login_d() {
		return usu_ultimo_login_d;
	}
	public void setUsu_ultimo_login_d(Date usu_ultimo_login_d) {
		this.usu_ultimo_login_d = usu_ultimo_login_d;
	}
	
}
