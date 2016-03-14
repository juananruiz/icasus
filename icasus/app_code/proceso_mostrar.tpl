<!-- Diálogo Confirmar Borrado -->
<div class="modal fade" id="dialogo_confirmar_borrado" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title" id="myModalLabel"><i class="fa fa-trash fa-fw"></i> {$smarty.const.TXT_PROC_BORRAR}: {$proceso->nombre}</h3>
            </div>
            <div class="modal-body">
                <p>{$smarty.const.MSG_PROC_CONFIRM_BORRAR}</p>
            </div>
            <div class="modal-footer">
                <button type="button" title="{$smarty.const.TXT_NO}" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times fa-fw"></i> {$smarty.const.TXT_NO}</button>
                <a title="{$smarty.const.TXT_SI}" class="btn btn-success" name="borrar" id="borrar" href='index.php?page=proceso_borrar&id_proceso={$proceso->id}&id_entidad={$proceso->id_entidad}'><i class="fa fa-check fa-fw"></i> {$smarty.const.TXT_SI}</a>
            </div>
        </div>
    </div>
</div>
<!-- /Diálogo Confirmar Borrado -->

<!-- Diálogo Confirmar Borrado indicador -->
<div class="modal fade" id="dialogo_confirmar_borrado_indicador" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title" id="myModalLabel"><i class="fa fa-trash fa-fw"></i> {$smarty.const.TXT_INDIC_BORRAR}: <span id="nombre_indicador"></span></h3>
            </div>
            <div class="modal-body">
                <p>{$smarty.const.MSG_INDIC_CONFIRM_BORRAR}</p>
            </div>
            <div class="modal-footer">
                <button type="button" title="{$smarty.const.TXT_NO}" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times fa-fw"></i> {$smarty.const.TXT_NO}</button>
                <a title="{$smarty.const.TXT_SI}" class="btn btn-success" name="borrar" id="borrar"><i class="fa fa-check fa-fw"></i> {$smarty.const.TXT_SI}</a>
            </div>
        </div>
    </div>
</div>
<!-- /Diálogo Confirmar Borrado indicador -->

<!-- Nombre página -->
<div class="row">
    <div class="col-lg-12">
        <h3 title="{$_nombre_pagina}" class="page-header">
            <div class="row">
                <div class="col-md-10">
                    <i class="fa fa-gear fa-fw"></i> {$_nombre_pagina}
                </div>
                <!-- /.col-md-10 -->
                <!-- Navegación -->
                {if count($procesos)> 1}
                    <div class="col-md-2">
                        <div style="font-size:10px">{$indice+1} {$smarty.const.TXT_DE} {count($procesos)} {$smarty.const.TXT_PROCS}</div>
                        <div class="btn-toolbar" role="toolbar" aria-label="">
                            <div class="btn-group" role="group" aria-label="">
                                <a title="{$smarty.const.TXT_PRIMER} {$smarty.const.FIELD_PROC}" class="btn btn-danger btn-xs {if $indice == 0}disabled{/if}" href='index.php?page=proceso_mostrar&id_entidad={$entidad->id}&id_proceso={$procesos[0]->id}'>
                                    <i class="fa fa-step-backward fa-fw"></i>
                                </a>
                                <a title="{$smarty.const.TXT_ANT} {$smarty.const.FIELD_PROC}" class="btn btn-danger btn-xs {if $indice == 0}disabled{/if}" href='index.php?page=proceso_mostrar&id_entidad={$entidad->id}&id_proceso={$procesos[$indice-1]->id}'>
                                    <i class="fa fa-play fa-rotate-180 fa-fw"></i>
                                </a>
                                <a title="{$smarty.const.TXT_SIG} {$smarty.const.FIELD_PROC}" class="btn btn-danger btn-xs {if $indice == (count($procesos)-1)}disabled{/if}" href='index.php?page=proceso_mostrar&id_entidad={$entidad->id}&id_proceso={$procesos[$indice+1]->id}'>
                                    <i class="fa fa-play fa-fw"></i>
                                </a>
                                <a title="{$smarty.const.TXT_ULTIMO} {$smarty.const.FIELD_PROC}" class="btn btn-danger btn-xs {if $indice == (count($procesos)-1)}disabled{/if}" href='index.php?page=proceso_mostrar&id_entidad={$entidad->id}&id_proceso={$procesos[(count($procesos)-1)]->id}'>
                                    <i class="fa fa-step-forward fa-fw"></i>
                                </a>
                            </div>
                        </div> 
                    </div>
                    <!-- /.col-md-2 -->
                {/if}
                <!-- /Navegación -->
            </div>
            <!-- /.row -->
        </h3>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<!-- /Nombre página -->

