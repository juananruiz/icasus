<!-- Nombre página -->
<div class="row">
    <div class="col-lg-12">
        <h3 title="{$_nombre_pagina}" class="page-header">
            <i class="fa fa-users fa-fw"></i> {$_nombre_pagina}
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
            <li title="{$_nombre_pagina}" class="active">{$_nombre_pagina}</li>
        </ol>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<!-- /Breadcrumbs -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-red">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-users fa-fw"></i> {$smarty.const.TXT_USER_LIST}</span>
                <i class="fa fa-chevron-up pull-right clickable"></i>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">        
                <div class="table-responsive">
                    <table class="table datatable table-striped table-hover">
                        <thead>
                            <tr>
                                <th>{$smarty.const.FIELD_LOGIN}</th>
                                <th>{$smarty.const.FIELD_NOMBRE}</th>
                                <th>{$smarty.const.FIELD_APEL}</th>
                                <th>{$smarty.const.FIELD_CORREO}</th>
                                <th>{$smarty.const.FIELD_TEL}</th>
                                <th>{$smarty.const.FIELD_ACCIONES}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$usuarios item=usuario}
                                <tr>  
                                    <td> 
                                        <a title="{$smarty.const.TXT_USER_PERFIL}" href='index.php?page=usuario_mostrar&id_usuario={$usuario->id}'>
                                            {$usuario->login}
                                        </a>
                                    </td>
                                    <td>{$usuario->nombre}</td>
                                    <td>{$usuario->apellidos}</td>       
                                    <td><a title="{$smarty.const.TXT_ENVIAR_CORREO}" href='mailto:{$usuario->correo}'>{$usuario->correo}</a></td>
                                    <td><a title="{$smarty.const.TXT_LLAMAR_TLF}" href='tel:+34{$usuario->telefono}'>{$usuario->telefono}</a></td>
                                    <td style="white-space:nowrap">
                                        <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_USER_PERFIL}" href='index.php?page=usuario_mostrar&id_usuario={$usuario->id}'><i class="fa fa-user fa-fw"></i></a>                 
                                        <a class="btn btn-default btn-circle btn-xs" title="{$smarty.const.TXT_ENVIAR_CORREO}" href='mailto:{$usuario->correo}'><i class="fa fa-envelope fa-fw"></i></a>
                                    </td>
                                </tr>
                            {/foreach}
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