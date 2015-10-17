<!-- Diálogo Confirmar Borrado -->
<div class="modal fade" id="dialogo_confirmar_borrado" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title" id="myModalLabel"><i class="fa fa-trash fa-fw"></i> {$smarty.const.TXT_DATO_BORRAR}: {$dato->nombre}</h3>
            </div>
            <div class="modal-body">
                <p>{$smarty.const.MSG_DATO_CONFIRM_BORRAR}</p>
            </div>
            <div class="modal-footer">
                <button type="button" title="{$smarty.const.TXT_NO}" class="btn btn-default btn-danger" data-dismiss="modal"><i class="fa fa-times fa-fw"></i> {$smarty.const.TXT_NO}</button>
                <a title="{$smarty.const.TXT_SI}" class="btn btn-default btn-success" name="borrar" id="borrar" href='index.php?page=dato_borrar&id_dato={$dato->id}&id_entidad={$dato->id_entidad}'><i class="fa fa-check fa-fw"></i> {$smarty.const.TXT_SI}</a>
            </div>
        </div>
    </div>
</div>
<!-- /Diálogo Confirmar Borrado -->

<!-- Nombre página -->
<div class="row">
    <div class="col-lg-12">
        <h3 title="{$_nombre_pagina}" class="page-header">
            <div class="row">
                <div class="col-md-10">
                    <i class="fa fa-folder fa-fw"></i> {$_nombre_pagina}
                </div>
                <!-- /.col-md-10 -->
                <!-- Navegación -->
                {if count($datos)> 1}
                    <div class="col-md-2">
                        <div class="btn-toolbar" role="toolbar" aria-label="">
                            <div class="btn-group" role="group" aria-label="">
                                <a title="{$smarty.const.TXT_PRIMER}" class="btn btn-default btn-danger btn-xs {if $indice == 0}disabled{/if}" href='index.php?page=dato_mostrar&id_entidad={$entidad->id}&id_dato={$datos[0]->id}'>
                                    <i class="fa fa-step-backward fa-fw"></i>
                                </a>
                                <a title="{$smarty.const.TXT_ANT}" class="btn btn-default btn-danger btn-xs {if $indice == 0}disabled{/if}" href='index.php?page=dato_mostrar&id_entidad={$entidad->id}&id_dato={$datos[$indice-1]->id}'>
                                    <i class="fa fa-play fa-rotate-180 fa-fw"></i>
                                </a>
                                <a title="{$smarty.const.TXT_SIG}" class="btn btn-default btn-danger btn-xs {if $indice == (count($datos)-1)}disabled{/if}" href='index.php?page=dato_mostrar&id_entidad={$entidad->id}&id_dato={$datos[$indice+1]->id}'>
                                    <i class="fa fa-play fa-fw"></i>
                                </a>
                                <a title="{$smarty.const.TXT_ULTIMO}" class="btn btn-default btn-danger btn-xs {if $indice == (count($datos)-1)}disabled{/if}" href='index.php?page=dato_mostrar&id_entidad={$entidad->id}&id_dato={$datos[(count($datos)-1)]->id}'>
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

