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
             <h3>Que menus ofrecemos?</h3>
           </div>
         </div>
         <div class="clearfix"></div>
			<div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Productos registrados en el sistema</h2>
                    <ul class="nav navbar-right panel_toolbox">
	                    <li>
	                    	<a data-toggle="modal" data-target="#nuevoMenu" class="btn btn-default btn-sm" title="Agregar nuevo Menu">
	                    		<i class="fa fa-plus"></i>
	                    	</a>
	                    </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                     <table class="table table-hover table-bordered" id="tablaMenus" style="width:100%">
                     	<thead>
                     		<tr>
                     			<th style="width:10px;">#</th>
                     			<th>Nombre</th>
                     			<th>Descripci&oacute;n</th>
                     			<th>valor</th>
                     			<th style="width:10%;"></th>
                     		</tr>
                     	</thead>
                     	<tbody>
                     		<% int i = 1; %>
                     		<c:forEach items="${menus}" var="menu" varStatus="status">
                     			<tr>
                     				<td><%=i%></td>
                     				<td>${menu.men_nombre_v}</td>
                     				<td>${fn:substring(menu.men_descripcion_v, 0, 100)}</td>
                     				<td>$<fmt:formatNumber value = "${menu.men_valor_v}" type = "number"/></td>
                     				<td>
                     					<button  data-toggle="modal" data-target="#editarMenu" class="btn btn-default btn-sm btnEditarMenu" title="Editar Menu" attrmenu="${menu.men_id_i}">
                     						<i class="fa fa-edit"></i>
                     					</button>
                     					<button class="btn btn-danger btn-sm btnEliminarMenu" title="Eliminar Menu" attrmenu="${menu.men_id_i}">
                     						<i class="fa fa-trash-o"></i>
                     					</button>
                     				</td>
                     			</tr>
                     			<% i++; %>
                     		</c:forEach>
                     	</tbody>
                     </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->
      </div>
      
      <div id="nuevoMenu" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
	        		</button>
	        		<h4 class="modal-title" id="myModalLabel">Nuevo Menu</h4>
	      		</div>
	     	 	<div class="modal-body">
	        		<form id="formRegistro" enctype="multipart/form-data">
			      		<div class="form-group">
			      			<label>Nombre</label>
			        		<input type="text" class="form-control" name="txtNombre" placeholder="Nombre" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Valor</label>
			        		<input type="text" class="form-control" name="txtValor"  placeholder="Valor" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Descripci&oacute;n</label>
			        		<textarea class="form-control" name="txtDescripcion"  placeholder="Descripci&oacute;n"></textarea>
			        		<input type="hidden" name="operacion" value="add"/>
			      		</div>
			      		<div class="clearfix"></div>
			    	</form>
	      		</div>
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
	        		<button type="button" id="btnSalvarMenuNuevo" class="btn btn-primary">Guardar Cambios</button>
	      		</div>	
	    	</div>
	  	</div>
	</div>
	
	<div id="editarMenu" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
	        		</button>
	        		<h4 class="modal-title" id="myModalLabel">Editar Menu</h4>
	      		</div>
	     	 	<div class="modal-body">
	        		<form id="formRegistroEdicion" enctype="multipart/form-data">
			      		<div class="form-group">
			      			<label>Nombre</label>
			        		<input type="text" class="form-control" name="txtNombre" id="txtNombre" placeholder="Nombre" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Valor</label>
			        		<input type="text" class="form-control" name="txtValor" id="txtValor" placeholder="Valor" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Descripci&oacute;n</label>
			        		<textarea class="form-control" name="txtDescripcion" id="txtDescripcion" placeholder="Descripci&oacute;n"></textarea>
			        		<input type="hidden" name="operacion" value="update"/>
			      		</div>
			      		<div class="clearfix"></div>
	      				<input type="hidden" name="txtMenuId" id="txtMenuId">
			    	</form>
	      		</div>
	      		<div class="modal-footer">
	      			
	        		<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
	        		<button type="button" id="btnSalvarMenuEditar" class="btn btn-primary">Guardar Cambios</button>
	      		</div>	
	    	</div>
	  	</div>
	  	
    </div>
    <script type="text/javascript">
	    $(function(){
	    	$("#mens").addClass("active");
	    	$("#tablaMenus").DataTable({
	    	    "language" : {
	    	        "sProcessing":     "Procesando...",
	    	        "sLengthMenu":     "Mostrar _MENU_ registros",
	    	        "sZeroRecords":    "No se encontraron resultados",
	    	        "sEmptyTable":     "Ningún dato disponible en esta tabla",
	    	        "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_",
	    	        "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0",
	    	        "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
	    	        "sInfoPostFix":    "",
	    	        "sSearch":         "Buscar:",
	    	        "sUrl":            "",
	    	        "sInfoThousands":  ",",
	    	        "sLoadingRecords": "Cargando...",
	    	        "oPaginate": {
	    	            "sFirst":    "Primero",
	    	            "sLast":     "Último",
	    	            "sNext":     "Siguiente",
	    	            "sPrevious": "Anterior"
	    	        },
	    	        "oAria": {
	    	            "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
	    	            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
	    	        }
	    	    } 
	    	});
	    	$('#tablaMenus tbody').on("click", ".btnEditarMenu", function(){
	    		var x = $(this).attr('attrmenu');
	    	    $.ajax({
	    	        url   : '<%=request.getContextPath()%>/menus',
	    	        method: 'post',
	    	        data  : { idMenu : x, operacion : "getDatos"},
	    	        dataType    : 'json',
	    	        success     : function(data){                  
	    	            $("#txtNombre").val(data.nombre);
	    	            $("#txtValor").val(data.valor);
	    	            $("#txtDescripcion").val(data.descripcion);
	    	            $("#txtMenuId").val(data.id);
 	                }
	    	    });
	    	});
	    	
	    	$('#tablaMenus tbody').on("click", ".btnEliminarMenu", function(){
	    	    var x = $(this).attr('attrmenu');
	    	    swal({
	    	        title: '¿Está seguro de borrar el menu?',
	    	        text: "¡Si no lo está puede cancelar la accíón!",
	    	        type: 'warning',
	    	        showCancelButton: true,
	    	        confirmButtonColor: '#3085d6',
	    	        cancelButtonColor: '#d33',
	    	        cancelButtonText: 'Cancelar',
	    	        confirmButtonText: 'Si, borrar menu!'
	    	    },function(isConfirm) {
	    	        if (isConfirm) {
	    	        	$.ajax({
	    					url : '<%=request.getContextPath()%>/menus',
	    					type: 'post',
	    					data: { operacion : "delete", idMenu : x},
	    	                dataType : 'json',
	    	                success:function(data){
	    	                	if(data.code == '1'){
	    	                		/*Registro insertado*/
	    							swal({
	    								title  : 'Menu eliminado con exito!',
	    								type   : 'success',
	    								configButtonText : "Cerrar",
	    								closeOnConfirm: false
	    							},function(){
	    								window.location.reload(true);
	    							})
	    	                	}else{
	    	                		/*Nada, no se inserto*/
	    	                		swal({
	    								title  : 'No pudimos eliminar la informacion, intenta mas tarde!',
	    								type   : 'error',
	    								configButtonText : "Cerrar",
	    								closeOnConfirm: false
	    							},function(){
	    								
	    							})
	    	                	}
	    	                }
	    	        	});
	    	       
	    	        }
	    	    })
	    	});
	    	
	    	$("#btnSalvarMenuNuevo").click(function(){
	    		/*Guardamos el nuevo menu*/
	    		$.ajax({
					url : '<%=request.getContextPath()%>/menus',
					type: 'post',
					data: $("#formRegistro").serialize(),
	                dataType : 'json',
	                success:function(data){
	                	if(data.code == '1'){
	                		/*Registro insertado*/
							swal({
								title  : 'Menu guardado con exito!',
								type   : 'success',
								configButtonText : "Cerrar",
								closeOnConfirm: false
							},function(){
								window.location.reload(true);
							})
	                	}else{
	                		/*Nada, no se inserto*/
	                		swal({
								title  : 'No pudimos guardar la informacion, intenta mas tarde!',
								type   : 'error',
								configButtonText : "Cerrar",
								closeOnConfirm: true
							})
	                	}
	                }
				})
	    	});
	    	
			$("#btnSalvarMenuEditar").click(function(){
	    		/*Guardamos los datos del menu*/
	    		$.ajax({
					url : '<%=request.getContextPath()%>/menus',
					type: 'post',
					data: $("#formRegistroEdicion").serialize(),
	                dataType : 'json',
	                success:function(data){
	                	if(data.code == '1'){
	                		/*Registro insertado*/
							swal({
								title  : 'Menu editado con exito!',
								type   : 'success',
								configButtonText : "Cerrar",
								closeOnConfirm: false
							},function(){
								window.location.reload(true);
							})
	                	}else{
	                		/*Nada, no se inserto*/
	                		swal({
								title  : 'No pudimos guardar la informacion, intenta mas tarde!',
								type   : 'error',
								configButtonText : "Cerrar",
								closeOnConfirm: true
							})
	                	}
	                }
				});
    		});
	    });
    </script>
  <jsp:include page="../includes/footer.jsp" />
  
       