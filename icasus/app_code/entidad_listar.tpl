<!-- Nombre página -->
<div class="row">
    <div class="col-lg-12">
        <h2 title="{$_nombre_pagina}" class="page-header">
            <i class="fa fa-sitemap fa-fw"></i> {$_nombre_pagina}
        </h2>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<!-- /Nombre página -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-red">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-sitemap fa-fw"></i> {$smarty.const.TXT_USER_UNIDS}</span>
                <i class="fa fa-chevron-up pull-right clickable"></i>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                {if $entidades_usuario }
                    <div class="table-responsive">
                        <table class="table datatable table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>{$smarty.const.FIELD_COD}</th>
                                    <th>{$smarty.const.FIELD_UNID}</th>
                                    <th>{$smarty.const.FIELD_ROL}</th>
                                    <th>{$smarty.const.FIELD_ACCIONES}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$entidades_usuario item=entidad}
                                    <tr>
                                        <td style="white-space:nowrap">{$entidad->entidad->codigo}</td>
                                        <td><a title="{$entidad->entidad->nombre}" href='index.php?page=entidad_datos&id_entidad={$entidad->entidad->id}'>{$entidad->entidad->nombre}</a></td>
                                        <td>{$entidad->rol->nombre}</td>
                                        <td style="white-space:nowrap">
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_UNID_FICHA}" href='index.php?page=entidad_datos&id_entidad={$entidad->entidad->id}'><i class="fa fa-folder fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_PROCS}" href='index.php?page=proceso_listar&id_entidad={$entidad->entidad->id}'><i class="fa fa-gears fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.FIELD_INDICS}" href='index.php?page=indicador_listar&id_entidad={$entidad->entidad->id}'><i class="fa fa-dashboard fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.FIELD_DATOS}" href='index.php?page=dato_listar&id_entidad={$entidad->entidad->id}'><i class="fa fa-database fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_CONSULT}" href='index.php?page=consulta_avanzada&id_entidad={$entidad->entidad->id}'><i class="fa fa-commenting fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_CUAD_RES}" href='index.php?page=cuadro_unidad&id_entidad={$entidad->entidad->id}'><i class="fa fa-th-list fa-fw"></i></a>
                                                {if $entidad->rol->id == 1 OR $entidad->rol->id == 2}
                                                <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_CONTROL}" href='index.php?page=control&modulo=inicio&id_entidad={$entidad->entidad->id}'><i class="fa fa-sliders fa-fw"></i></a>      
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
                        {$smarty.const.MSG_UNID_NO_ASIG}
                    </div>
                {/if}
            </div>
            <!-- /.panel-body -->        
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-red">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-sitemap fa-fw"></i> {$smarty.const.TXT_UNID_TODAS}</span>
                <i class="fa fa-chevron-up pull-right clickable"></i>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                {if isset($entidades)}
                    <div class="table-responsive">
                        <table class="table datatable table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>{$smarty.const.FIELD_COD}</th>
                                    <th>{$smarty.const.FIELD_UNID}</th>
                                    <th>{$smarty.const.FIELD_ACCIONES}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$entidades item=entidad}
                                    <tr>
                                        <td style="white-space:nowrap">{$entidad->codigo}</td>
                                        <td><a title="{$entidad->nombre}" href='index.php?page=entidad_datos&id_entidad={$entidad->id}'>{$entidad->nombre}</a></td>
                                        <td style="white-space:nowrap">
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_UNID_FICHA}" href='index.php?page=entidad_datos&id_entidad={$entidad->id}'><i class="fa fa-folder fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_PROCS}" href='index.php?page=proceso_listar&id_entidad={$entidad->id}'><i class="fa fa-gears fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.FIELD_INDICS}" href='index.php?page=indicador_listar&id_entidad={$entidad->id}'><i class="fa fa-dashboard fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.FIELD_DATOS}" href='index.php?page=dato_listar&id_entidad={$entidad->id}'><i class="fa fa-database fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_CONSULT}" href='index.php?page=consulta_avanzada&id_entidad={$entidad->id}'><i class="fa fa-commenting fa-fw"></i></a>
                                            <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_CUAD_RES}" href='index.php?page=cuadro_unidad&id_entidad={$entidad->id}'><i class="fa fa-th-list fa-fw"></i></a>
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                {else}
                    <div class="alert alert-info alert-dismissible">
                        <i class="fa fa-info-circle fa-fw"></i> 
                        {$smarty.const.MSG_UNIDS_NO_EXISTEN}
                    </div>
                {/if}
            </div>
            <!-- /.panel-body -->        
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->