<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus (http://wiki.us.es/icasus/)
// Archivo: valor_grabar.php
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesús Martín (jjmc@us.es) 
//---------------------------------------------------------------------------------------------------
// Descripcion: Graba en la base de dato el nuevo valor con los datos que vienen del formulario 
//---------------------------------------------------------------------------------------------------

global $smarty;
global $usuario;
global $plantilla;

//$valor = sanitize($_GET["valor"],2);
//$id_valor = sanitize($_GET["id2"],2);
$valor = sanitize($_POST["valor"],2);
$id_valor = sanitize($_POST["id2"],2);

$v = new valor();
$v->load("id = $id_valor");

if ($v->puede_grabarse($v->id,$usuario->id))
{
echo $valor.$id_valor;
	$v->id_usuario = $usuario->id;
	$v->valor = $valor;
	$v->fecha_recogida = date("Y-m-d");
	$v->save();
}
?>
