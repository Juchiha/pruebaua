<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../includes/head.jsp" />
<body class="nav-md">	
<div class="container body">
    <div class="main_container">
	<jsp:include page="../includes/menu.jsp" />
		
	<jsp:include page="../includes/nav.jsp" />
	<!-- page content -->
    <div class="right_col" role="main">
       <div class="">
         <div class="page-title">
           <div class="title_left">
             <h3>Productos añadidos al pedido</h3>
           </div>
         </div>
         <div class="clearfix"></div>
			<div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Productos en la cesta de pedidos</h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  		<form id="guardarCarrito">
                  			<table class="table table-hover table-bordered" id="tableCarrito"> 
	                  			<thead>
	                  				<tr>
	                  					<th style="width:10px">#</th>
	                  					<th>Producto</th>
	                  					<th>Valor</th>
	                  					<th style="width:10%;"></th>
	                  				</tr>
	                  			</thead>
	                  			<tbody id="misProductosCarrito">
	                  			
	                  			</tbody>
	                  		</table>
	                  		 <input type="hidden" name="cantidadProductos" id="cantidadProductos" />
                  		</form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->
      </div>
      <script src="assets/vendors/alertify/alertify.js"></script>
  	  <script src="assets/paginasjs/basedatos.js"></script>
  	  <script type="text/javascript">
  	  	$(function(){
  	  		BaseDatos.leerDatos($("#misProductosCarrito"));
  	  	});
  	  </script>
      <jsp:include page="../includes/footer.jsp" />
                 