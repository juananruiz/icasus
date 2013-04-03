{literal}
<script>
 $(document).ready(function() {
var table0 = $('#listado_mediciones').dataTable( {
				"bJQueryUI": true,
				"sScrollX": "",
				"bSortClasses": false,
				"aaSorting": [[1,'asc']],
				"bAutoWidth": true,
				"bInfo": true,
				"sScrollX": "101%",
				"bScrollCollapse": true,
				"sPaginationType": "full_numbers",
				"bRetrieve": true,
				"fnInitComplete": function () {
				
					$("#dt1 .dataTables_length > label > select").uniform();
					$("#dt1 .dataTables_filter input[type=text]").addClass("text");
					$(".datatable").css("visibility","visible");
				
				}
	});
	table0.fnSort([1,'asc']);
} );
</script>
{/literal}
<div class="box grid_16 single_datatable">
  <div class="button_bar clearfix">
    <a href="index.php?page=medicion_crear&id_{$tipo}={$indicador->id}"><img src='/icons/ff16/time.png' /> Agregar medición</a> &nbsp; &nbsp; &nbsp;
    <a href='index.php?page={$tipo}_mostrar&id_{$tipo}={$indicador->id}&id_entidad={$indicador->id_entidad}'><img src='/icons/ff16/chart_curve.png' /> Volver al {$tipo}</a> &nbsp;
  </div>

  {if $mediciones}
  <div id="dt1" class="no_margin">
    <table class="display datatable" id="listado_mediciones"> 
    <thead>
      <tr>
        <th>Etiqueta</th>
        <th>Fecha inicio periodo</th>
        <th>Fecha fin periodo</th>
        <th>Fecha inicio grabacion</th>
        <th>Fecha fin grabacion</th>
      </tr>
    </thead>
    <tbody>
      {foreach $mediciones as $medicion}
        <tr class="gradeX">
          <td nowrap><a href="index.php?page=medicion_editar&id_medicion={$medicion->id}&tipo={$tipo}">{$medicion->etiqueta}</a></td>
          <td>{$medicion->periodo_inicio}</td>
          <td>{$medicion->periodo_fin}</td>
          <td>{$medicion->grabacion_inicio}</td>
          <td>{$medicion->grabacion_fin}</td>
        </tr>
      {/foreach}
    </tbody>
    </table>
  </div>
  {else}
    <div class="alert alert_blue">
      <img height="24" width="24" src="theme/danpin/images/icons/small/white/alert_2.png">
      Todavía no se han establecido mediciones para este {$tipo}
    </div>
  {/if}
</div>
<div style="opacity: 1;" class="box grid_16">
		<h2 class="box_head">Tabla de valores</h2>
	<div style="opacity: 1;" class="block">	
<<<<<<< HEAD
	<table class="static">
		<thead>
		<tr>
			<th></th>
			{foreach from=$mediciones item=medicion}
				<th>{$medicion->etiqueta}</th>
			{/foreach}
		</tr>
		</thead>
		<tbody>
		{foreach from=$subunidades_mediciones item=subunidades}
			<tr><td>{$subunidades->etiqueta}</td>
			{foreach from=$subunidades->mediciones item=medicion}
				<td>{if $medicion->medicion_valor == '--'} -- {else}{$medicion->medicion_valor->valor}{/if}</td>
			{/foreach}
			</tr>
		{/foreach}
		</tbody>
	</table>
=======
    <table class="static">
      <thead>
      <tr>
        <th></th>
        {foreach from=$mediciones item=medicion}
          <th>{$medicion->etiqueta}</th>
        {/foreach}
      </tr>
      </thead>
      <tbody>
      {foreach from=$subunidades_mediciones item=subunidad}
        <tr><td>{$subunidad->nombre}</td>
        {foreach from=$subunidad->mediciones item=medicion}
          <td>{if $medicion->medicion_valor->valor == '--'} -- {else}{$medicion->medicion_valor->valor}{/if}</td>
        {/foreach}
        </tr>
      {/foreach}
      </tbody>
    </table>
>>>>>>> 95b4b9660ed883ca539f672e9097bdc7abf12ef5
	</div>
<div class="box grid_16">
  <p><img src="index.php?page=grafica_indicador_agregado&id_indicador={$indicador->id}" alt="gráfica completa con los valores medios del indicador" />
</div>
