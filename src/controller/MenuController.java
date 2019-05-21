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
 * Servlet implementation class MenuController
 */
@WebServlet("/menus")
public class MenuController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MenuController() {
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
			Pua_menuDao menuDao = new Pua_menuDao(db);
			List<Pua_menu> menus = menuDao.getMenu();
			db.desconectar();
			request.setAttribute("menus", menus);			
			rd = request.getRequestDispatcher("menu/menu.jsp");
			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action =  "";
		action = request.getParameter("operacion");
		if(action.equals("delete")) {
			
		
			DbConnection db = new DbConnection();
			Pua_menuDao menuDao = new Pua_menuDao(db);
			String menuId = request.getParameter("idMenu");
			int respuesta = menuDao.borrarMenu(menuId);
			
			String msg = "";
			if(respuesta != 0) {
				msg = "{\"code\":\"1\", \"message\":\"Menu Eliminado con Exito!\"}";
			}else{
				msg = "{\"code\":\"0\", \"message\":\"El menu no fue eliminado!\"}";
			}
							
			/*enviamos la respuesta y renderizamos la vista*/
			db.desconectar();
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(msg);
		
		}else if(action.equals("add")) {
			
			String nombreParam = request.getParameter("txtNombre");
			String valorParam = request.getParameter("txtValor");
			String descrParam = request.getParameter("txtDescripcion");
			
			/*creamos un objeto de tipo Usuario */
			Pua_menu menu = new Pua_menu();
			menu.setMen_nombre_v(nombreParam);
			menu.setMen_valor_v(valorParam);
			menu.setMen_descripcion_v(descrParam);
			
			/*Procesamos los datos*/
			DbConnection conn = new DbConnection();
			Pua_menuDao menuDao = new Pua_menuDao(conn);
			boolean status = menuDao.insert(menu);
			
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
			String valorParam = request.getParameter("txtValor");
			String descrParam = request.getParameter("txtDescripcion");
			int idMenuParam = Integer.parseInt(request.getParameter("txtMenuId")); 
			
			/*creamos un objeto de tipo Usuario */
			Pua_menu menu = new Pua_menu();
			menu.setMen_nombre_v(nombreParam);
			menu.setMen_valor_v(valorParam);
			menu.setMen_descripcion_v(descrParam);
			menu.setMen_id_i(idMenuParam);
			
			/*Procesamos los datos*/
			DbConnection conn = new DbConnection();
			Pua_menuDao menuDao = new Pua_menuDao(conn);
			boolean status = menuDao.update(menu);
			
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
		}else if(action.equals("getDatos")) {
			DbConnection db = new DbConnection();
			Pua_menuDao menuDao = new Pua_menuDao(db);
			Pua_menu menu = menuDao.getMenuById(request.getParameter("idMenu"));
			db.desconectar();
			String msg = "";
			if(menu.getMen_id_i()  > 0) {
				msg = "{\"code\":\"1\", \"nombre\":\""+ menu.getMen_nombre_v() +"\", "
						+ "\"valor\":\""+ menu.getMen_valor_v() +"\","
								+ "\"descripcion\":\""+ menu.getMen_descripcion_v() +"\", "
										+ "\"id\":\""+menu.getMen_id_i()+"\"}";
			}else{
				msg = "{\"code\":\"0\", \"message\":\"Menu no encntrado!\"}";
			}
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(msg);
		}
	}

}
