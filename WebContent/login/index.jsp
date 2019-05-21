<jsp:include page="../includes/head.jsp" />

 <body class="login">
    <div>
      	<a class="hiddenanchor" id="signup"></a>
      	<a class="hiddenanchor" id="signin"></a>

      	<div class="login_wrapper">
        	<div class="animate form login_form">
          		<section class="login_content">
            		<form action="<%=request.getContextPath() + "/login"%>" method="post" id="formLogin">
            			<h1>Formulario de Ingreso</h1>
		              	<div>
		                	<input type="text" name="txtUserName" class="form-control" placeholder="Usuario" required="" />
		              	</div>
		              	<div>
		                	<input type="password" name="txtPassword" class="form-control" placeholder="Password" required="" />
		              	</div>
              			<div>
              				<input type="hidden" name="ruta" value="${ruta}" />
                			<button class="btn btn-default submit" type="submit">Ingresar</button>
                			<a class="reset_pass" href="/prueba_ua/homepage">Regresar al inicio</a>
              			</div>
              			<div class="clearfix"></div>
              			
              			<div class="separator">
			                <p class="change_link">Nuevo en el sitio?
			                  	<a href="#signup" class="to_register"> Crea una cuenta </a>
			                </p>
	                		<div class="clearfix"></div>
	                		<br />
	                		<div>
	                  			<h1><i class="fa fa-paw"></i> Pedidos Menu!</h1>
	                		</div>
	              		</div>
            		</form>
          		</section>
        	</div>

			<div id="register" class="animate form registration_form">
			  	<section class="login_content">
			    	<form id="formRegistro" >
			      		<h1>Nueva cuenta</h1>
			      		<div>
			        		<input type="text" class="form-control" name="txtNombre" placeholder="Nombres" required="true" />
			      		</div>
			      		<div>
			        		<input type="text" class="form-control" name="txtUsuario" placeholder="Usuario" required="true" />
			      		</div>
			      		<div>
			        		<input type="password" class="form-control" placeholder="Password" name="txtPassword" required="" />
			        		<input type="hidden" name="operacion" value="add"/>
			        		<input type="hidden" name="cmbRoles" value="2" />
			      		</div>
			      		<div>
			        		<button class="btn btn-default submit" id="btnRegistrar" type="button">Enviar</button>
			      		</div>
			      		<div class="clearfix"></div>
			      		<div class="separator">
			        		<p class="change_link">Ya tienes una cuenta ?
			          			<a href="#signin" class="to_register"> Ingresa </a>
			        		</p>
			        		<div class="clearfix"></div>
			        		<br />
			        		<div>
			          			<h1><i class="fa fa-paw"></i> Pedidos Menu!</h1>
			        		</div>
			      		</div>
			    	</form>
			  </section>
       		</div>
    	</div>
	</div>
	<!-- SweetAlert -->
    <script src="assets/vendors/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#btnRegistrar").click(function(){
				//Se crean un array con los datos a enviar, apartir del formulario 
				//var formData = new FormData($("#formRegistro")[0]);
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
		});
	</script>
  </body>
</html>
