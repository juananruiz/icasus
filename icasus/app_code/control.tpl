<!-- Diálogo cargando datos de control -->
<div class="modal fade" id="dialogo_cargando_control" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title" id="myModalLabel"><i class="fa fa-sliders fa-fw"></i> {$smarty.const.TXT_CONTROL}: {$entidad->nombre}</h3>
            </div>
            <div class="modal-body">
                <h4 class="text-center"><i class="fa fa-spinner fa-pulse"></i> {$smarty.const.MSG_CONTROL_CARGA}</h4>
            </div>
        </div>
    </div>
</div>
<!-- /Diálogo cargando datos de control -->

{if $modulo == 'inicio'}
    <!-- Nombre página -->
    <div class="row">
        <div class="col-lg-12">
            <h3 title="{$_nombre_pagina}" class="page-header">
                <i class="fa fa-sliders fa-fw"></i> {$_nombre_pagina}
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
                                <i class="fa fa-gears fa-fw"></i> {$smarty.const.FIELD_PROCS} <span title="{$smarty.const.FIELD_TOTAL}: {$num_procesos} {$smarty.const.FIELD_PROCS}">({$num_procesos})</span>
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
                                <i class="fa fa-th fa-fw"></i> {$smarty.const.FIELD_CUADROS_MANDO} <span title="{$smarty.const.FIELD_TOTAL}: {$num_cuadros} {$smarty.const.FIELD_CUADROS_MANDO}">({$num_cuadros})</span>
                            </a>
                        </li>
                        <li>
                            <a title="{$smarty.const.TXT_CONSULTA_DESCRIPCION}" href="index.php?page=consulta_avanzada&id_entidad={$entidad->id}">
                                <i class="fa fa-commenting fa-fw"></i> {$smarty.const.TXT_CONSULT}
                            </a>
                        </li>   
                        <li>
                            <a title="{$smarty.const.TXT_CONTROL_DESCRIPCION}" href="index.php?page=control&modulo=inicio&id_entidad={$entidad->id}">
                                <i class="fa fa-sliders fa-fw"></i> {$smarty.const.TXT_CONTROL}
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-menu -->
                </li>
                <!-- /.dropdown -->
                <li title="{$_nombre_pagina}" class="active">{$_nombre_pagina}</li>
            </ol>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <!-- /Breadcrumbs -->

    <!-- Selección del año de consulta -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-red">
                <div class="panel-heading">
                    <span class="panel-title"><i class="fa fa-calendar fa-fw"></i> {$smarty.const.FIELD_PERIODO}</span>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="alert alert-info">
                        <i class="fa fa-info-circle fa-fw"></i> 
                        {$smarty.const.MSG_CONTROL_INFO}
                    </div>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-1 control-label">{$smarty.const.FIELD_ANYO}</label>
                            <div id="periodo" class="col-sm-4" data-id_entidad="{$entidad->id}">
                                {html_select_date id="Year" prefix="" all_extra="class='form-control chosen-select'"
                                            display_months=FALSE display_days=FALSE start_year=($smarty.now|date_format:"%Y")-9
                                            end_year=$smarty.now|date_format:"%Y" time='' reverse_years=TRUE}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.panel-body --> 
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <!-- /Selección del año de consulta -->

    <div class="row">
        <div class="col-lg-12">
            <div id="datos_control">
                {include file="control_valores.tpl"}
            </div>
            <!-- /#datos_control -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
{/if}

{if $modulo == 'filtrOnlyear'}
    {include file="control_valores.tpl"}
{/if}