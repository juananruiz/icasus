<!-- Nombre página -->
<div class="row">
    <div class="col-lg-12">
        <h2 title="{$_nombre_pagina}" class="page-header">
            <i class="fa fa-plus-circle fa-fw"></i> {$_nombre_pagina}
        </h2>
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
                <a class="btn btn-default btn-danger" href="index.php?page=proceso_listar&id_entidad={$entidad->id}" title="{$smarty.const.TXT_PROCS_VOLVER}">
                    <i class="fa fa-arrow-left fa-fw"></i> {$smarty.const.TXT_PROCS_VOLVER}</a>
            </div>
        </div>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<br>
<!-- /Barra de botones -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-red">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-gear fa-fw"></i> {$smarty.const.TXT_PROC_PARAM}</span>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <form id="proceso_crear" method="post" action="index.php?page=proceso_grabar" data-toggle="validator" class="form-horizontal">
                    <input type="hidden" name="id_entidad" value="{$entidad->id}" />
                    <div class="form-group has-feedback">
                        <label for="codigo" class="col-sm-2 control-label">{$smarty.const.FIELD_COD} <i title="{$smarty.const.MSG_CAMPO_REQ}" class="fa fa-asterisk fa-fw"></i></label>
                        <div class="col-sm-8">
                            <input title="{$smarty.const.TXT_CODIGO}" type='text' name='codigo' id='codigo' 
                                   pattern="[A-Z]+[.]*[A-Z]*[0-9]*[.]*[0-9]*([-]*[A-Z]*[.]*[A-Z]*[0-9]*[.]*[0-9]*)*"
                                   class="form-control" placeholder="{$smarty.const.FIELD_COD}" required/>
                            <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label for="nombre" class="col-sm-2 control-label">{$smarty.const.FIELD_NOMBRE} <i title="{$smarty.const.MSG_CAMPO_REQ}" class="fa fa-asterisk fa-fw"></i></label>
                        <div class="col-sm-8">
                            <input type='text' class="form-control" name='nombre' id='nombre' placeholder="{$smarty.const.FIELD_NOMBRE}" required/>
                            <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label for="revision" class="col-sm-2 control-label">{$smarty.const.FIELD_VERSION} <i title="{$smarty.const.MSG_CAMPO_REQ}" class="fa fa-asterisk fa-fw"></i></label>
                        <div class="col-sm-8">
                            <input type='text' class="form-control" name='revision' id='revision' placeholder="{$smarty.const.TXT_PROC_VERSION}" required/>
                            <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label for="fecha_revision" class="col-sm-2 control-label">{$smarty.const.FIELD_FECHA} <i title="{$smarty.const.MSG_CAMPO_REQ}" class="fa fa-asterisk fa-fw"></i></label>
                        <div class="col-sm-8">
                            <div class="input-group date" data-provide="datepicker" data-date-language="es" data-date-autoclose="true">
                                <div class="input-group-addon"><i class="fa fa-calendar fa-fw"></i></div>
                                <input type='date' class="form-control" name='fecha_revision' id='fecha_revision' placeholder="{$smarty.const.TXT_FECHA_REV_ACTUAL}" data-validar_fecha="validar_fecha" required/>
                            </div>
                            <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="alcance" class="col-sm-2 control-label">{$smarty.const.FIELD_TIPO_PROC}</label>
                        <div class="col-sm-8">
                            <select class="form-control chosen-select" name='alcance' id='alcance'>
                                <option value="Indefinido">{$smarty.const.TXT_INDEF}</option>
                                <option value="Apoyo">{$smarty.const.TXT_APOYO}</option>
                                <option value="Operativo">{$smarty.const.TXT_OPERATIVO}</option>
                                <option value="Directivo/Gestion">{$smarty.const.TXT_DIR_GES}</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="madre" class="col-sm-2 control-label">{$smarty.const.FIELD_PROC_MADRE}</label>
                        <div class="col-sm-8">
                            <select class="form-control chosen-select" name='madre' id='madre'>
                                <option value="0">{$smarty.const.TXT_PROC_ES_MADRE}</option>
                                {foreach from=$procesos_madre item=proceso_madre}
                                    <option value="{$proceso_madre->id}">
                                        {$proceso_madre->codigo} - {$proceso_madre->nombre}
                                    </option>
                                {/foreach} 
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="id_propietario" class="col-sm-2 control-label">{$smarty.const.FIELD_PROPIETARIO}</label>
                        <div class="col-sm-8">
                            <select class="form-control chosen-select" name='id_propietario' id='id_propietario'>
                                {foreach from=$usuarios_entidad item=usuario_entidad}
                                    <option value="{$usuario_entidad->usuario->id}">{$usuario_entidad->usuario->nombre} {$usuario_entidad->usuario->apellidos} {if $usuario_entidad->usuario->puesto} - {$usuario_entidad->usuario->puesto} {/if}
                                    </option>
                                {/foreach}  
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="mision" class="col-sm-2 control-label">{$smarty.const.FIELD_MISION}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="mision" name="mision" placeholder="{$smarty.const.FIELD_MISION}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="equipo_de_proceso" class="col-sm-2 control-label">{$smarty.const.FIELD_EQUIP_PROC}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="equipo_de_proceso" name="equipo_de_proceso" placeholder="{$smarty.const.FIELD_EQUIP_PROC}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="resultados_clave" class="col-sm-2 control-label">{$smarty.const.FIELD_RESULTS_CLAVE}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="resultados_clave" name="resultados_clave" placeholder="{$smarty.const.FIELD_RESULTS_CLAVE}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="entradas" class="col-sm-2 control-label">{$smarty.const.FIELD_ENTRADAS_PROV}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="entradas" name="entradas" placeholder="{$smarty.const.FIELD_ENTRADAS_PROV}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="salidas" class="col-sm-2 control-label">{$smarty.const.FIELD_SALIDAS_CLIENTS}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="salidas" name="salidas" placeholder="{$smarty.const.FIELD_SALIDAS_CLIENTS}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="actividades" class="col-sm-2 control-label">{$smarty.const.FIELD_ACTIVIDADES}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="actividades" name="actividades" placeholder="{$smarty.const.FIELD_ACTIVIDADES}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="variables_control" class="col-sm-2 control-label">{$smarty.const.FIELD_VARS_CONTROL}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="variables_control" name="variables_control" placeholder="{$smarty.const.FIELD_VARS_CONTROL}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="documentacion" class="col-sm-2 control-label">{$smarty.const.FIELD_DOCUMENTACION}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="documentacion" name="documentacion" placeholder="{$smarty.const.FIELD_DOCUMENTACION}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="mediciones" class="col-sm-2 control-label">{$smarty.const.FIELD_MEDICIONES}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" id="mediciones" name="mediciones" placeholder="{$smarty.const.FIELD_MEDICIONES}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="registros" class="col-sm-2 control-label">{$smarty.const.FIELD_REGISTROS}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" name="registros" id="registros" placeholder="{$smarty.const.FIELD_REGISTROS}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="observaciones" class="col-sm-2 control-label">{$smarty.const.FIELD_OBSERV}</label>
                        <div class="col-sm-8">
                            <textarea  class="form-control" name="observaciones" id="observaciones" placeholder="{$smarty.const.FIELD_OBSERV}"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-8">
                            <button type="button" class="btn btn-default btn-danger" title="{$smarty.const.TXT_CANCEL}" onclick="location.href = 'index.php?page=proceso_listar&id_entidad={$entidad->id}';">
                                <i class="fa fa-times fa-fw"></i> {$smarty.const.TXT_CANCEL}
                            </button>
                            <div class="pull-right">
                                <button type="reset" class="btn btn-default btn-warning" title="{$smarty.const.TXT_RESET}">
                                    <i class="fa fa-refresh fa-fw"></i> {$smarty.const.TXT_RESET}
                                </button>
                                <button title="{$smarty.const.TXT_GRABAR}" type="submit" class="btn btn-default btn-success">
                                    <i class="fa fa-download fa-fw"></i> {$smarty.const.TXT_GRABAR}
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- /.panel-body --> 
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->