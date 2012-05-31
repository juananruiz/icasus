<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus
// Archivo: class/usuario.php
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin(jjmc@us.es
//---------------------------------------------------------------------------------------------------
// Descripcion: gestiona los usuarios (usa active record)
//---------------------------------------------------------------------------------------------------
class usuario extends ADOdb_Active_Record
{
  //Propiedades de la clase
	var $_table = 'usuario';
	var $entidades = array();
  var $grupos = array();

  function load_joined($condicion)
  {
    if ($this->load($condicion))
    {
        $usuario_entidad = new usuario_entidad();
        $this->entidades = $usuario_entidad->Find_entidades("id_usuario = $this->id");
        return true;
    }
    else
    {
        return false;
    }
  }

  //Devuelve las entidades a las que pertenece el usuario con sus respectivas subentidades
  function entidades()
  {
    $entidades = $usuario_entidad->Find_entidades("id_usuario = $this->id");
  } 
}
?>
