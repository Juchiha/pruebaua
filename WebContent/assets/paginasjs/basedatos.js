var indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;;
var version = 2;
BaseDatos = {
	crearBaseDatos: function(){
		db = indexedDB.open("prueba_ua", version);
        db.onupgradeneeded = function (e) {
            active = db.result;
            object = active.createObjectStore("pedidos", { keyPath : 'id', autoIncrement : true });
        };

        db.onsuccess = function (e) {
            console.log('Base de datos cargada correctamente');

        };

        db.onerror = function (e)  {
        	 console.log('Error cargando la base de datos');
        };
	},
	
	insertarDatos:function(anyadir){
		var db;
		var request = indexedDB.open("prueba_ua", version);  
		request.onsuccess = function (e) {
			db = request.result;
			var transaction = db.transaction(['pedidos'], 'readwrite');
			var objStore = transaction.objectStore('pedidos');
			var Newrequest = objStore.put(anyadir);
			Newrequest.onsuccess = function(e) {
		    	console.log("Registro guardado");
		    	alertify.success("Elemento añadido a su pedido");
		    };
		    Newrequest.onerror = function(e){
		    	console.log('Error insertando en la base de datos');
		    	alertify.error("No hemos podido agregar este elemento al carrito");
		    };
        };
		
	},
	
	leerDatos:function(selector){
		var db;
		var request = indexedDB.open("prueba_ua", version);  
		request.onsuccess = function (e) {
			db = request.result;
			var transaction = db.transaction(['pedidos'], 'readwrite');
			var objStore = transaction.objectStore('pedidos');
			var elements = [];
			objStore.openCursor().onsuccess = function (e) {

                var result = e.target.result;

                if (result === null) {
                    return;
                }

                elements.push(result.value);
                result.continue();
            };
            
            transaction.oncomplete = function () {
                var outerHTML = '';
                var i = 1;
                var total = 0;
                for (var key in elements) {
                    outerHTML += '\n\
                    <tr>\n\
                    	<td>'+ i +'</td>\n\
                        <td>' + elements[key].nombre + '</td>\n\
                        <td>$ ' + BaseDatos.addCommas(elements[key].valor) + '</td>\n\
                        <td style="width:10%;text-align:center;">\n\
                            <button type="button" class="btn btn-sm btn-danger borrarDatos" valorId="'+ elements[key].id + '"><i class="fa fa-trash-o"></i></button>\n\
                        </td>\n\
                        <input type="hidden" name="idMenu_'+i+'" value="'+ elements[key].id + '">\n\
                        <input type="hidden" name="valorMenu_'+i+'" value="'+ elements[key].valor + '">\n\
                    </tr>';
                    total += Number(elements[key].valor);
                    i++;
                }
                $("#cantidadProductos").val(i);
                outerHTML += '\n\
                    <tr>\n\
                        <td colspan="2" style="text-align:right;">Total</td>\n\
                        <td>$ ' + BaseDatos.addCommas(total) + '</td>\n\
                        <td style="width:10%;text-align:center;"><button type="button" class="btn btn-sm btn-primary" id="btnConfirmaDatos"><i class="fa fa-paw"></i>Confirmar</button></td>\n\
                    </tr>';
                elements = [];
                selector.html(outerHTML);
                $(".borrarDatos").click(function(){
                	var id = $(this).attr("valorId");
                	BaseDatos.borrarDatos(selector, id);
                });
                
                $("#btnConfirmaDatos").click(function(){
                	$.ajax({
    					url : 'carrito',
    					type: 'post',
    					data: $("#guardarCarrito").serialize(),
    	                dataType : 'json',
    	                success:function(data){
    	                	if(data.code == "1"){
    	                		alertify.success("pedido guardado con exito");
    	                		BaseDatos.borrarBaseDatos();
    	                		window.location.reload(true);
    	                	}else{
    	                		alertify.error("No se pudo guardar el pedido");
    	                	}
    	                }
                	});
                });
            };



        };
	},
	
	borrarDatos:function(selector, id){
		var db;
		var request = indexedDB.open("prueba_ua", version);  
		request.onsuccess = function (e) {
			db = request.result;
			var transaction = db.transaction(['pedidos'], 'readwrite');
			var objStore = transaction.objectStore('pedidos');
			var Newrequest = objStore.delete( parseInt( id ) );
			Newrequest.onsuccess = function(e) {
		    	console.log("Registro Borrado");
		    	alertify.success("Elemento Borrado de su pedido");
		    	BaseDatos.leerDatos(selector);
		    };
		    Newrequest.onerror = function(e){
		    	console.log('Error iBorrando en la base de datos');
		    	alertify.error("No hemos podido borrar este elemento del carrito");
		    };
		}
	},
	
	borrarBaseDatos:function(){
		var req = indexedDB.deleteDatabase("prueba_ua");
		req.onsuccess = function () {
		    console.log("Deleted database successfully");
		};
		req.onerror = function () {
		    console.log("Couldn't delete database");
		};
		req.onblocked = function () {
		    console.log("Couldn't delete database due to the operation being blocked");
		};
	},
	
	addCommas:function (nStr)
	{
	    nStr += '';
	    x = nStr.split('.');
	    x1 = x[0];
	    x2 = x.length > 1 ? '.' + x[1] : '';
	    var rgx = /(\d+)(\d{3})/;
	    while (rgx.test(x1)) {
	        x1 = x1.replace(rgx, '$1' + '.' + '$2');
	    }
	    return x1 + x2;
	}
}