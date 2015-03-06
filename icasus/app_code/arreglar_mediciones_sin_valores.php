<?php

//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: 
// Tipo: controlador
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin Corredera (jjmc@us.es)
//---------------------------------------------------------------------------------------------------
// Este script se utiliza para crear los valores de las mediciones que se hayan quedado sin descendencia
// por no tener las subunidades asignadas en su momento 
//---------------------------------------------------------------------------------------------------
// Normalmente esta página está desactivada redirigiendo a inicio
header("location: index.php");

$medicion = new Medicion();
$db = $medicion->DB();

$query = "select id, id_indicador from mediciones where id not in (select id_medicion from valores) order by id_indicador;";
$huerfanitos = $db->getAll($query);
foreach ($huerfanitos as $huerfanito) {
    $indicador_subentidad = new Indicador_subunidad();
    $subentidades = $indicador_subentidad->Find("id_indicador = " . $huerfanito["id_indicador"]);
    foreach ($subentidades as $subentidad) {
        $valor = new Valor();
        $valor->id_medicion = $huerfanito["id"];
        $valor->id_entidad = $subentidad->id_entidad;
        $valor->save();
    }
}