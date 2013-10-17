<div class="box grid_16">
	<div class="toggle_container">
      <div class="button_bar clearfix">
        <a href='index.php?page=valor_referencia_crear&id_indicador={$indicador->id}'><img 
          src='/icons/ff16/tag.png' /> Valores de referencia</a> &nbsp;
        <a href='index.php?page=medicion_listar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}'><img 
          src='/icons/ff16/time.png' /> Mostrar mediciones</a> &nbsp;
        <a href='index.php?page=indicador_listar&id_entidad={$indicador->id_entidad}'><img 
          src='/icons/ff16/chart_curve.png' /> Listar todos</a> &nbsp;
        <a href='index.php?page=indicador_editar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}'><img 
          src='/icons/ff16/chart_curve_edit.png'  /> Editar</a> &nbsp; 
        <a href='index.php?page=indicador_crear&id_entidad={$indicador->id_entidad}'><img 
          src='/icons/ff16/chart_curve_add.png'  /> Crear</a> &nbsp; 
        <a href='index.php?page=indicador_borrar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}' onClick='return confirmar();'><img 
          src='/icons/ff16/chart_curve_delete.png'  /> Borrar</a> &nbsp; 
				<a href='index.php?page=medicion_responsable&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}'><img 
					src='/icons/ff16/user_medicion.png' /> Responsables medición</a> &nbsp;
				<a href='index.php?page=indicador_subunidad_valor&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}'><img 
					src='/icons/ff16/tag_blue.png' /> Edición valores</a>
      </div>
		<div class="block">
      <div class="columns clearfix">
        <div class="col_40">
          <fieldset class="label">
            <label>Código indicador</label>
            <div>
              {$indicador->codigo}
            </div>
          </fieldset>
        </div>
        <div class="col_60">
          <fieldset class="label">
            <label>Proceso</label>
            <div>
              <a href="index.php?page=proceso_mostrar&id_proceso={$indicador->proceso->id}&id_entidad={$indicador->id_entidad}">{$indicador->proceso->codigo} - {$indicador->proceso->nombre}</a>
            </div>
          </fieldset>
        </div>
      </div>
      <fieldset class="label_side">
        <label>Nombre indicador</label>
        <div>
          {$indicador->nombre}
        </div>
      </fieldset>
      {if $indicador->descripcion != ""}
        <fieldset class="label_side">
          <label>Descripci&oacute;n</label>
          <div>
            {$indicador->descripcion}
          </div>
        </fieldset>
      {/if}
      <fieldset class="label_side">
        <label>Formulaci&oacute;n</label>
        <div> 
          {$indicador->formulacion}
        </div>
      </fieldset>
      {if $indicador->calculo}
        <fieldset class="label_side">
          <label>Cálculo</label>
          <div> 
            {$indicador->calculo}
          </div>
        </fieldset>
      {/if}
			<fieldset class="label_side">
        <label>Responsable de seguimiento</label>
        <div>
          {$indicador->responsable->nombre} {$indicador->responsable->apellidos} 
          {if $indicador->responsable->puesto} - {$indicador->responsable->puesto} {/if}
        </div>
      </fieldset>
      <fieldset class="label_side">
        <label>Responsable de medición</label>
        <div>
          {$indicador->responsable_medicion->nombre} {$indicador->responsable_medicion->apellidos} 
          {if $indicador->responsable_medicion->puesto} - {$indicador->responsable_medicion->puesto} {/if}
        </div>
      </fieldset>
      {if $indicador->fuente_informacion != ""}
        <fieldset class="label_side">
          <label>Fuente de informaci&oacute;n</label>
          <div>{$indicador->fuente_informacion}&nbsp;</div>	
        </fieldset>
      {/if}
      {if $indicador->fuente_datos != ""}
      <fieldset class="label_side">
        <label>Fuente de datos</label>
        <div>{$indicador->fuente_datos}&nbsp;</div>	
      </fieldset>
      {/if}
      {if $indicador->evidencia != ""}
      <fieldset class="label_side">
        <label>Metodo de comprobaci&oacute;n / Evidencia</label>
        <div>{$indicador->evidencia}&nbsp;</div>		
      </fieldset>
      {/if}
      {if $indicador->historicos != ""}
      <fieldset class="label_side">
        <label>Hist&oacute;rico</label>
        <div>{$indicador->historicos}&nbsp;</div>
      </fieldset>
      {/if}
      {if $indicador->interpretacion != ""}
      <fieldset class="label_side">
        <label>Interpretaci&oacute;n</label>
        <div>{$indicador->interpretacion}&nbsp;</div>
      </fieldset>
      {/if}
      {if $indicador->indicadores_relacionados != ""}
      <fieldset class="label_side">
        <label>Indicadores relacionados</label>
        <div>{$indicador->indicadores_relacionados}&nbsp;</div>
      </fieldset>
      {/if}
      <div class="columns clearfix">
        <div class="col_50">
          <fieldset class="label_side">
            <label>Criterios EFQM</label>
            <div>
              <ul>
                {foreach $indicador->criterios_efqm as $indicador_criterio_efqm}
                  <li>{$indicador_criterio_efqm->criterio_efqm->codigo} - {$indicador_criterio_efqm->criterio_efqm->nombre}</li>
                {/foreach}
              </ul>
            </div>
          </fieldset>
        </div>
        <div class="col_50">
          <fieldset class="label_side">
            <label>Cálculo del total</label>
            <div>
              {if $indicador->id_tipo_agregacion == 0}Indefinido{/if}
              {if $indicador->id_tipo_agregacion == 1}Promedio{/if}
              {if $indicador->id_tipo_agregacion == 2}Suma{/if}
            </div>
          </fieldset>
        </div>
      </div>
      <div class="columns clearfix">
        <div class="col_50">
          <fieldset class="label_side">
            <label>Periodicidad</label>
            <div>{$indicador->periodicidad}&nbsp;</div>
          </fieldset>
        </div>
        <div class="col_50">
          <fieldset class="label_side">
            <label>Visibilidad</label>	
            <div>{$indicador->visibilidad->nombre|htmlentities}&nbsp;</div>
          </fieldset>
        </div>
      </div>
      <div class="columns clearfix">
        <div class="col_50">
          <fieldset class="label_side">
            <label>Nivel de desagregacion</label>
            <div>{$indicador->nivel_desagregacion}&nbsp;</div>
          </fieldset>
        </div>
        <div class="col_50">
          <fieldset class="label_side">
            <label>Unidad generadora</label>
            <div>{$indicador->unidad_generadora}&nbsp;</div>
          </fieldset>
        </div>
      </div>
      <fieldset class="label_side">
        <label>Subunidades afectadas</label>
        <div>
          {if $indicador_subunidades}
            <ul>
            {foreach $indicador_subunidades as $indicador_subunidad}
              <li><a href="index.php?entidad_datos&id_entidad={$indicador_subunidad->entidad->id}">{$indicador_subunidad->entidad->nombre}</a></li>
            {/foreach}
            </ul>
          {else}
            No se han asignado subunidades a este indicador (corregir)
          {/if}
        </div>
      </fieldset>
    </div>
  </div>
  </div>

  <h2>Mediciones</h2>
    <h3 class="section">
      <a href='index.php?page=medicion_listar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}'><img 
        src='/icons/ff16/time.png' /> Mostrar Mediciones</a>						
    </h3>
    
    {if $mediciones}
      <p><img src="index.php?page=grafica_indicador_agregado&id_indicador={$indicador->id}" alt="gráfica completa con los valores medios del indicador" />

      <div id="grafica_totales" data-id_indicador="{$indicador->id}" data-nombre_indicador="{$indicador->nombre}"></div>

    {else}
      <p class="aviso">Todavía no se han definido mediciones para este indicador.</p>
    {/if}

