<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus (http://wiki.us.es/icasus/)
// Archivo: indicador_copiar.php
// Tipo: controlador
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin (jjmc@us.es)
//---------------------------------------------------------------------------------------------------
// Descripcion: Copia uno o mas indicadores desde el catalogo de indicadores
//---------------------------------------------------------------------------------------------------

global $smarty;
global $basedatos;
global $plantilla;

$smarty->assign('_javascript' , array('ordenatabla'));

if (isset($_REQUEST['id_entidad']) && $_REQUEST['id_entidad'] > 1)
{
	$id_entidad = sanitize($_REQUEST['id_entidad'],16);
	$smarty->assign('id_entidad', $id_entidad);
	// Si vienen indicadores del formulario los asignamos a la entidad
	if (isset($_POST['indicadores']))
	{
		$contador = 0;
		foreach ($_POST['indicadores'] as $id_indicador)
		{
			$id_indicador = sanitize($id_indicador,16);
			//echo 'copiando'.$id_entidad;
			$indicador = new indicador($basedatos);
			if ($indicador->copiar($id_indicador,$id_entidad))
			{
				$contador ++;
			}
		}
		$smarty->assign('aviso', "Se han copiado $contador indicadores.");
	}
	// Si no vienen indicadores o hemos terminado de grabar mostramos el formulario con el listado
	$entidad = new entidad($basedatos);
    //Obtengo los datos de la entidad actual
    $datos = $entidad->obtener_datos($id_entidad);
	// Cargo la entidad padre para obtener sus indicadores
    $entidad->id_entidad = $datos['id_padre'];
	$indicadores = $entidad->listar_indicadores();
	$smarty->assign('indicadores', $indicadores);
	$smarty->assign('_nombre_pagina' , 'Copiar indicadores'); 
	$plantilla = 'indicador_copiar.tpl';
}
else
{
	$smarty->assign('error', 'Par&aacute;metros incorrectos');
	$plantilla = 'error.tpl';
}
?>
