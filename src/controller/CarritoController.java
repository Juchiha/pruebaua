package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import dao.Pua_pedidoDao;
import model.Pua_detalle_pedido;
import model.Pua_menu;
import model.Pua_pedido;
import model.Pua_usuarios;

/**
 * Servlet implementation class CarritoController
 */
@WebServlet("/carrito")
public class CarritoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CarritoController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		RequestDispatcher rd ;
		/*Aqui no hay session aun*/
		if(session.getAttribute("usuario") == null) {
			request.setAttribute("ruta", "carrito");
			rd = request.getRequestDispatcher("login/index.jsp");
			rd.forward(request, response);
		}else { /*Ya esta logieado el usuario*/
			rd = request.getRequestDispatcher("carrito/carrito.jsp");
			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(session.getAttribute("usuario") == null) {
			System.out.print("No tiene permiso");
		}else { /*Ya esta logieado el usuario*/
			
			DbConnection db = new DbConnection();
			Pua_pedidoDao pedidoDao = new Pua_pedidoDao(db);
			Pua_usuarios usuario = (Pua_usuarios) session.getAttribute("usuario");
			Pua_pedido pedido = new Pua_pedido();
			pedido.setPed_usu_id_i(usuario.getUsu_id_i());
			String pattern = "yyyy-MM-dd";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

			String date = simpleDateFormat.format(new Date());
			pedido.setPed_fecha_d(date);
			int respuesta = pedidoDao.insert(pedido);
			
			String msg = "";
			if(respuesta != 0) {
				int total = Integer.parseInt(request.getParameter("cantidadProductos"));
				total = total +1;
				for(int i = 1; i < total; i++) {
					if(request.getParameter("idMenu_"+i) != null) {
						Pua_detalle_pedido det = new Pua_detalle_pedido();
						det.setDep_cantidad_i(1);
						det.setDep_menu_id_i(Integer.parseInt(request.getParameter("idMenu_"+i)))
						;
						det.setDep_ped_id_i(respuesta);
						det.setDep_valor_v(request.getParameter("valorMenu_"+i));
						boolean NewRespuesta = pedidoDao.insertDetalle(det);
					}
				}
				msg = "{\"code\":\"1\", \"message\":\"Pedido guardado con Exito!\"}";
			}else{
				msg = "{\"code\":\"0\", \"message\":\"El pedido no fue guardao!\"}";
			}
							
			/*enviamos la respuesta y renderizamos la vista*/
			db.desconectar();
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(msg);
			
		}
		
	}

}
