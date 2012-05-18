<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus (http://wiki.us.es/icasus/)
// Archivo: clase_entidad.php
// Tipo: definicion de clase
// Desarrolladores: Juanan Ruiz (juanan@us.es)
//---------------------------------------------------------------------------------------------------
// Descripcion: gestiona las entidades 
//---------------------------------------------------------------------------------------------------
class entidad {
   //Propiedades de la clase
   var $id_entidad;
   var $datos = array();
   var $database; //objeto de conexion a la base de datos
   var $error; //propiedad de uso interno para almacenar los errores
   
   // Metodos de la clase
   function entidad($database) 
   {
      $this->database = $database;
   }

      
   // Obtiene los datos de la entidad 
   function obtener_datos($id_entidad) 
   {
	   $consulta = "SELECT e.id_entidad as id_entidad, e.codigo as codigo, e.nombre as nombre, e.web as web,
		   e.id_padre as id_padre, e.objeto as objeto, e.frecuencia as frecuencia, e.inicio as inicio, e.fin as fin, 
		   p.codigo as codigo_padre, p.nombre as padre  
		   FROM entidad e INNER JOIN entidad p ON e.id_padre = p.id_entidad WHERE e.id_entidad= $id_entidad";
      $this->database->ejecutar_consulta($consulta);
      if ($this->database->filas_implicadas > 0) 
      {
		  $this->database->obtener_fila();
		  $this->id_entidad = $id_entidad;
		  $this->datos = $this->database->fila;
          return $this->datos;
      }
      else 
      {
		  $this->error = "No existe ninguna entidad con el identificador $id_entidad.";
	      return FALSE;
	  }
   }
   
   function crear ($nombre,$codigo,$web,$id_padre,$ict,$objeto,$frecuencia) {
      //Primero compruebo que no exista otra entidad con el mismo nombre en la base de datos
      $consulta = "SELECT * FROM entidad WHERE nombre = '" . $nombre  . "'";
      $this->database->ejecutar_consulta($consulta);
      if ($this->database->filas_implicadas == 0) {
         //Si la consulta no devuelve ninguna fila el nombre no existe en la base de datos y podemos grabar la nueva entidad
	$inicio=time();   
	// Poner valor 0 a $ict si ls herencia es NULL.
	if ($ict != 1){$ict = 0;} 
	// los campos objeto, frecuencia, inicio y fin  se están usando para los grupos de trabajo.
	$consulta = "INSERT INTO entidad (nombre, codigo, web, id_padre, ict, objeto, frecuencia, inicio) VALUES ('$nombre', '$codigo', '$web' , $id_padre, $ict,'$objeto','$frecuencia','$inicio')";
	    $this->database->ejecutar_consulta($consulta);
	    $this->id_entidad = $this->database->obtener_ultima_id();
	    if ($this->obtener_datos($this->id_entidad)) {
	        return $this->id_entidad;
            }
	    else {
	        $this->error = "Error desconocido. No se ha podido grabar la entidad en la base de datos";
	        return FALSE;
            }
	 	 }
      else {
         //Si la consulta devuelve alguna fila el nombre ya existe y no grabamos
         $this->error = "El nombre de entidad '" . $nombre  . "' ya existe en el sistema";
	    return FALSE;
         }
      }	   
   
	function editar($id_entidad, $id_padre, $nombre, $web, $codigo,$objeto,$frecuencia)
	{ 
		$consulta = "UPDATE entidad SET id_padre = $id_padre, nombre = '$nombre', 
			web = '$web', codigo = '$codigo', objeto= '$objeto', frecuencia = '$frecuencia' 
			WHERE id_entidad = $id_entidad";
		$this->database->ejecutar_consulta($consulta);
		return true;
	}
   
	//Devuelve una lista de entidades en base a un $criterio
	function listar($criterio = "")
	{
		$entidades = array();
		$consulta = "SELECT * FROM entidad $criterio ORDER BY nombre";
		$this->database->ejecutar_consulta($consulta);
		while ($this->database->obtener_fila()) 
		{
			$entidades[] = $this->database->fila;
		}   
		return $entidades;
	}

	function listar_indicadores()
	{
      //Devuelve los indicadores existentes para esta entidad
      $consulta = "SELECT id_indicador, i.codigo as codigo, i.nombre as nombre_indicador, descripcion, 
		formulacion, i.id_responsable, i.id_proceso as id_proceso, p.nombre as proceso, p.codigo as codigo_proceso, u.nombre as nombre_responsable, 
		u.apellidos as apellidos_responsable
		FROM indicador i INNER JOIN usuario u ON i.id_responsable = u.id_usuario 
		INNER JOIN proceso p ON i.id_proceso = p.id_proceso
		WHERE i.id_entidad=" . $this->id_entidad . " ORDER BY nombre_indicador ASC";		 
      
      //Devuelve un array con las filas devueltas por la base de datos
      $this->database->ejecutar_consulta($consulta);
	  while ($this->database->obtener_fila()) 
	  {
		$lista_indicadores[] = $this->database->fila;
	  }
	  if (isset($lista_indicadores))
	  {
		  return $lista_indicadores;
	  }
	  else
	  {
		  return false;
	  }
	}

	// Devuelve una lista resumida de indicadores para mostrar una barra desplegable
	function barra_indicadores()
	{
		$consulta = "SELECT id_indicador, CONCAT(codigo, ' ', left(nombre,30)) as nombre FROM indicador 
			WHERE id_entidad = $this->id_entidad ORDER BY codigo, nombre";

		$this->database->ejecutar_consulta($consulta);
		while ($this->database->obtener_fila()) 
		{
			$barra_indicadores[] = $this->database->fila;
			//$i = $this->database->fila;
			//$barra_indicadores[$i['id_indicador']] = $i['nombre'];			
		}
		
		if (isset($barra_indicadores))
		{
			return $barra_indicadores;
		}
		else
		{
			return false;
		}

	}	
	
	//Devuelve los indicadores de la entidad junto con los 12 ultimos valores
	function cmi()
	{
      $consulta = "SELECT i.id_indicador as id_indicador, i.nombre as nombre_indicador, descripcion, 
		  umbral, objetivo, formulacion, i.id_responsable as id_responsable, u.nombre as nombre_responsable, 
		  u.apellidos as apellidos_responsable 
		  FROM indicador i INNER JOIN usuario u ON i.id_responsable = u.id_usuario 
		  WHERE i.id_entidad=" . $this->id_entidad . " ORDER BY nombre_indicador ASC";		 
      
      //Devuelve un array con las filas devueltas por la base de datos
	  $lista_indicadores = array();
      $this->database->ejecutar_consulta($consulta);
	  while ($this->database->obtener_fila()) 
	  {
		  $db = new basedatos(IC_DB_HOST,IC_DB_LOGIN,IC_DB_CLAVE,IC_DB_DATABASE); 
		  $consulta = "SELECT fecha_recogida ,valor FROM valor WHERE id_indicador="
			  .$this->database->fila['id_indicador']." ORDER BY fecha_recogida desc LIMIT 12";
		  $db->ejecutar_consulta($consulta);	
		  $fechas = array();
		  $valores = array();
		  for ($i=0; $i<12; $i++)
		  {
			  $db->obtener_fila();
			  $fechas[$i] = $db->fila['fecha_recogida'];
			  $valores[$i] = $db->fila['valor'];
		  }
		  $fechas =	array_reverse($fechas);		  
		  $valores = array_reverse($valores);		  
		  array_push($this->database->fila,$fechas,$valores);
		  array_push($lista_indicadores, $this->database->fila);
	  }
	  if (isset($lista_indicadores))
	  {
		  return $lista_indicadores;
	  }
	  else
	  {
		  return false;
	  }
   }
	
   // Devuelve la lista de usuarios de la entidad 
   function listar_usuarios($id_entidad) 
   {
      $lista_usuarios = array();
      $consulta = "SELECT *, u.id_usuario as id_usuario, u.nombre as nombre, u.correo as correo, r.nombre as rol
		  FROM usuario u INNER JOIN usuario_entidad ue ON u.id_usuario = ue.id_usuario  
		  INNER JOIN rol r ON r.id_rol = ue.id_rol
		  WHERE ue.id_entidad = " . $id_entidad ." ORDER BY u.nombre";

      $this->database->ejecutar_consulta($consulta);
	  while ($this->database->obtener_fila()) 
	  {
	      array_push($lista_usuarios, $this->database->fila);
	  }   
      return $lista_usuarios;
      }
      
	// Asigna un nuevo usuario a una entidad
	function asignar_usuario($id_entidad, $id_usuario, $id_rol)
	{
		$consulta = "SELECT * FROM usuario_entidad WHERE id_usuario=$id_usuario AND id_entidad=$id_entidad";
		$this->database->ejecutar_consulta($consulta);
		if ($this->database->filas_implicadas == 0)
		{
			$consulta = "INSERT INTO usuario_entidad (id_usuario, id_entidad, id_rol) 
						VALUES ($id_usuario,$id_entidad,$id_rol)";
			if ($this->database->ejecutar_consulta($consulta))
			{
				return true;
			}
			else
			{
				$this->error = "Error desconocido al insertar al usuario en la entidad $id_entidad";
			}
		}
		else
		{
			$this->error = 'El usuario ya pertenecía a esta entidad';
			return false;
		}
	}
	
	// Desasigna un usuario de una entidad 
	function desasignar_usuario($id_entidad, $id_usuario)
	{
		$consulta = "DELETE FROM usuario_entidad  
					WHERE id_usuario = $id_usuario AND id_entidad = $id_entidad";
		if ($this->database->ejecutar_consulta($consulta))
		{
			/*
			//Eliminamos los permisos concedidos a este usuario para esta entidad
			$consulta = "DELETE FROM permiso WHERE id_usuario=$id_usuario AND id_objeto=$id_entidad";
			$this->database->ejecutar_consulta($consulta);
			 */
			return true;
		}
		else
		{
			$this->error = 'El usuario no pertenecía a esta entidad';
			return false;
		}
	}
	
   // Lista los roles disponibles en el sistema
   function listar_roles()
   {
		$consulta = "SELECT * FROM rol ORDER BY orden DESC";
		$this->database->ejecutar_consulta($consulta);
		while ($this->database->obtener_fila()) 
		{
			$roles[] = $this->database->fila;
	    }   
      return $roles;

   }
   
   // Devuelve la lista de procesos asociados a esta entidad y a la superior
   function listar_procesos($id_entidad) 
   {
      $procesos = array();
	  $consulta = "SELECT id_proceso, p.codigo as codigo, p.nombre as nombre, 
		   u.nombre as nombre_propietario, u.apellidos as apellidos_propietario 
		   FROM proceso p INNER JOIN usuario u ON p.id_propietario = u.id_usuario
		   INNER JOIN entidad e ON p.id_entidad = e.id_entidad 
		   WHERE p.id_entidad=$id_entidad OR e.id_padre=$id_entidad ORDER BY p.codigo";

      $this->database->ejecutar_consulta($consulta);
	  while ($this->database->obtener_fila()) 
	  {
	      $procesos[] = $this->database->fila;
	  }   
      return $procesos;
   }
      
    // Lista indicadores de subentidades
    function indicadores_subentidad($id_entidad)
    {
    $consulta = "SELECT entidad.nombre as nombre_entidad, proceso.nombre as proceso, proceso.id_proceso as id_proceso, 
        indicador.id_indicador as id_interno, indicador.codigo as codigo, indicador.nombre as nombre_indicador, 
        descripcion, formulacion, periodicidad, fuente, objetivo 
        FROM indicador INNER JOIN entidad on indicador.id_entidad = entidad.id_entidad 
        INNER JOIN proceso on indicador.id_proceso = proceso.id_proceso 
        WHERE entidad.id_padre=$id_entidad";

      $this->database->ejecutar_consulta($consulta);
	  while ($this->database->obtener_fila()) 
	  {
	      $indicadores[] = $this->database->fila;
	  }   
      return $indicadores;
    }
}
?>
