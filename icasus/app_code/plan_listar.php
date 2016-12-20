<?php

//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus <https://gestionproyectos.us.es/projects/r2h2-icasus/>
// Archivo: plan_listar.php
// Tipo: controlador
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin Corredera (jjmc@us.es),
// Joaquín Valonero Zaera (tecnibus1@us.es)
//---------------------------------------------------------------------------------------------------
// Descripcion: Lista los planes estratégicos de una Unidad
//---------------------------------------------------------------------------------------------------

global $smarty;
global $plantilla;
global $usuario;

if (filter_has_var(INPUT_GET, 'id_entidad'))
{
    $id_entidad = filter_input(INPUT_GET, 'id_entidad', FILTER_SANITIZE_NUMBER_INT);
    $entidad = new Entidad();
    $entidad->load("id =  $id_entidad");
    $smarty->assign('entidad', $entidad);

    //Planes de la Unidad
    $smarty->assign('planes', $planes);

    //Objetivos operacionales bajo la responsabilidad del usuario en la Unidad
    $objop = new ObjetivoOperacional();
    $objops = $objop->Find_joined("id_responsable = $usuario->id");
    $objops_propios = array();
    foreach ($objops as $objop)
    {
        if ($objop->objest->linea->plan->id_entidad == $id_entidad)
        {
            array_push($objops_propios, $objop);
        }
    }
    $smarty->assign('objops_propios', $objops_propios);

    //Años de ejecución de los objetivos operacionales
    $ejecucion = new Ejecucion();
    $objops_anyos = array();
    foreach ($objops_propios as $obj)
    {
        $objops_anyos[$obj->id] = array();
        $ejecuciones = $ejecucion->Find("id_objop=$obj->id order by anyo");
        foreach ($ejecuciones as $ejec)
        {
            if ($ejec->activo)
            {
                array_push($objops_anyos[$obj->id], $ejec->anyo);
            }
        }
    }
    $smarty->assign('objops_anyos', $objops_anyos);

    //Unidades de los objetivos operacionales
    $objop_unidad = new ObjetivoUnidad();
    $objops_unids = array();
    foreach ($objops_propios as $obj)
    {
        $objops_unids[$obj->id] = $objop_unidad->Find("id_objop=$obj->id");
    }
    $smarty->assign('objops_unids', $objops_unids);

    $smarty->assign('_javascript', array('plan_listar'));
    $smarty->assign('_nombre_pagina', FIELD_PLANES . ": " . $entidad->nombre);
    $plantilla = 'plan_listar.tpl';
}
else
{
    $error = ERR_PARAM;
    header("location:index.php?page=error&error=$error");
}
