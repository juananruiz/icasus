<?php

//---------------------------------------------------------------------------------------------------
//  Proyecto: Icasus 
//  Archivo: api_privada.php
//---------------------------------------------------------------------------------------------------
//  Permite añadir datos al sistema desde una url
//---------------------------------------------------------------------------------------------------
// Para limpiar y asegurar la entrada de datos
require_once('../../cascara_core/function/sanitize.php');
// Conexión a datos
require_once('../app_code/app_config.php');

@mysql_connect(IC_DB_HOST, IC_DB_LOGIN, IC_DB_CLAVE);


if (mysql_select_db(IC_DB_DATABASE))
{
    // Capturamos y procesamos los datos de la petición
//  if (isset($_REQUEST['metodo'], $_REQUEST['apikey']))
    if (filter_has_var(INPUT_GET, 'metodo') && filter_has_var(INPUT_GET, 'apikey'))
    {
//    $metodo = sanitize($_REQUEST['metodo'], PARANOID);
        $metodo = filter_input(INPUT_GET, 'metodo', FILTER_SANITIZE_STRING);
        //$apikey = sanitize($_REQUEST['apikey'], PARANOID);

        if (function_exists($metodo))
        {
//      foreach ($_REQUEST as $variable => $valor)
            foreach (filter_input_array(INPUT_GET) as $variable => $valor)
            {
                if (!empty($valor))
                {
                    $$variable = sanitize($valor, SQL);
                }
            }
            /*
              $id_indicador = sanitize($_REQUEST['id_indicador'],INT);
              $periodo_inicio = sanitize($_REQUEST['periodo_inicio'],SQL);
              $periodo_fin = sanitize($_REQUEST['periodo_fin'],SQL);
              $etiqueta = sanitize($_REQUEST['etiqueta'],SQL);
              $valor = sanitize($_REQUEST['valor'],SQL);

              $metodo($id_indicador, $fecha_inicio, $fecha_fin);
             */
        }
        else
        {
            echo MSG_NO_MET_SOL;
        }
    }
}
else
{
    echo ERR_CON_BD;
}

//------------------------------------------ 
//  Métodos 
//------------------------------------------

function graba_medicion_con_valor($id_indicador, $periodo_inicio, $periodo_fin, $etiqueta, $valor)
{
    global $metodo,$adodb,$medicion_id;
    
    if (isset($id_indicador, $periodo_inicio, $periodo_fin, $etiqueta, $valor))
    {
        //begin transaction
        $query = "INSERT INTO mediciones (id_indicador, etiqueta, periodo_inicio, periodo_fin) VALUES ($id_indicador, '$etiqueta', $periodo_inicio, $periodo_fin);";
//        $adodb->Execute();
        $adodb->Execute($query);
        $medicion_id = $adodb->getLastID();
//        $query = "";
        //end transaction
    }
    else
    {
        echo MSG_FALTAN_PARAM_MET . ': ' . $metodo;
    }
}

