	<div id="AccionesActa" style="border-top:1px dotted #07a">
  <h3>Acciones:</h3>
  <!--  
	<a href="index.php?page=grupo/acta_abrir&id_entidad={$acta->id_entidad}&id_acta={$acta->id_acta}" 
  onclick="return confirm('¿Quiere reabrir el acta numero: {$acta->numero} ?');">
  <img src='iconos/16x16/report_link.png' title="Abrir acta"/> Abrir Acta</a> &nbsp;
  <a href="index.php?page=grupo/acta_cerrar&id_entidad={$acta->id_entidad}&id_acta={$acta->id_acta}" 
  onclick="return confirm('¿Quiere cerrar el acta numero: {$acta->numero} ?');">
  <img src='iconos/16x16/report_key.png' title="Cerrar acta"/> Cerrar Acta</a> &nbsp;
	-->  
<a href="grupo/acta_exportar.php?id_acta={$acta->id_acta}">
    <img src='iconos/16x16/page_word.png' title="Generar word"/> Generar word</a>&nbsp;
  
<a href="index.php?page=grupo/acta_leer&id_acta={$acta->id_acta}">
    <img src='iconos/16x16/report.png' title="Generar word"/> Leer acta</a>&nbsp;
  </div>

