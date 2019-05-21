<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  		<meta name="description" content="Pagina para hacer pedidos">
  		<meta name="author" content="Jose Giron">
		<title>Pedidos Menu!</title>
		<!-- Bootstrap core CSS -->
		<link href="assets/inicio/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Custom styles for this template -->
		<link href="assets/inicio/css/shop-homepage.css" rel="stylesheet">
		
		<!-- Alertify -->
	    <link rel="stylesheet" href="assets/vendors/alertify/alertify.core.css"/>
	    <link rel="stylesheet" href="assets/vendors/alertify/alertify.default.css"/>  
	</head>
	<body class="nav-md">
		
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		  	<div class="container">
		    	<a class="navbar-brand" href="homepage">Pedidos Menu</a>
	    		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
		      		<span class="navbar-toggler-icon"></span>
		    	</button>
		    	<div class="collapse navbar-collapse" id="navbarResponsive">
		      		<ul class="navbar-nav ml-auto">
				        <li class="nav-item active">
				          	<a class="nav-link" href="homepage">Home
				            	<span class="sr-only">(current)</span>
				          	</a>
				        </li>
				        <li class="nav-item">
				        	  <a class="nav-link" href="carrito">Carrito</a>
				        </li>
			        	<li class="nav-item">
			          		<a class="nav-link" href="login?action=login">Ingresar</a>
			        	</li>
			      	</ul>
		    	</div>
		  	</div>
		</nav>
		
		<div class="container">
			<br/>
    		<div class="row">
				 <div class="col-lg-12 col-xs-12 col-md-12">
				 	 <div class="row">
				 	 	<c:forEach items="${menus}" var="menu" varStatus="status">
				 	 		<div class="col-lg-3 col-md-6 mb-3">
							  	<div class="card h-100">
							    	<a href="#">
							    		<img class="card-img-top" src="http://placehold.it/700x400" alt="">
						    		</a>
						    		<div class="card-body">
								      	<h4 class="card-title">
								        	<a href="#">${menu.men_nombre_v}</a>
								      	</h4>
								      	<h5>$<fmt:formatNumber value = "${menu.men_valor_v}" type = "number"/></h5>
								      	<p class="card-text">${fn:substring(menu.men_descripcion_v, 0, 100)}</p>
							    	</div>
							    	<div class="card-footer">
							    		<div class="row">
							    			<div class="col-md-5">
							    				<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>	
							    			</div>
							    			<div style="text-align:right;" class="col-md-7">
								    			<button class="btn btn-sm btn-primary pull-rigth btnComprar" producto="${menu.men_id_i}" valor="${menu.men_valor_v}" nombre="${menu.men_nombre_v}" >
								      				Comprar!
								      			</button>
							    			</div>
							    		</div>
							      		
							      		
							    	</div>
							  	</div>
							</div>
				 	 	</c:forEach>
				 	 </div>
				 </div>
			</div>
		</div>
		
		<!-- Bootstrap core JavaScript -->
  		<script src="assets/inicio/vendor/jquery/jquery.min.js"></script>
  		<script src="assets/inicio/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  		<script src="assets/vendors/alertify/alertify.js"></script>
  		<script src="assets/paginasjs/basedatos.js"></script>
  		<script type="text/javascript">
  			
  			$(function(){
  				BaseDatos.crearBaseDatos();
  		
  				$(".btnComprar").click(function(){
  					var valor = $(this).attr("valor");
  					var nombr = $(this).attr("nombre");
  					var produ = $(this).attr("producto");
  					
  					var anyadir = {
  						"producto":produ,
  						"valor" : valor,
  						"nombre":nombr
  					}
  					
  					BaseDatos.insertarDatos(anyadir);
  					
  				});
  			});
  		</script>

	</body>
</html>
	
	
	