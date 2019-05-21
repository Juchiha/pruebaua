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
             <h3>Quienes pueden acceder?</h3>
           </div>
         </div>
         <div class="clearfix"></div>
			<div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Usuarios y clientes registrados en el sistema </h2>
                    <ul class="nav navbar-right panel_toolbox">
	                    <li>
	                    	<a data-toggle="modal" data-target="#nuevoUsuario" class="btn btn-default btn-sm" title="Agregar nuevo usuario">
	                    		<i class="fa fa-plus"></i>
	                    	</a>
	                    </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                     <table class="table table-hover table-bordered" id="tblaUsuarios" style="width:100%">
                     	<thead>
                     		<tr>
                     			<th style="width:10px;">#</th>
                     			<th>Nombre</th>
                     			<th>Usuario</th>
                     			<th>Rol</th>
                     			<th>Ultimo login</th>
                     			<th style="width:10%;"></th>
                     		</tr>
                     	</thead>
                     	<tbody>
                     		<% int i = 1; %>
                     		<c:forEach items="${usuarios}" var="usuario" varStatus="status">
                     			<tr>
                     				<td><%=i%></td>
                     				<td>${usuario.usu_nombre_v}</td>
                     				<td>${usuario.usu_usuario_v}</td>
                     				<td>${usuario.rol_nombre_v}</td>
                     				<td>${usuario.usu_ultimo_login_d}</td>
                     				<td>
                     					<button data-toggle="modal" data-target="#editarUsuario" class="btn btn-default btn-sm btnEditarUsuario" title="Editar Usuario" attrusuario="${usuario.usu_id_i}">
                     						<i class="fa fa-edit"></i>
                     					</button>
                     					<button class="btn btn-danger btn-sm btnEliminarUsuario" title="Eliminar Usuario" attrusuario="${usuario.usu_id_i}">
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
    </div>
	<div id="nuevoUsuario" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
	        		</button>
	        		<h4 class="modal-title" id="myModalLabel">Nuevo Usuario</h4>
	      		</div>
	     	 	<div class="modal-body">
	        		<form id="formRegistro" >
			      		<div class="form-group">
			      			<label>Nombres</label>
			        		<input type="text" class="form-control" name="txtNombre" placeholder="Nombres" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Usuario</label>
			        		<input type="text" class="form-control" name="txtUsuario" placeholder="Usuario" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Password</label>
			        		<input type="password" class="form-control" placeholder="Password" name="txtPassword" required="" />
			        		<input type="hidden" name="operacion" value="add"/>
			      		</div>
			      		<div class="form-group">
			      			<label>Rol</label>
			        		<select name="cmbRoles" class="form-control" style="width:100%;">
			        			<option value="1">Administrador</option>
			        			<option value="2">Cliente</option>
			        		</select>
			      		</div>
			      		<div class="clearfix"></div>
			    	</form>
	      		</div>
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
	        		<button type="button" id="btnSalvarUsuarioNuevo" class="btn btn-primary">Guardar Cambios</button>
	      		</div>	
	    	</div>
	  	</div>
	</div>
	
	<div id="editarUsuario" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
	  	<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
	        		</button>
	        		<h4 class="modal-title" id="myModalLabel">Editar Usuario</h4>
	      		</div>
	     	 	<div class="modal-body">
	        		<form id="formRegistroEdicion" >
			      		<div class="form-group">
			      			<label>Nombres</label>
			        		<input type="text" class="form-control" name="txtNombre" id="txtNombre" placeholder="Nombres" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Usuario</label>
			        		<input type="text" class="form-control" name="txtUsuario" id="txtUsuario" placeholder="Usuario" required="true" />
			      		</div>
			      		<div class="form-group">
			      			<label>Password</label>
			        		<input type="password" class="form-control" placeholder="Password" name="txtPassword" required="" />
			        		<input type="hidden" name="operacion" value="update"/>
			      		</div>
			      		<div class="form-group">
			      			<label>Rol</label>
			        		<select name="cmbRoles" id="cmbRoles" class="form-control" style="width:100%;">
			        			<option value="1">Administrador</option>
			        			<option value="2">Cliente</option>
			        		</select>
			      		</div>
			      		<div class="clearfix"></div>
			      		<input type="hidden" name="txtPasswordActual" id="txtPasswordActual">
	      				<input type="hidden" name="txtUsuarioId" id="txtUsuarioId">
			    	</form>
	      		</div>
	      		<div class="modal-footer">
	      			
	        		<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
	        		<button type="button" id="btnSalvarUsuarioEditar" class="btn btn-primary">Guardar Cambios</button>
	      		</div>	
	    	</div>
	  	</div>
	</div>
	
    <script type="text/javascript">
	    $(function(){
	    	$("#users").addClass("active");
	    	
	    	$("#tblaUsuarios").DataTable({
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
	    	
	    	/* Editar usuarios */
	    	$('#tblaUsuarios tbody').on("click", ".btnEditarUsuario", function(){
	    	    var x = $(this).attr('attrusuario');
	    	    $.ajax({
	    	        url   : '<%=request.getContextPath()%>/usuarios',
	    	        method: 'post',
	    	        data  : { idUsuario : x, operacion : "getDatos"},
	    	        dataType    : 'json',
	    	        success     : function(data){
	    	            $("#cmbRoles").val(data.rol); 
	    	            $("#cmbRoles").val(data.rol).change();                   
	    	            $("#txtNombre").val(data.nombres);
	    	            $("#txtUsuario").val(data.usuario);
	    	            $("#txtPasswordActual").val(data.password);
	    	            $("#txtUsuarioId").val(data.id);
 	                }
	    	    });
	    	});
	    	
	    	$('#tblaUsuarios tbody').on("click", ".btnEliminarUsuario", function(){
	    	    var x = $(this).attr('attrusuario');
	    	    swal({
	    	        title: '¿Está seguro de borrar el usuario?',
	    	        text: "¡Si no lo está puede cancelar la accíón!",
	    	        type: 'warning',
	    	        showCancelButton: true,
	    	        confirmButtonColor: '#3085d6',
	    	        cancelButtonColor: '#d33',
	    	        cancelButtonText: 'Cancelar',
	    	        confirmButtonText: 'Si, borrar usuario!'
	    	    },function(isConfirm) {
	    	        if (isConfirm) {
	    	        	$.ajax({
	    					url : '<%=request.getContextPath()%>/usuarios',
	    					type: 'post',
	    					data: { operacion : "delete", idUsuario : x},
	    	                dataType : 'json',
	    	                success:function(data){
	    	                	if(data.code == '1'){
	    	                		/*Registro insertado*/
	    							swal({
	    								title  : 'Usuario eliminado con exito!',
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
	    	
	    	$("#btnSalvarUsuarioNuevo").click(function(){
	    		$.ajax({
					url : '<%=request.getContextPath()%>/usuarios',
					type: 'post',
					data: $("#formRegistro").serialize(),
	                dataType : 'json',
	                success:function(data){
	                	if(data.code == '1'){
	                		/*Registro insertado*/
							swal({
								title  : 'Usuario guardado con exito!',
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
	    	
	    	
	    	$("#btnSalvarUsuarioEditar").click(function(){
	    		$.ajax({
					url : '<%=request.getContextPath()%>/usuarios',
					type: 'post',
					data: $("#formRegistroEdicion").serialize(),
	                dataType : 'json',
	                success:function(data){
	                	if(data.code == '1'){
	                		/*Registro insertado*/
							swal({
								title  : 'Usuario editado con exito!',
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
	    });
    </script>
  <jsp:include page="../includes/footer.jsp" />
  
       