<?php 
//---------------------------------------------------------------------------------------------------
// Proyecto Icasus (http://wiki.us.es/icasus/)
// Archivo: ajax.php
// Desarrolladores: Juanan Ruiz <juanan@us.es>, Jesús Martin <jjmc@us.es>
//---------------------------------------------------------------------------------------------------
// Descripcion: Esta script carga las librerias
// Rescata la session que es distinta en cada servidor cada vez que cambie el servidor hay que poner el nombre de session
session_name('IC_SESSID76edacc5');
session_start();
$id_usuario = $_SESSION['id_usuario'];
// librerias utilizadas
include_once ('../config.php');
include_once('../lib/adodb5/adodb.inc.php');
include_once('../lib/adodb5/adodb-active-record.inc.php');
include_once('../lib/smarty/Smarty.class.php');
include_once('../function/sanitize.php');
include_once('../lib/phprtflite/rtf/Rtf.php');
// Carga las clases necesarias
function __autoload($class_name) 
{
	if (file_exists('../class/'.$class_name.'.php'))
	{	
		require_once('../class/'.$class_name.'.php');
	}
}
// Variables globales
$smarty = new Smarty();
$smarty->template_dir = '.'; 
$smarty->compile_dir = '../templates_c'; 
$smarty->config_dir = '../configs'; 
$smarty->cache_dir = '../cache'; 
//hacemos conexion
$adodb = NewADOConnection('mysql://'.IC_DB_LOGIN.':'.IC_DB_CLAVE.'@'.IC_DB_HOST.'/'.IC_DB_DATABASE);
ADOdb_Active_Record::SetDatabaseAdapter($adodb);
//recoge  el id del acta y carga los datos de ese acta.
$id_acta = sanitize($_POST['id_acta'],2);
$acta = new acta();
$acta->load_joined('id_acta  = '.$id_acta);
$smarty->assign('acta',$acta);
//comprobamos permisos para crear i editar actas
$permiso = new usuario_entidad();
$permiso->load('id_usuario = '.$id_usuario.' AND id_entidad = '.$acta->id_entidad.' AND id_rol = 3');
$permiso->_saved = 1;
?>
