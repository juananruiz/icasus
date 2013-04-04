<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: class/panel_indicador.php
//---------------------------------------------------------------------------------------------------
// Gestiona los paneles de un cuadro de mando
//---------------------------------------------------------------------------------------------------

class panel_indicador extends ADOdb_Active_Record
{
	public $_table = 'panel_indicadores';
	public $indicador;

  // Devuelve un array de paneles con los panel_indicador asociados a cada uno
	public function load_joined($condicion)
	{
		if ($this->load($condicion))
    {
        $this->indicador = new indicador();
        $this->indicador->load("id = $this->id_indicador");
    }
    else
    {
      return false;
    }
	}
}
?>

