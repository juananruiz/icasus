<?php

//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus (http://wiki.us.es/icasus/)
// Archivo: panel_nuevo.php
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin Corredera (jjmc@us.es),
// Joaquín Valonero Zaera (tecnibus1@us.es)
//---------------------------------------------------------------------------------------------------
// Descripcion: Controlador principal para generar paneles
//---------------------------------------------------------------------------------------------------

if (filter_has_var(INPUT_GET, 'id_cuadro') && filter_has_var(INPUT_GET, 'id_entidad'))
{
    $id_cuadro = filter_input(INPUT_GET, 'id_cuadro', FILTER_SANITIZE_NUMBER_INT);
    $id_entidad = filter_input(INPUT_GET, 'id_entidad', FILTER_SANITIZE_NUMBER_INT);
    $smarty->assign('id_entidad', $id_entidad);
    $cuadro = new Cuadro();
    $cuadro->load("id=$id_cuadro");
    $smarty->assign('cuadro', $cuadro);
    $smarty->assign('_javascript', array('panel_nuevo'));
    $smarty->assign('_nombre_pagina', TXT_PANEL_NUEVO);
    $plantilla = "panel_nuevo.tpl";
}
else
{
    $error = ERR_PARAM;
    header("location:index.php?page=error&error=$error");
}