<!-- Breadcrumbs -->
<div class="row">
    <div class="col-lg-12">
        <ol class="breadcrumb">
            <i title="{$smarty.const.TXT_ESTA}" class="fa fa-map-marker fa-fw"></i>
            <li><a title="{$smarty.const.FIELD_UNIDS}" href='index.php?page=entidad_listar'>{$smarty.const.FIELD_UNIDS}</a></li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" title="{$entidad->nombre}" href="index.php?page=entidad_mostrar&id_entidad={$entidad->id}">
                    {$entidad->nombre|truncate:30} <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a title="{$smarty.const.FIELD_USER}: {$_usuario->login} - {$smarty.const.TXT_UNID}: {$entidad->nombre} - {$smarty.const.FIELD_ROL}: {$_rol}" href="index.php?page=entidad_mostrar&id_entidad={$entidad->id}"><i class="fa fa-folder fa-fw"></i> {$entidad->nombre} / <i class="fa fa-user fa-fw"></i> {$_rol}</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a title="{$smarty.const.TXT_PROCS_DESCRIPCION}" href='index.php?page=proceso_listar&id_entidad={$entidad->id}'>
                            <i class="fa fa-gears fa-fw"></i> {$smarty.const.TXT_PROCS} <span title="{$smarty.const.FIELD_TOTAL}: {$num_procesos} {$smarty.const.TXT_PROCS}">({$num_procesos})</span>
                        </a>
                    </li>
                    <li>
                        <a title="{$smarty.const.TXT_INDICS_DESCRIPCION}" href='index.php?page=indicador_listar&id_entidad={$entidad->id}'>
                            <i class="fa fa-dashboard fa-fw"></i> {$smarty.const.FIELD_INDICS} <span title="{$smarty.const.FIELD_TOTAL}: {$num_indicadores} {$smarty.const.FIELD_INDICS}">({$num_indicadores})</span>
                        </a>
                    </li>
                    <li>
                        <a title="{$smarty.const.TXT_DATOS_DESCRIPCION}" href='index.php?page=dato_listar&id_entidad={$entidad->id}'>
                            <i class="fa fa-database fa-fw"></i> {$smarty.const.FIELD_DATOS} <span title="{$smarty.const.FIELD_TOTAL}: {$num_datos} {$smarty.const.FIELD_DATOS}">({$num_datos})</span>
                        </a>
                    </li>
                    <li>
                        <a title="{$smarty.const.TXT_CUADRO_MANDO_DESCRIPCION}" href='index.php?page=cuadro_listar&id_entidad={$entidad->id}'>
                            <i class="fa fa-th fa-fw"></i> {$smarty.const.TXT_CUADROS_MANDO} <span title="{$smarty.const.FIELD_TOTAL}: {$num_cuadros} {$smarty.const.TXT_CUADROS_MANDO}">({$num_cuadros})</span>
                        </a>
                    </li>
                    <li>
                        <a title="{$smarty.const.TXT_CONSULTA_DESCRIPCION}" href="index.php?page=consulta_avanzada&id_entidad={$entidad->id}">
                            <i class="fa fa-commenting fa-fw"></i> {$smarty.const.TXT_CONSULT}
                        </a>
                    </li>   
                    {if $_control}
                        <li class="divider"></li>
                        <li>
                            <a title="{$smarty.const.TXT_CONTROL_DESCRIPCION}" href="index.php?page=control&modulo=inicio&id_entidad={$entidad->id}">
                                <i class="fa fa-sliders fa-fw"></i> {$smarty.const.TXT_CONTROL}
                            </a>
                        </li>
                    {/if}
                </ul>
                <!-- /.dropdown-menu -->
            </li>
            <!-- /.dropdown -->
            <li><a title="{$smarty.const.TXT_PROCS}" href='index.php?page=proceso_listar&id_entidad={$entidad->id}'>{$smarty.const.TXT_PROCS}</a></li>
            <li title="{$_nombre_pagina}" class="active">{$_nombre_pagina}</li>
        </ol>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<!-- /Breadcrumbs -->