<!-- Barra de botones -->
<div class="row">
    <div class="col-lg-12">
        <div class="btn-toolbar" role="toolbar" aria-label="">
            <div class="btn-group" role="group" aria-label="">
                {if $_control || $responsable}
                    <a title="{$smarty.const.TXT_DATO_EDIT}" class="btn btn-default btn-danger" href='index.php?page=dato_editar&id_dato={$dato->id}&id_entidad={$dato->id_entidad}'>
                        <i class="fa fa-pencil fa-fw"></i> {$smarty.const.TXT_DATO_EDIT}
                    </a>
                    <a title="{$smarty.const.TXT_DATO_BORRAR}" class="btn btn-default btn-danger" href='javascript:void(0)' 
                       data-toggle="modal" data-target="#dialogo_confirmar_borrado">
                        <i class="fa fa-trash fa-fw"></i> {$smarty.const.TXT_DATO_BORRAR}
                    </a>
                {/if}
            </div>
            <div class="btn-group" role="group" aria-label="">
                <a title="{$smarty.const.TXT_REP_GRAFIC}" class="btn btn-default btn-danger" href='index.php?page=graficas_mostrar&id_dato={$dato->id}&id_entidad={$dato->id_entidad}'>
                    <i class="fa fa-area-chart fa-fw"></i> {$smarty.const.TXT_REP_GRAFIC}
                </a>
            </div>
            <div class="btn-group" role="group" aria-label="">    
                <a title="{$smarty.const.TXT_MED_MOSTRAR}" class="btn btn-default btn-danger" href='index.php?page=medicion_listar&id_dato={$dato->id}&id_entidad={$dato->id_entidad}'>
                    <i class="fa fa-clock-o fa-fw"></i> {$smarty.const.TXT_MED_MOSTRAR}
                </a>
                {if !$dato->calculo && ($_control || $responsable)}
                    <a title="{$smarty.const.TXT_VAL_EDIT}" class="btn btn-default btn-danger" href='index.php?page=indicador_subunidad_valor&id_dato={$dato->id}&id_entidad={$dato->id_entidad}'>
                        <i class="fa fa-pencil-square-o fa-fw"></i> {$smarty.const.TXT_VAL_EDIT}
                    </a>
                {/if}
                {if $_control}
                    <a title="{$smarty.const.FIELD_RESP_MED}" class="btn btn-default btn-danger" href='index.php?page=medicion_responsable&id_dato={$dato->id}&id_entidad={$dato->id_entidad}'>
                        <i class="fa fa-user fa-fw"></i> {$smarty.const.FIELD_RESP_MED}
                    </a>
                {/if}
            </div>
            <div class="btn-group" role="group" aria-label="">
                <a title="{$smarty.const.TXT_VAL_REF}" class="btn btn-default btn-danger" href='index.php?page=valor_referencia_crear&id_dato={$dato->id}&id_entidad={$dato->id_entidad}'>
                    <i class="fa fa-tags fa-fw"></i> {$smarty.const.TXT_VAL_REF}
                </a>
            </div>
        </div>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<br>
<!-- /Barra de botones -->

<!-- Indicadores/datos calculados -->
{if $dato->calculo}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <span class="panel-title"><i class="fa fa-info-circle fa-fw"></i> {$smarty.const.TXT_CALC_AUTO}</span>
                    <i class="fa fa-chevron-up pull-right clickable"></i>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    {$smarty.const.TXT_DEPENDE}
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <tr>
                                <th>{$smarty.const.FIELD_ID}</th>
                                <th>{$smarty.const.FIELD_NOMBRE}</th>
                            </tr>
                            {foreach $datos_influyentes as $dato_influyente}
                                {if $dato_influyente->id_proceso}
                                    <tr>
                                        <td><span class="badge">{$dato_influyente->id}</span></td>
                                        <td>
                                            <a class="btn btn-default btn-info" href='index.php?page=dato_mostrar&id_dato={$dato_influyente->id}&id_entidad={$entidad->id}' 
                                               title="{$smarty.const.TXT_INDIC_MOSTRAR}: {$dato_influyente->nombre}">
                                                <i class="fa fa-dashboard fa-fw"></i> {$dato_influyente->nombre}
                                            </a>
                                        </td>
                                    </tr>
                                {else}
                                    <tr>
                                        <td><span class="badge">{$dato_influyente->id}</span></td>
                                        <td> 
                                            <a class="btn btn-default btn-info" href='index.php?page=dato_mostrar&id_dato={$dato_influyente->id}&id_entidad={$entidad->id}' 
                                               title="{$smarty.const.TXT_DATO_MOSTRAR}: {$dato_influyente->nombre}">
                                                <i class="fa fa-database fa-fw"></i> {$dato_influyente->nombre}
                                            </a>
                                        </td>
                                    </tr>
                                {/if}   
                            {/foreach}
                            <tr class="info">
                                <th><i class="fa fa-calculator fa-fw"></i> {$smarty.const.FIELD_FORMULA}</th>
                                <td>{$dato->calculo}</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
{/if}
<!-- /Indicadores/datos calculados -->

