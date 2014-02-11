<?php
//--------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: datos_rebiun.php
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
global $smarty;
global $usuario;
global $plantilla;

define('ENTIDAD_MADRE', 14);
define('MEDICIONES', '(1649,1648,1508,1474,1471,1515,1482,1541,1646,1647,1686)');
$entidades_autorizadas = array();

$entidad = new entidad();
// Para no perder la pista de la unidad actual
$entidad->load("id = 14");
$smarty->assign('entidad', $entidad);

$subentidades = $entidad->Find("id_madre = ". ENTIDAD_MADRE);

// Recorre las unidades que tiene asignadas el usuario para encontrar las que tiene con rol de responsable
foreach($usuario->entidades as $usuario_entidad)
{
  //Solamente entro en aquellas en las que es responsable 
  if($usuario_entidad->id_rol == 1 OR $usuario_entidad->id_rol == 2)
  {
    //Recorre las subunidades de la unidad ENTIDAD_MADRE
    foreach($subentidades as $subentidad)
    {
      //print_r($usuario_entidad->id_entidad . "-" . $subentidad->id . "\r");
      // Comprueba si el usuario es miembro de la subunidad actual 
      if($usuario_entidad->id_entidad == $subentidad->id)
      {
        // Añade la subunidad actual al array de entidades autorizadas
        $entidades_autorizadas[] = $subentidad;
        $valor = new valor();
        $valores = $valor->Find_joined_indicador("id_entidad = $subentidad->id AND id_medicion IN " . MEDICIONES);
        $subentidad->valores = $valores;
      }
    }
  }
}

if (count($entidades_autorizadas) > 0)
{
  $smarty->assign("id_usuario", $usuario->id);
  $smarty->assign("entidades", $entidades_autorizadas);
  $smarty->assign("valores", $valores);
  $smarty->assign("_nombre_pagina", "Recogida Datos Rebiun");
  $plantilla = "datos_rebiun.tpl";
}
else
{
  $error = "No tiene permisos para acceder a este módulo de la aplicación";
  header("location:index.php?page=error&error=$error");
}
?>
