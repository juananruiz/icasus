<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: app_code/grafica_indicador_agregado.php 
//---------------------------------------------------------------------------------------------------
// Descripcion: Muestra una gráfica con las agregados de los valores de un indicador agregado
//---------------------------------------------------------------------------------------------------
global $usuario;

include("../../cascara_core/lib/pChart2/class/pDraw.class.php");
include("../../cascara_core/lib/pChart2/class/pImage.class.php");
include("../../cascara_core/lib/pChart2/class/pData.class.php");

if (isset($_REQUEST["id_indicador"]))
{
  $id_indicador = sanitize($_REQUEST["id_indicador"], INT);
  // Inicio y fin marcan el rango de mediciones que vamos a tomar
  $inicio = isset($_REQUEST["inicio"])?sanitize($_REQUEST["inicio"], INT):0;
  $fin = isset($_REQUEST["fin"])?sanitize($_REQUEST["fin"], INT):0;
  $hoy = date("d-m-Y H:i:s");

  $indicador = new indicador();
  $indicador->load("id = $id_indicador");
  $db = $indicador->DB();
  if ($indicador->tipo_agregacion == 2)
  {
    $query = "SELECT mediciones.etiqueta, SUM(valor) AS agregado FROM valores INNER JOIN mediciones ON valores.id_medicion = mediciones.id INNER JOIN entidades ON valores.id_entidad = entidades.id WHERE mediciones.id_indicador = $id_indicador GROUP BY id_medicion ORDER BY mediciones.periodo_inicio;";
  }
  else
  {
    // Por defecto suponemos que el tipo_agregado es 1
    $query = "SELECT mediciones.etiqueta, ROUND(AVG(valor),2) AS agregado FROM valores INNER JOIN mediciones ON valores.id_medicion = mediciones.id INNER JOIN entidades ON valores.id_entidad = entidades.id WHERE mediciones.id_indicador = $id_indicador GROUP BY id_medicion ORDER BY mediciones.periodo_inicio;";
  }
  $resultado = $db->getAll($query);

  foreach ($resultado as $registro)
  {
    $agregados[] = $registro['agregado'];
    $etiquetas[] = $registro['etiqueta'];
  }

  if ($resultado)
  {
    $myData = new pData();
    $myData->addPoints($agregados, "Agregado");
    $myData->addPoints($etiquetas, "Periodo");
    $myData->setAbscissa("Periodo");
    $myData->setSerieOnAxis("Agregado", 0);
    $myPicture = new pImage(700,270,$myData);
    $myPicture->setFontProperties(array("FontName"=>"../../cascara_core/lib/pChart2/fonts/calibri.ttf","FontSize"=>11));
    $myPicture->setGraphArea(60,40,670,220);
    /* Draw the scale */ 
    $ScaleSettings = array("XMargin"=>35,"DrawSubTicks"=>TRUE,"GridR"=>155,"GridG"=>155,"GridB"=>155,"AxisR"=>0,"AxisG"=>0,"AxisB"=>0,"GridAlpha"=>30,"CycleBackground"=>TRUE);
    $myPicture->drawScale($ScaleSettings);
    //$agregado = round($myData->getSerieAverage("Agregado"),2);
    //$myPicture->drawThreshold($agregado,array("WriteCaption"=>TRUE));
    //$myPicture->drawBarChart(array("DisplayValues"=>TRUE,"DisplayColor"=>DISPLAY_AUTO));
    $myPicture->drawLineChart(array("DisplayValues"=>TRUE,"DisplayColor"=>DISPLAY_AUTO));
    $myPicture->drawPlotChart();
    $myPicture->drawText(20,260,"{$indicador->nombre}",array("FontSize"=>11,"Align"=>TEXT_ALIGN_BOTTOMLEFT));
    $myPicture->drawText(20,270,"{$hoy}",array("FontSize"=>11,"Align"=>TEXT_ALIGN_BOTTOMLEFT));
    $myPicture->Stroke();
  }
  else
  {
    $myPicture = new pImage(700,200);
    $myPicture->setFontProperties(array("FontName"=>"../../cascara_core/lib/pChart2/fonts/calibri.ttf","FontSize"=>11));
    $myPicture->setGraphArea(60,40,670,220);
    $myPicture->drawText(20,100,"No hay valores recogidos para este indicador",array("FontSize"=>26,"Align"=>TEXT_ALIGN_BOTTOMLEFT));
    $myPicture->Stroke();
  }
}
else
{
  $myPicture = new pImage(700,200);
  $myPicture->setFontProperties(array("FontName"=>"../../cascara_core/lib/pChart2/fonts/calibri.ttf","FontSize"=>11));
  $myPicture->setGraphArea(60,40,670,220);
  $myPicture->drawText(30,100,"Faltan parámetros para mostrar la gráfica",array("FontSize"=>26,"Align"=>TEXT_ALIGN_BOTTOMLEFT));
  $myPicture->Stroke();
}
?>
