package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DbConnection;
import dao.Pua_menuDao;
import dao.Pua_usuariosDao;
import model.Pua_menu;
import model.Pua_usuarios;

/**
 * Servlet implementation class UsuariosController
 */
@WebServlet("/usuarios")
public class UsuariosController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsuariosController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Recuperamos la session activa que viene con el request
		HttpSession session = request.getSession();
		RequestDispatcher rd ;
		/*Aqui no hay session aun*/
		if(session.getAttribute("usuario") == null) {
			rd = request.getRequestDispatcher("login/index.jsp");
			rd.forward(request, response);
		}else { /*Ya esta logieado el usuario*/
			
			DbConnection db = new DbConnection();
			Pua_usuariosDao usuarioDao = new Pua_usuariosDao(db);
			List<Pua_usuarios> usuarios = usuarioDao.getUsuarios();
			db.desconectar();
			request.setAttribute("usuarios", usuarios);
			rd = request.getRequestDispatcher("usuarios/usuarios.jsp");
			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action =  "";
		action = request.getParameter("operacion");
		if(action.equals("delete")) {
			
			DbConnection db = new DbConnection();
			Pua_usuariosDao usuarioDao = new Pua_usuariosDao(db);
			String usuarioId = request.getParameter("idUsuario");
			int respuesta = usuarioDao.borrarUsuario(usuarioId);
			
			String msg = "";
			if(respuesta != 0) {
				msg = "{\"code\":\"1\", \"message\":\"Usuario Eliminado con Exito!\"}";
			}else{
				msg = "{\"code\":\"0\", \"message\":\"Usuario no fue eliminado!\"}";
			}
							
			/*enviamos la respuesta y renderizamos la vista*/
			db.desconectar();
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(msg);
		
		}else if(action.equals("add")) {
			
			String nombreParam = request.getParameter("txtNombre");
			String usuariParam = request.getParameter("txtUsuario");
			String passwoParam = request.getParameter("txtPassword");
			int rolesPramet = Integer.parseInt(request.getParameter("cmbRoles"));
			
			/*creamos un objeto de tipo Usuario */
			Pua_usuarios usuario = new Pua_usuarios();
			usuario.setUsu_nombre_v(nombreParam);
			usuario.setUsu_usuario_v(usuariParam);
			usuario.setUsu_password_v(passwoParam);
			usuario.setUsu_rol_id_i(rolesPramet); //El rol tipo 2 es cliente
			usuario.setUsu_id_i(0);
			
			/*Procesamos los datos*/
			DbConnection conn = new DbConnection();
			Pua_usuariosDao usuariosDao = new Pua_usuariosDao(conn);
			boolean status = usuariosDao.insert(usuario);
			
			/*Preparamos el mensage para el usuario*/
			String msg = "";
			if(status) {
				msg = "{\"code\":\"1\", \"message\":\"Usuario Creado con Exito!\"}";
			}else{
				msg = "{\"code\":\"0\", \"message\":\"Usuario no fue creado!\"}";
			}
			conn.desconectar();
			
			/*enviamos la respuesta y renderizamos la vista*/
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(msg);
		}else if(action.equals("update")){

			String nombreParam = request.getParameter("txtNombre");
			String usuariParam = request.getParameter("txtUsuario");
			String passwoParam = request.getParameter("txtPassword");
			int rolesPramet = Integer.parseInt(request.getParameter("cmbRoles"));
			int idusuParam = Integer.parseInt(request.getParameter("txtUsuarioId"));
			String passwordOldParam = request.getParameter("txtPasswordActual");
			
			/*creamos un objeto de tipo Usuario */
			Pua_usuarios usuario = new Pua_usuarios();
			usuario.setUsu_nombre_v(nombreParam);
			usuario.setUsu_usuario_v(usuariParam);
			if(passwoParam.equals("")) {
				usuario.setUsu_password_v(passwordOldParam);
			}else {
				usuario.setUsu_password_v(passwoParam);
			}
			usuario.setUsu_rol_id_i(rolesPramet); //El rol tipo 2 es cliente
			usuario.setUsu_id_i(idusuParam);
			
			/*Procesamos los datos*/
			DbConnection conn = new DbConnection();
			Pua_usuariosDao usuariosDao = new Pua_usuariosDao(conn);
			boolean status = usuariosDao.update(usuario);
			
			/*Preparamos el mensage para el usuario*/
			String msg = "";
			if(status) {
				msg = "{\"code\":\"1\", \"message\":\"Usuario editado con Exito!\"}";
			}else{
				msg = "{\"code\":\"0\", \"message\":\"Usuario no fue editado!\"}";
			}
			conn.desconectar();
			
			/*enviamos la respuesta y renderizamos la vista*/
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(msg);
		}else if(action.equals("getDatos")) {
			DbConnection db = new DbConnection();
			Pua_usuariosDao usuarioDao = new Pua_usuariosDao(db);
			Pua_usuarios usuario = usuarioDao.getUsuarioById(request.getParameter("idUsuario"));
			db.desconectar();
			String msg = "";
			if(usuario.getUsu_id_i() > 0) {
				msg = "{\"code\":\"1\", \"nombres\":\""+ usuario.getUsu_nombre_v() +"\", "
						+ "\"rol\":\""+ usuario.getUsu_rol_id_i() +"\","
								+ "\"usuario\":\""+ usuario.getUsu_usuario_v() +"\","
										+ "\"password\":\""+ usuario.getUsu_password_v() +"\","
												+ "\"id\":\""+usuario.getUsu_id_i()+"\"}";
			}else{
				msg = "{\"code\":\"0\", \"message\":\"Usuario no encntrado!\"}";
			}
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(msg);
		}

	}

}
