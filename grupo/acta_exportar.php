<?php

//cargar constantes
define('IC_DB_HOST','localhost');
define('IC_DB_LOGIN','icasusproduccion');
define('IC_DB_CLAVE','icasuspassword2009');
define('IC_DB_DATABASE','icasus');
//cargar libreria
include_once('../lib/adodb5/adodb.inc.php');
include_once('../lib/adodb5/adodb-active-record.inc.php');
include_once('../function/sanitize.php');

//cargar clases
function __autoload($class_name)
{
        if (file_exists('../class/'.$class_name.'.php'))
        {       
                require_once('../class/'.$class_name.'.php');
        }
}

//cargar  BD
$adodb = NewADOConnection('mysql://'.IC_DB_LOGIN.':'.IC_DB_CLAVE.'@'.IC_DB_HOST.'/'.IC_DB_DATABASE);
ADOdb_Active_Record::SetDatabaseAdapter($adodb);

//cargar el acta
$id_acta = sanitize($_GET['id_acta'],2);
$acta = new acta();
$acta->load_joined('id_acta='.$id_acta);

//print_r($acta);
//comprueba permiso y Rescata la session que es distinta en cada servidor cada vez que cambie el servidor hay que poner el nombre de session
//IC_SESSIDeb20ec79session_name('IC_SESSIDe45fe9e2');
session_name('IC_SESSID76edacc5');
//session_name('IC_SESSIDeb20ec79');
session_start(); 
$id_usuario = $_SESSION["id_usuario"];
$permiso = new usuario_entidad();
$permiso = $permiso->load('id_usuario = '.$id_usuario.' AND id_entidad = '.$acta->id_entidad);
$permiso = 1;
//print_r($permiso);
if ($permiso == 1)
{

require_once("../lib/phprtflite/rtf/Rtf.php");

$null = null;
//defino los tips de letra
$arial8 = new Font(8, 'Arial', '#000000');
$arial8azul = new Font(8, 'Arial', '#0077aa');
$arial8azul = new Font(8, 'Arial', '#0077aa');
$paralinea = new Font(8, 'Arial', '#e9e9e9');

//defino el formato de los parrafos
$parF = new ParFormat('left');
$parM = new ParFormat('midle');

//creo el objeto rtf
$rtf = new Rtf();

//creamos la cabecera
$header = &$rtf->addHeader('all');
$header->addImage('../theme/usevilla/logo.jpg', $null);

//configuración de tamaño y márgenes de la página
$sect = &$rtf->addSection();
$sect->setPaperWidth(21);
$sect->setPaperHeight(29.5);
$sect->setMargins(2,2,1,2);

//salto una linea
$sect->writeText('<b>Acta</b> nº '.$acta->numero.' de '.date('j\/n\/Y',$acta->fecha).' de la Entidad '.$acta->entidad[0]->nombre, $arial8, $parF);

//datos asuntos
$sect->writeText('<b>Asuntos/Temas tratados:</b>', $arial8, $parF);
foreach ($acta->asuntos as $asunto)
{
$sect->writeText('<tab>'.$asunto->numero.'.- '.$asunto->asunto, $arial8, $parF);
}

//datos asistentes
$sect->writeText('<b>Asistentes:</b>', $arial8, $parF);
foreach ($acta->usuarios as $usuario)
{
if($usuario->asiste == 1)
{
$sect->writeText('<tab>'.$usuario->apellidos_usuario.', '.$usuario->nombre_usuario, $arial8, $parF);
}
}
$sect->writeText('<b>No asistentes:</b>', $arial8, $parF);
foreach ($acta->usuarios as $usuario)
{
if($usuario->asiste == 0)
{
$sect->writeText('<tab>'.$usuario->apellidos_usuario.', '.$usuario->nombre_usuario, $arial8, $parF);
}
}
  //datos de los acuerdos
  $sect->writeText('<b>Acuerdos:</b>', $arial8, $parF);
  if($acta->acuerdos)
  {
   foreach ($acta->acuerdos as $acuerdo)
   {
     $sect->writeText('<tab>'.$acuerdo->numero.'.- '.$acuerdo->acuerdo, $arial8, $parF);
   }
  }
  else
  {
     $sect->writeText(':: No existen acuerdos ::', $arial8, $parM);
  }
  //datos de las tareas en tabla
  $sect->writeText('<b>Tareas:</b>', $arial8, $parF);
  if ($acta->tareas)
  {
   foreach ($acta->tareas as $tarea)
   {
    $sect->writeText('<tab>'.$tarea->numero.'.- '.$tarea->tarea, $arial8, $parF);
    $sect->writeText('<tab><b>Responsable: </b> '.$tarea->nombre, $arial8, $parF);
    $sect->writeText('<tab><b>Adjudicación: </b> '.date('j\/n\/Y',$tarea->adjudicacion).' <b>Estimada: </b> '.date('j\/n\/Y',$tarea->estimada).' <b>Fin: </b> '.date('j\/n\/Y',$tarea->finalizacion), $arial8, $parF);
    $sect->writeText('<tab>...................................................................................................................................', $paralinea, $parF);
   }
  }
  else
  {
    $sect->writeText(':: No existen tareas ::', $arial8, $parF);
  }
//Pie de página
$footer = &$rtf->addFooter('all');
$footer->writeText('Acta generada por ICASUS 0.5<tab><tab>página <pagenum>',new Font(), new ParFormat('right'));
$rtf->sendRtf('Acta_'.$acta->numero);
}
else
{
echo 'No tiene permiso para realizar esta operacion.';
}
?>
