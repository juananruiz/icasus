<?php

//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: proceso_listar.php
//---------------------------------------------------------------------------------------------------
// Descripcion: Lista los procesos definidos en esta unidad
//---------------------------------------------------------------------------------------------------
global $smarty;
global $plantilla;

//if (isset($_REQUEST["id_entidad"]))
if (filter_has_var(INPUT_GET, 'id_entidad'))
{
//  $id_entidad = sanitize($_REQUEST["id_entidad"], INT);
    $id_entidad = filter_input(INPUT_GET, 'id_entidad', FILTER_SANITIZE_NUMBER_INT);
    $entidad = new Entidad();
    $entidad->load("id =  $id_entidad");
    $smarty->assign('entidad', $entidad);

    $proceso = new Proceso();
    $procesos = $proceso->Find_joined("id_entidad = $id_entidad");
    $smarty->assign('procesos', $procesos);

    $smarty->assign('_javascript', array('ordenatabla', 'proceso_borrar'));
    $smarty->assign('_nombre_pagina', TXT_PROC_LIST . " - " . $entidad->nombre);
    $plantilla = 'proceso_listar.tpl';
}
else
{
    $error = ERR_PARAM;
    header("location:index.php?page=entidad_listar&error=$error");
}

