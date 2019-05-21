<div class="col-md-3 left_col menu_fixed">
  <div class="left_col scroll-view">
    <div class="navbar nav_title" style="border: 0;">
  		<a href="<%=request.getContextPath() + "/dashboard"%>" class="site_title"><i class="fa fa-paw"></i> <span>Pedidos Menu!</span></a>
	</div>

	<div class="clearfix"></div>

	<!-- menu profile quick info -->
	<div class="profile clearfix">
	  <div class="profile_pic">
	    <img src="assets/images/img.jpg" alt="..." class="img-circle profile_img">
	  </div>
	  <div class="profile_info">
	    <span>Bienvenido,</span>
	    <h2>${usuario.getUsu_nombre_v()}</h2>
	  </div>
	  <div class="clearfix"></div>
	</div>
	<!-- /menu profile quick info -->

	<br />
	<!-- sidebar menu -->
	<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
	  <div class="menu_section">
	    <h3>General</h3>
	    <ul class="nav side-menu">                 
	      	<li id="dashboard"><a href="<%=request.getContextPath() + "/dashboard"%>"><i class="fa fa-desktop"></i> DashBoard </span></a>
	      	<li id="mens"><a  href="<%=request.getContextPath() + "/menus"%>"><i class="fa fa-paw"></i> Menus </span></a>
	      	<li id="users"><a href="<%=request.getContextPath() + "/usuarios"%>"><i class="fa fa-users"></i> Usuarios </span></a>
	      	<li><a  href="#"><i class="fa fa-file-o"></i> Reporte </span></a>
	    </ul>
	  </div>	
	</div>
	<!-- /sidebar menu -->            
  </div>
</div>