<div class="row">
    <div class="col-lg-12">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active">
                <a href="#proc_param" title="{$smarty.const.TXT_FICHA}" aria-controls="{$smarty.const.TXT_FICHA}" role="tab" data-toggle="tab"><i class="fa fa-folder fa-fw"></i> {$smarty.const.TXT_FICHA}</a>
            </li>
            <li role="presentation">
                <a href="#proc_indics" title="{$smarty.const.FIELD_INDICS}" aria-controls="{$smarty.const.FIELD_INDICS}" role="tab" data-toggle="tab"><i class="fa fa-dashboard fa-fw"></i> {$smarty.const.FIELD_INDICS}</a>
            </li>
            {if isset($flujograma)}
                <li role="presentation">
                    <a href="#proc_flujo" title="{$smarty.const.TXT_PROC_FLUJO}" aria-controls="{$smarty.const.TXT_PROC_FLUJO}" role="tab" data-toggle="tab"><i class="fa fa-random fa-fw"></i> {$smarty.const.TXT_PROC_FLUJO}</a>
                </li>
            {/if}
            {if isset($archivos)}
                <li role="presentation">
                    <a href="#proc_archivos" title="{$smarty.const.TXT_ARCHIVOS}" aria-controls="{$smarty.const.TXT_ARCHIVOS}" role="tab" data-toggle="tab"><i class="fa fa-archive fa-fw"></i> {$smarty.const.TXT_ARCHIVOS}</a>
                </li>
            {/if}
            {if $subprocesos}
                <li role="presentation">
                    <a href="#proc_subprocs" title="{$smarty.const.FIELD_SUBPROCS}" aria-controls="{$smarty.const.FIELD_SUBPROCS}" role="tab" data-toggle="tab"><i class="fa fa-gears fa-fw"></i> {$smarty.const.FIELD_SUBPROCS}</a>
                </li>
            {/if}
        </ul>
        <!-- /Nav tabs -->
        <br>
        <!-- Tab panes -->
        <div class="tab-content">
            
            <!-- Barra de botones -->
            {if $_control || $_usuario->id == $proceso->id_propietario}
                <div class="row">
                    <div class="col-lg-12">
                        <div class="btn-toolbar" role="toolbar" aria-label="">
                            <div class="btn-group" role="group" aria-label="">
                                <a class="btn btn-danger" href='index.php?page=archivo_gestionar&id_proceso={$proceso->id}&id_entidad={$proceso->id_entidad}' 
                                   title="{$smarty.const.TXT_ARCHIVOS_GESTION}">
                                    <i class="fa fa-archive fa-fw"></i> {$smarty.const.TXT_ARCHIVOS_GESTION}
                                </a>
                            </div>
                            <div class="btn-group pull-right" role="group" aria-label="">
                                <a title="{$smarty.const.TXT_PROC_EDIT}" class="btn btn-danger" href='index.php?page=proceso_editar&id_proceso={$proceso->id}&id_entidad={$proceso->id_entidad}'>
                                    <i class="fa fa-gear fa-fw"></i><sub class="fa fa-pencil fa-fw"></sub>
                                </a>
                                <a title="{$smarty.const.TXT_PROC_BORRAR}" class="btn btn-danger" href='javascript:void(0)' 
                                   data-toggle="modal" data-target="#dialogo_confirmar_borrado">
                                    <i class="fa fa-trash fa-fw"></i>
                                </a>
                            </div>
                            <div class="btn-group pull-right" role="group" aria-label="">
                                <a class="btn btn-danger" href='index.php?page=indicador_crear&id_entidad={$entidad->id}&id_proceso={$proceso->id}' title="{$smarty.const.TXT_INDIC_CREAR}">
                                    <i class="fa fa-dashboard fa-fw"></i><sub class="fa fa-plus fa-fw"></sub>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <br>
            {/if}
            <!-- /Barra de botones -->

            <!-- Parámetros del proceso -->
            <div role="tabpanel" class="tab-pane active" id="proc_param">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <tbody>
                            <tr>
                                <th>{$smarty.const.FIELD_COD}</th>
                                <td><span class="label label-primary">{$proceso->codigo}</span></td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_NOMBRE}</th>
                                <td>{$proceso->nombre}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_VERSION}</th>
                                <td>{$proceso->revision}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_FECHA}</th>
                                <td>{$proceso->fecha_revision|date_format:'%d/%m/%Y'}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_TIPO_PROC}</th>
                                <td>{$proceso->alcance}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_PROC_MADRE}</th>
                                <td>
                                    {if $proceso_madre->id > 0}              
                                        <a title="{$proceso_madre->nombre}" 
                                           href="index.php?page=proceso_mostrar&id_proceso={$proceso_madre->id}&id_entidad={$proceso->id_entidad}">
                                            {$proceso_madre->codigo} - {$proceso_madre->nombre}
                                        </a>
                                    {else}
                                        {$smarty.const.TXT_PROC_ES_MADRE}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_PROPIETARIO}</th>
                                <td>
                                    {$propietario->nombre} {$propietario->apellidos} {if $propietario->puesto} - {$propietario->puesto} {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_MISION}</th>
                                <td> 
                                    {if $proceso->mision}
                                        {$proceso->mision|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_EQUIP_PROC}</th>
                                <td> 
                                    {if $proceso->equipo_de_proceso}
                                        {$proceso->equipo_de_proceso|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_RESULTS_CLAVE}</th>
                                <td> 
                                    {if $proceso->resultados_clave}
                                        {$proceso->resultados_clave|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_ENTRADAS_PROV}</th>
                                <td> 
                                    {if $proceso->entradas}
                                        {$proceso->entradas|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_SALIDAS_CLIENTS}</th>
                                <td> 
                                    {if $proceso->entradas or $proceso->salidas}
                                        {$proceso->salidas|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_ACTIVIDADES}</th>
                                <td> 
                                    {if $proceso->actividades}
                                        {$proceso->actividades|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_VARS_CONTROL}</th>
                                <td> 
                                    {if $proceso->variables_control}
                                        {$proceso->variables_control|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_DOCUMENTACION}</th>
                                <td> 
                                    {if $proceso->documentacion}
                                        {$proceso->documentacion|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>       
                            <tr>
                                <th>{$smarty.const.FIELD_MEDICIONES}</th>
                                <td> 
                                    {if $proceso->mediciones}
                                        {$proceso->mediciones|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>      
                            <tr>
                                <th>{$smarty.const.FIELD_REGISTROS}</th>
                                <td> 
                                    {if $proceso->registros}
                                        {$proceso->registros|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_OBSERV}</th>
                                <td> 
                                    {if $proceso->observaciones}
                                        {$proceso->observaciones|nl2br}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- /Parámetros del proceso -->

            <!-- Indicadores del proceso -->
            <div role="tabpanel" class="tab-pane" id="proc_indics">
                {if $indicadores}
                    <div class="table-responsive">
                        <table class="table datatable table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>{$smarty.const.FIELD_COD}</th>
                                    <th>{$smarty.const.FIELD_INDIC}</th>
                                    <th>{$smarty.const.FIELD_RESP}</th>
                                    <th>{$smarty.const.FIELD_RESP_MED}</th>
                                    <th>{$smarty.const.TXT_MED_ULTIMA}</th>
                                    <th>{$smarty.const.FIELD_VAL}</th>
                                    <th>{$smarty.const.FIELD_STATUS}</th>
                                    <th>{$smarty.const.FIELD_ACCIONES}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$indicadores item=indicador}
                                    <tr {if isset($medicion_lim[$indicador->id]) AND isset($medicion_obj[$indicador->id])}
                                                        {if $totales[$indicador->id] < $medicion_lim[$indicador->id]}
                                                            class="danger"
                                                        {else if $totales[$indicador->id] >= $medicion_obj[$indicador->id]}
                                                            class="success"
                                                        {else}
                                                            class="warning"
                                                        {/if}
                                                    {/if}
                                                    {if isset($medicion_obj[$indicador->id]) AND !isset($medicion_lim[$indicador->id])}
                                                        {if $totales[$indicador->id] >= $medicion_obj[$indicador->id]}
                                                            class="success"
                                                        {else}
                                                            class="danger"
                                                        {/if}
                                                    {/if}
                                                    {if isset($medicion_lim[$indicador->id]) AND !isset($medicion_obj[$indicador->id])}
                                                        {if $totales[$indicador->id] < $medicion_lim[$indicador->id]}
                                                            class="danger"
                                                        {else}
                                                            class="success"
                                                        {/if}
                                                    {/if}>  
                                        <td><span class="label label-primary">{$indicador->codigo}</span></td>
                                        <td>
                                            {if $indicador->calculo}
                                                <i class="fa fa-calculator fa-fw" title="{$smarty.const.TXT_CALC_AUTO}: {$indicador->calculo}"></i>
                                            {/if}
                                            {if $indicador->id_tipo_agregacion!= 0}
                                                <i class="fa fa-sitemap fa-fw" title="{$smarty.const.FIELD_AGREG}"></i>
                                            {/if}
                                            <a title='{$indicador->nombre}: {$indicador->descripcion}' href='index.php?page=indicador_mostrar&id_indicador={$indicador->id}&id_entidad={$proceso->id_entidad}'>{$indicador->nombre}</a>
                                        </td>
                                        <td style="font-size: 12px">
                                            <a title="{$smarty.const.TXT_USER_PERFIL}" href='index.php?page=usuario_mostrar&id_usuario={$indicador->id_responsable}'>{$indicador->responsable->nombre} {$indicador->responsable->apellidos}</a>
                                        </td>
                                        <td style="font-size: 12px">
                                            <a title="{$smarty.const.TXT_USER_PERFIL}" href='index.php?page=usuario_mostrar&id_usuario={$indicador->id_responsable_medicion}'>
                                                {$indicador->responsable_medicion->nombre} {$indicador->responsable_medicion->apellidos}</a>
                                        </td>
                                        <td>{$indicador->medicion->etiqueta}</td>
                                        <td>{if ($totales[$indicador->id])}{$totales[$indicador->id]|round:"2"}{else}---{/if}</td>
                                        <td class="text-center"> 
                                            {if $totales[$indicador->id] != NULL}
                                                {if isset($medicion_lim[$indicador->id]) AND isset($medicion_obj[$indicador->id])}
                                                    {if  $totales[$indicador->id] < $medicion_lim[$indicador->id]}
                                                        <i title="{$smarty.const.TXT_VAL_MEJORABLE}" class="fa fa-circle fa-fw" style="color:red"></i>
                                                    {else if $totales[$indicador->id] >= $medicion_obj[$indicador->id]}
                                                        <i title="{$smarty.const.TXT_VAL_LOGRADO}" class="fa fa-circle fa-fw" style="color:green"></i>
                                                    {else}
                                                        <i title="{$smarty.const.TXT_VAL_ACEPTABLE}" class="fa fa-circle fa-fw" style="color:yellow"></i>
                                                    {/if}
                                                {else if isset($medicion_obj[$indicador->id])}
                                                    {if $totales[$indicador->id] >= $medicion_obj[$indicador->id] }
                                                        <i title="{$smarty.const.TXT_VAL_LOGRADO}" class="fa fa-circle fa-fw" style="color:green"></i>
                                                    {else}
                                                        <i title="{$smarty.const.TXT_VAL_MEJORABLE}" class="fa fa-circle fa-fw" style="color:red"></i>
                                                    {/if}
                                                {else if isset($medicion_lim[$indicador->id])}
                                                    {if $totales[$indicador->id] < $medicion_lim[$indicador->id] }
                                                        <i title="{$smarty.const.TXT_VAL_MEJORABLE}" class="fa fa-circle fa-fw" style="color:red"></i>
                                                    {else}
                                                        <i title="{$smarty.const.TXT_VAL_LOGRADO}" class="fa fa-circle fa-fw" style="color:green"></i>
                                                    {/if}
                                                {else}
                                                    ---
                                                {/if}
                                            {else}
                                                ---
                                            {/if}
                                        </td>
                                        <td>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_FICHA}" target="_blank" href='index.php?page=indicador_mostrar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}'>
                                                <i class="fa fa-folder fa-fw"></i>
                                            </a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_REP_GRAFIC}" target="_blank" href='index.php?page=graficas_mostrar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}'>
                                                <i class="fa fa-area-chart fa-fw"></i>
                                            </a>
                                            <a class="btn btn-default btn-circle btn-xs" href='index.php?page=medicion_listar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}' 
                                               title="{$smarty.const.TXT_INDIC_MED}: {$indicador->nombre}" target="_blank">
                                                <i class="fa fa-history fa-fw"></i>
                                            </a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_VAL_REF}" href='index.php?page=valor_referencia_crear&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}' target="_blank">
                                                <i class="fa fa-tags fa-fw"></i>
                                            </a>
                                            {if $_control OR $_usuario->id==$indicador->id_responsable}
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_EDIT}" href='index.php?page=indicador_editar&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}' target="_blank">
                                                    <i class="fa fa-pencil fa-fw"></i>
                                                </a>
                                                {if !$indicador->calculo}
                                                    <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_VAL_EDIT}" href='index.php?page=indicador_subunidad_valor&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}' target="_blank">
                                                        <i class="fa fa-pencil-square-o fa-fw"></i> 
                                                    </a>
                                                {/if}
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.FIELD_RESP_MED}" href='index.php?page=medicion_responsable&id_indicador={$indicador->id}&id_entidad={$indicador->id_entidad}' target="_blank">
                                                    <i class="fa fa-user fa-fw"></i>
                                                </a>
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_BORRAR}" href='javascript:void(0)' data-toggle="modal" data-target="#dialogo_confirmar_borrado_indicador"
                                                   data-id_indicador="{$indicador->id}" data-nombre_indicador="{$indicador->nombre}" data-id_entidad="{$indicador->id_entidad}">
                                                    <i class="fa fa-trash fa-fw"></i>
                                                </a>
                                            {/if}
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                {else}
                    <div class="alert alert-info alert-dismissible">
                        <i class="fa fa-info-circle fa-fw"></i> 
                        {$smarty.const.MSG_PROC_NO_INDIC}
                    </div> 
                {/if}
            </div>
            <!-- /Indicadores del proceso -->

            <!-- Flujograma del proceso -->
            {if isset($flujograma)}
                <div role="tabpanel" class="tab-pane" id="proc_flujo">
                    <img src="index.php?page=archivo_descargar&id={$flujograma->id}" alt="{$smarty.const.TXT_PROC_FLUJO}" class="img-rounded img-responsive" style="margin:0 auto">
                </div>
            {/if}
            <!-- /Flujograma del proceso -->

            <!-- Archivos del proceso -->
            {if isset($archivos)}
                <div role="tabpanel" class="tab-pane" id="proc_archivos">
                    <div class="table-responsive">
                        <table class="table datatable table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>{$smarty.const.FIELD_TITULO}</th>
                                    <th>{$smarty.const.FIELD_USER}</th>
                                    <th>{$smarty.const.FIELD_ACCIONES}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$archivos item=archivo} 
                                    {if $archivo->visible}
                                        <tr>  
                                            <td>
                                                <a title='{$archivo->titulo|htmlentities}: {$archivo->descripcion}' href="index.php?page=archivo_descargar&id={$archivo->id}">{$archivo->titulo|htmlentities}</a>
                                            </td>
                                            <td style="font-size: 12px">
                                                <a title="{$smarty.const.TXT_USER_PERFIL}" href='index.php?page=usuario_mostrar&id_usuario={$archivo->usuario->id}'>{$archivo->usuario->nombre|htmlentities} {$archivo->usuario->apellidos|htmlentities}</a>
                                            </td>
                                            <td style="white-space:nowrap">
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_ARCHIVO_DESCARGA}" href="index.php?page=archivo_descargar&id={$archivo->id}"><i class="fa fa-download fa-fw"></i></a>                 
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_USER_PERFIL}" href='index.php?page=usuario_mostrar&id_usuario={$archivo->usuario->id}'><i class="fa fa-user fa-fw"></i></a>
                                            </td>
                                        </tr>
                                    {/if}
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            {/if}
            <!-- /Archivos del proceso -->

            <!-- Subprocesos -->
            {if $subprocesos}
                <div role="tabpanel" class="tab-pane" id="proc_subprocs">
                    <div class="table-responsive">
                        <table class="table datatable table-striped table-hover">
                            <thead>
                                <tr>   
                                    <th>{$smarty.const.FIELD_COD}</th>
                                    <th>{$smarty.const.FIELD_NOMBRE}</th>
                                    <th>{$smarty.const.FIELD_TIPO_PROC}</th>
                                    <th>{$smarty.const.FIELD_PROC_MADRE}</th>         
                                    <th>{$smarty.const.FIELD_PROPIETARIO}</th>
                                    <th>{$smarty.const.FIELD_ACCIONES}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$subprocesos item=subproceso}
                                    <tr>    
                                        <td><span class="label label-primary">{$subproceso->codigo}</span></td>
                                        <td>
                                            <a title="{$subproceso->nombre}" href="index.php?page=proceso_mostrar&id_proceso={$subproceso->id}&id_entidad={$subproceso->id_entidad}">
                                                {$subproceso->nombre}
                                            </a>
                                        </td>
                                        <td>{$subproceso->alcance}</td>
                                        <td>
                                            {if $subproceso->madre->id > 0}
                                                <a title="{$subproceso->madre->nombre}" href="index.php?page=proceso_mostrar&id_proceso={$subproceso->madre->id}&id_entidad={$subproceso->madre->id_entidad}">
                                                    {$subproceso->madre->nombre}
                                                </a>
                                            {else}
                                                ---
                                            {/if}
                                        </td>
                                        <td style="font-size: 12px">
                                            <a title="{$smarty.const.TXT_USER_PERFIL}" href="index.php?page=usuario_mostrar&id_usuario={$subproceso->propietario->id}">
                                                {$subproceso->propietario->nombre} {$subproceso->propietario->apellidos}
                                            </a>
                                        </td>
                                        <td>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_FICHA}" href="index.php?page=proceso_mostrar&id_proceso={$subproceso->id}&id_entidad={$subproceso->id_entidad}">
                                                <i class="fa fa-folder fa-fw"></i>
                                            </a>                 
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_ARCHIVOS}" href='index.php?page=archivo_gestionar&id_proceso={$subproceso->id}&id_entidad={$subproceso->id_entidad}'>
                                                <i class="fa fa-archive fa-fw"></i>
                                            </a>
                                            {if $_control}
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_EDIT}" href='index.php?page=proceso_editar&id_proceso={$subproceso->id}&id_entidad={$subproceso->id_entidad}'>
                                                    <i class="fa fa-pencil fa-fw"></i>
                                                </a>   
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_BORRAR}" href='index.php?page=proceso_borrar&id_proceso={$subproceso->id}&id_entidad={$subproceso->id_entidad}' onclick="return confirm('{$smarty.const.MSG_PROC_CONFIRM_BORRAR}');" >
                                                    <i class="fa fa-trash fa-fw"></i>
                                                </a>
                                            {/if}
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            {/if}
            <!-- /Subprocesos -->

        </div>
        <!-- /Tab panes -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->