<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: class/indicador.php
//---------------------------------------------------------------------------------------------------
// Gestiona los indicadores y los indicadores-dato
//---------------------------------------------------------------------------------------------------

class indicador extends ADOdb_Active_Record
{
	public $_table = 'indicadores';
	public $entidad;
	public $proceso;
	public $responsable;
	public $responsable_medicion;
	public $ruta_imagen;
	public $valores;
  public $valores_referencia;
  public $visibilidad;
  public $criterios_efqm;
  public $valores_pendientes;

	public function load_joined($criterio)
	{
		if ($this->load($criterio))
		{
      $proceso = new proceso();
      $proceso->load_joined("id = $this->id_proceso");
      $this->proceso = $proceso;

      $responsable_medicion = new usuario();
      $responsable_medicion->load("id = $this->id_responsable_medicion");
      $this->responsable_medicion = $responsable_medicion;

      $responsable = new usuario();
      $responsable->load("id = $this->id_responsable");
      $this->responsable = $responsable;

      $visibilidad = new visibilidad();
      $visibilidad->load("id = $this->id_visibilidad");
      $this->visibilidad = $visibilidad;

      $criterio = new criterio_efqm_indicador();
      $criterios = $criterio->Find_joined("id_indicador = $this->id");
      $this->criterios_efqm = $criterios;

      $valor_referencia = new valor_referencia();
      $valores_referencia = $valor_referencia->Find("id_indicador = $this->id");
      $this->valores_referencia = $valores_referencia;
      
      return true;
		}
		else
		{
			return false;
		}
	}	

	public function Find_joined($criterio)
	{
		if ($indicadores = $this->Find($criterio))
		{
			foreach ($indicadores as& $indicador)
			{
				$proceso = new proceso();
				$proceso->load("id = $indicador->id_proceso");
				$indicador->proceso = $proceso;

		  	$responsable = new usuario();
				$responsable->load("id = $indicador->id_responsable");
				$indicador->responsable = $responsable;

        $visibilidad = new visibilidad();
        $visibilidad->load("id = $indicador->id_visibilidad");
        $indicador->visibilidad = $visibilidad;

			}
			return $indicadores;
		}
		else
		{
			return false;
		}
	}	


  public function Find_con_pendientes($condicion)
  {
    if ($indicadores= $this->Find($condicion))
    {
      $query = "SELECT count(*) FROM indicadores_subunidades insu 
            INNER JOIN mediciones me ON insu.id_indicador = me.id_indicador 
            INNER JOIN valores va ON me.id = va.id_medicion 
            WHERE insu.id_entidad = va.id_entidad 
            AND insu.id_usuario  = 1 
            AND va.valor_parcial is NULL 
            AND insu.id_indicador = ";

      $adodb = $this->DB();

      foreach ($indicadores as& $indicador)
      {
        $resultset = $adodb->Execute($query . $indicador->id);
        $indicador->valores_pendientes = $resultset->fields[0];
      }
      return $indicadores;
    }
    else
    {
      return false;
    }
  }

	// Obtiene los valores introducidos en este indicador con la fecha de recogida como campo clave
	public function obtener_valores()
	{	
		$datos = array();
		$db = $this->DB();
		$query = "SELECT * FROM valor WHERE id_indicador = $this->id_indicador ORDER BY fecha_recogida";
		$resultado = $db->Execute($query);
		while (!$resultado->EOF)
		{
			$datos[$resultado->fields['fecha_recogida']] = $resultado->fields;
			$resultado->MoveNext();
		}
		if (sizeof($datos) > 0)
		{
			$this->valores = $datos;
			return true;
		}
		else
		{
			return false;
		}
	}

	public function indicador_publico()
	{
		if ($indicadores = $this->find("id_visibilidad = 2"))
		{
			foreach ($indicadores as $indicador)
			{
        $entidad = new entidad();	
        $entidad->load("id_entidad = $indicador->id_entidad");
        $indicador->entidad = $entidad->nombre;
			}
      return $indicadores;
		}
		else
		{
      return false;
		}
	}
//devuelve los indicadores con su valores
	public function find_valor($condicion)
	{
		$indicadores = $this->find($condicion);
		foreach ($indicadores as $indicador)
		{
			$valor = new valor();
			$valors = $valor->find("id_indicador = ".$indicador->id_indicador." ORDER BY fecha_recogida DESC");
			$indicador->valores = $valors;
		}
		//print_r($indicadores);
		return $indicadores;
	}
}
?>
