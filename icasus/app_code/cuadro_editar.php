<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: cuadro_editar.php
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin (jjmc@us.es)
//---------------------------------------------------------------------------------------------------
// Descripcion: Editar un cuadro de mandos existente
//---------------------------------------------------------------------------------------------------

if (isset($_REQUEST['id_cuadro']))
{  
	$id_cuadro = sanitize($_REQUEST['id_cuadro'],16);
  $cuadro = new cuadro();
  $cuadro->load("id = $id_cuadro");
  $smarty->assign('cuadro', $cuadro);	
  $smarty->assign('_nombre_pagina', 'Editando cuadro de mando');	
	$plantilla = 'cuadro_editar.tpl';
}
else
{
  header("Location: index.php?page=cuadro_listar");
}
?>