{literal}
<script src="theme/danpin/scripts/flot/jquery.flot.min.js" type="text/javascript"></script>		
<script>
  var id_indicador = $('#grafica_totales').data('id_indicador');
  var nombre_indicador = $('#grafica_totales').data('nombre_indicador');
  var datos_flot = [];
  var leyenda = $(this).next(".leyenda");
  // Pongo dos fechas de locura para que entren todas
  var fecha_inicio = '1970-01-01';
  var fecha_fin = '2222-01-01';

  $.getJSON("api_publica.php?metodo=get_valores_indicador&id=" + id_indicador + "&fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin).done(function(datos) {
    var items = [];
    var etiqueta_indicador;
    $.each(datos, function(i, dato) {
      //Queremos los totales de todas las subunidades, su id es 0, viene establecido en la api_publica
      if(dato.id_unidad == 0)
      {
        items.push([dato.medicion, dato.valor]);
      }
    });
    etiqueta_indicador = '<a href="index.php?page=medicion_listar&id_indicador=' + id_indicador + '" target="_blank">' + nombre_indicador + '</a>';
    datos_flot[0] = {label: etiqueta_indicador, color: 0, data: items };
    var opciones = {
      series: { lines: { show: true }, points: { show: true } },
      label: { show: true },
      legend: { container: leyenda },
      xaxis: { tickDecimals: 0 },
      grid: { hoverable: true },
      colors: ['maroon', 'darkolivegreen', 'orange', 'green', 'pink', 'yellow', 'brown']
    };
    $("#grafica_totales").css("height", "300px");
    $.plot($("#grafica_totales"), datos_flot, opciones);
    //--------------------------------------------------
    var previousPoint = null;
    $("#grafica_totales").bind("plothover", function (event, pos, item) {
      if (item) {
        if (previousPoint != item.dataIndex) {
          previousPoint = item.dataIndex;
          $("#tooltip").remove();
          var x = item.datapoint[0].toFixed(2),
          y = item.datapoint[1].toFixed(2);
          showTooltip(item.pageX, item.pageY, x + " - " + y + " - " + item.series.label);
        }
      }
      else 
      {
        $("#tooltip").remove();
        previousPoint = null;            
      }
    });
    //--------------------------------------------------
  }); 

  function showTooltip(x, y, contents) {
    $("<div id='tooltip'>" + contents + "</div>").css({
      position: "absolute",
      display: "none",
      top: y + 5,
      left: x + 5,
      width: "200 px",
      border: "1px solid #fdd",
      padding: "2px",
      "background-color": "#fee",
      "z-index": 1000,
      opacity: 0.80
    }).appendTo("body").fadeIn(200);
  }
</script>
{/literal}