<!-- Indicadores/datos dependientes -->
{if $datos_dependientes}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-warning">
                <div class="panel-heading">
                    <span class="panel-title"><i class="fa fa-exclamation-triangle fa-fw"></i> {$smarty.const.TXT_INDIC_DAT_DEPENDIENTES}</span>
                    <i class="fa fa-chevron-up pull-right clickable"></i>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    {$smarty.const.TXT_INFLUYE}
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <tr>
                                <th>{$smarty.const.FIELD_ID}</th>
                                <th>{$smarty.const.FIELD_NOMBRE}</th>
                            </tr>
                            {foreach $datos_dependientes as $dato_dependiente}
                                {if $dato_dependiente->id_proceso}
                                    <tr>
                                        <td><span class="badge">{$dato_dependiente->id}</span></td>
                                        <td>
                                            <a class="btn btn-default btn-warning" href='index.php?page=dato_mostrar&id_dato={$dato_dependiente->id}&id_entidad={$entidad->id}' 
                                               title="{$smarty.const.TXT_INDIC_MOSTRAR}: {$dato_dependiente->nombre}">
                                                <i class="fa fa-dashboard fa-fw"></i> {$dato_dependiente->nombre}
                                            </a>
                                        </td>
                                    </tr>
                                {else}
                                    <tr>
                                        <td><span class="badge">{$dato_dependiente->id}</span></td>
                                        <td> 
                                            <a class="btn btn-default btn-warning" href='index.php?page=dato_mostrar&id_dato={$dato_dependiente->id}&id_entidad={$entidad->id}' 
                                               title="{$smarty.const.TXT_DATO_MOSTRAR}: {$dato_dependiente->nombre}">
                                                <i class="fa fa-database fa-fw"></i> {$dato_dependiente->nombre}
                                            </a>
                                        </td>
                                    </tr>
                                {/if}   
                            {/foreach}
                        </table>
                    </div>
                </div>
                <!-- /.panel-body --> 
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
{/if}
<!-- /Indicadores/datos dependientes -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-red">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-dashboard fa-fw"></i> {$smarty.const.TXT_DATO_PARAM}</span>
                <i class="fa fa-chevron-up pull-right clickable"></i>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <tbody>
                            <tr>
                                <th>{$smarty.const.FIELD_ID}</th>
                                <td><span class="badge">{$dato->id}</span></td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_COD}</th>
                                <td>{$dato->codigo}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_NOMBRE}</th>
                                <td>{$dato->nombre}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_DESC}</th>
                                <td> 
                                    {if $dato->descripcion != ""}
                                        {$dato->descripcion}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_HISTORICO}</th>
                                <td>{$dato->historicos}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_PERIOD}</th>
                                <td>{$dato->periodicidad}</td>
                            </tr>      
                            <tr title="{$smarty.const.TXT_CALCULO_TOTAL_ANUAL}">
                                <th>{$smarty.const.FIELD_CALC_TOTAL_ANUAL}</th>
                                <td>{$dato->tipo_agregacion_temporal->descripcion}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_OBSERV}</th>
                                <td> 
                                    {if $dato->observaciones != ""}
                                        {$dato->observaciones}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_RESP_SEG}</th>
                                <td> {$dato->responsable->nombre} {$dato->responsable->apellidos}
                                    {if $dato->responsable->puesto} - {$dato->responsable->puesto} {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_RESP_MED}</th>
                                <td> {$dato->responsable_medicion->nombre} {$dato->responsable_medicion->apellidos}
                                    {if $dato->responsable_medicion->puesto} - {$dato->responsable_medicion->puesto} {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_FUENTE_INFO}</th>
                                <td> 
                                    {if $dato->fuente_informacion != ""}
                                        {$dato->fuente_informacion}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_FUENTE_DAT}</th>
                                <td> 
                                    {if $dato->fuente_datos != ""}
                                        {$dato->fuente_datos}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_INTERVALO}</th>
                                <td>
                                    {if $dato->valor_min != NULL && $dato->valor_max != NULL}
                                        [{$dato->valor_min}, {$dato->valor_max}] 
                                    {else}
                                        {$smarty.const.TXT_NO_ASIG}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_VISIBILIDAD}</th>
                                <td>{$dato->visibilidad->nombre|htmlentities}</td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_UNID_GEN}</th>
                                <td> 
                                    {if $dato->unidad_generadora != ""}
                                        {$dato->unidad_generadora}
                                    {else}
                                        ---
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <th>{$smarty.const.FIELD_SUBUNID_AFECT}</th>
                                <td>
                                    {if $dato_subunidades}
                                        <ul>
                                            {foreach $dato_subunidades as $dato_subunidad}
                                                <li>
                                                    <a href="index.php?page=entidad_mostrar&id_entidad={$dato_subunidad->entidad->id}&principal=1">{$dato_subunidad->entidad->etiqueta}</a>
                                                </li>
                                            {/foreach}
                                        </ul>
                                    {else}
                                        {$smarty.const.MSG_INDIC_NO_SUBUNID_ASIG}
                                    {/if}
                                </td>
                            </tr>
                            <tr title="{$smarty.const.TXT_CALCULO_TOTAL}">
                                <th>{$smarty.const.FIELD_CALC_TOTAL}</th>
                                <td>{$dato->tipo_agregacion->descripcion}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- /.panel-body -->        
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->