/*
// Devuelve los indicadores asociados a un panel de un cuadro de mando
// Se utiliza en cuadro_mostrar
function get_indicadores_panel($id)
{
  $query = "SELECT indicadores.id, indicadores.codigo, indicadores.nombre, panel_indicadores.id_entidad, panel_indicadores.id_serietipo
  FROM indicadores 
  INNER JOIN panel_indicadores ON indicadores.id = panel_indicadores.id_indicador 
  WHERE panel_indicadores.id_panel = $id";

  $resultado = mysql_query($query);
  while ($registro = mysql_fetch_assoc($resultado))
  {
    $datos[] = $registro;
  }
  $datos = json_encode($datos);
  echo $datos;
}

// Devuelves las etiquetas de las mediciones existentes para este indicador por ordenadas por su fecha de inicio
// Se utiliza en consulta_avanzada
function get_mediciones_indicador($id)
{
  $query = "SELECT mediciones.etiqueta
            FROM mediciones INNER JOIN indicadores 
            ON indicadores.id = mediciones.id_indicador
            WHERE mediciones.id_indicador = $id 
            ORDER BY mediciones.periodo_inicio"; 
  $resultado = mysql_query($query);
  while ($registro = mysql_fetch_assoc($resultado))
  {
    $datos[] = $registro;
  }
  $datos = json_encode($datos);
  echo $datos;
}

// Devuelve una lista de subunidades asosciadas a la medición de un indicador
// Se utiliza en consulta_avanzada
function get_subunidades_indicador($id)
{
  $query = "SELECT entidades.id, entidades.etiqueta, entidades.nombre 
            FROM entidades INNER JOIN indicadores_subunidades ON entidades.id = indicadores_subunidades.id_entidad
            WHERE indicadores_subunidades.id_indicador = $id 
            ORDER BY entidades.etiqueta"; 
  $resultado = mysql_query($query);
  while ($registro = mysql_fetch_assoc($resultado))
  {
    $datos[] = $registro;
  }
  $datos = json_encode($datos);
  echo $datos;
}

// Devuleve todos los valores recogidos para un indicador incluyendo los recogidos a nivel de subunidad (cuando exista)
// También devuelve los totales de dichos valores en función del operador definido en el indicador
// Se utiliza en consulta_avanzada
function get_valores_indicador($id, $fecha_inicio = 0, $fecha_fin = 0)
{
  $query = "SELECT tipo_agregacion.operador as operador FROM tipo_agregacion
            INNER JOIN indicadores ON tipo_agregacion.id = indicadores.id_tipo_agregacion
            WHERE indicadores.id = $id";
  if ($resultado = mysql_query($query))
  {
    if ($registro = mysql_fetch_assoc($resultado))
    {
      $operador = $registro['operador'];
    }
    else
    {
      $operador = 'SUM';
    }
  }
  else
  {
    $operador = 'SUM';
  }

  //He quitado valores.observaciones porque da un molesto error en javascript cuando el contenido es null (casi siempre)
  //$query = "SELECT mediciones.etiqueta as medicion, entidades.etiqueta as unidad, entidades.id as id_unidad, valores.valor, valores.observaciones 
  $query = "SELECT mediciones.id as id_medicion, mediciones.etiqueta as medicion, entidades.etiqueta as unidad, entidades.id as id_unidad, valores.valor
            FROM mediciones INNER JOIN valores ON mediciones.id = valores.id_medicion 
            INNER JOIN entidades ON entidades.id = valores.id_entidad
            WHERE mediciones.id_indicador = $id AND valor IS NOT NULL"; 
  if ($fecha_inicio > 0)
  {
    $query .= " AND mediciones.periodo_inicio >= '$fecha_inicio'";
  }
  if ($fecha_fin > 0)
  {
    $query .= " AND mediciones.periodo_fin <= '$fecha_fin'";
  }
  $query .= " ORDER BY mediciones.periodo_inicio";
  $resultado = mysql_query($query);

  while ($registro = mysql_fetch_assoc($resultado))
  {
    $datos[] = $registro;
  }
  // Aquí van los totales
  $query = "SELECT mediciones.id as id_medicion, mediciones.etiqueta as medicion, 'Total' as unidad, 0 as id_unidad, $operador(valores.valor) as valor 
            FROM mediciones INNER JOIN valores ON mediciones.id = valores.id_medicion 
            WHERE mediciones.id_indicador = $id AND valor IS NOT NULL";
  if ($fecha_inicio > 0)
  {
    $query .= " AND mediciones.periodo_inicio >= '$fecha_inicio'";
  }
  if ($fecha_fin > 0)
  {
    $query .= " AND mediciones.periodo_fin <= '$fecha_fin'";
  }
  $query .= " GROUP BY mediciones.id ORDER BY mediciones.periodo_inicio";
  $resultado = mysql_query($query);
  while ($registro = mysql_fetch_assoc($resultado))
  {
    $datos[] = $registro;
  }
  $datos = json_encode($datos);
  echo $datos;
}

// Devuelve las medias de los valores de un indicador ordenadas por su periodo de inicio
// Se utiliza en consulta_avanzada
function get_valores_indicador_media($id)
{
  $query = "SELECT mediciones.etiqueta as medicion, AVG(valores.valor) 
            FROM mediciones INNER JOIN valores ON mediciones.id = valores.id_medicion 
            WHERE mediciones.id_indicador = $id AND valor IS NOT NULL
            GROUP BY mediciones.id ORDER BY mediciones.periodo_inicio";
  $resultado = mysql_query($query);
  while ($registro = mysql_fetch_assoc($resultado))
  {
    $datos[] = $registro;
  }
  $datos = json_encode($datos);
  echo $datos;
}

function get_valores_indicador_suma($id)
{
  $query = "SELECT mediciones.etiqueta as medicion, SUM(valores.valor) 
            FROM mediciones INNER JOIN valores ON mediciones.id = valores.id_medicion 
            WHERE mediciones.id_indicador = $id AND valor IS NOT NULL
            GROUP BY mediciones.id ORDER BY mediciones.periodo_inicio";
  $resultado = mysql_query($query);
  while ($registro = mysql_fetch_assoc($resultado))
  {
    $datos[] = $registro;
  }
  $datos = json_encode($datos);
  echo $datos;
}
*/


