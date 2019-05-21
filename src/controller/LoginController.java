package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DbConnection;
import dao.Pua_usuariosDao;
import model.Pua_usuarios;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Recuperamos la session activa que viene con el request
		HttpSession session = request.getSession();
		String action =  "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else {
			action = "default";
		}
		
		RequestDispatcher rd ;
		/*Aqui no hay session aun*/
		switch (action) {
			/*Destruimos la session*/
			case "logout":
					session.invalidate();
					response.sendRedirect(request.getContextPath()+"/homepage");
				break;
				
			case "login":
				if(session.getAttribute("usuario") == null) {
					rd = request.getRequestDispatcher("login/index.jsp");
					rd.forward(request, response);
				}else { /*Ya esta logieado el usuario*/
					rd = request.getRequestDispatcher("principal/principal.jsp");
					rd.forward(request, response);
				}
			break;
			
			default:
				rd = request.getRequestDispatcher("login/index.jsp");
				rd.forward(request, response);
				break;
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userParam = request.getParameter("txtUserName");
		String passParam = request.getParameter("txtPassword");
		String msg = "";
		//Recuperamos una instancia del objeto session
		HttpSession session = request.getSession();
		DbConnection conn = new DbConnection();
		Pua_usuariosDao usuarioDao = new Pua_usuariosDao(conn);
		//verificamos en la base de datos si el usuario es correcto
		Pua_usuarios usuario = usuarioDao.login(userParam, passParam);
		conn.desconectar();
		
		RequestDispatcher rd;
		
		if(usuario.getUsu_id_i() > 0) {
			/*creamos una variable de session con el bean del usuario*/
			session.setAttribute("usuario", usuario);
			if(request.getParameter("ruta") != null
					&& request.getParameter("ruta").equals("carrito")) {
				rd = request.getRequestDispatcher("carrito/carrito.jsp");
				rd.forward(request, response);
			}else {
				rd = request.getRequestDispatcher("principal/principal.jsp");
				rd.forward(request, response);
			}
			
		}else {
			msg = "Usuario y/o Password Errados!";
			request.setAttribute("message", msg);
			rd = request.getRequestDispatcher("login/index.jsp");
			rd.forward(request, response);
		}
		
		
	}

}
