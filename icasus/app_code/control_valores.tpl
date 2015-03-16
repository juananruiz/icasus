<!-- Indicadores/Datos con Valores nulos agrupados -->
<h2 id="tabla_agrupados" class="box_head grad_grey_dark">{$smarty.const.TXT_INDIC_DAT_MED_NULA_AGRUPADOS}</h2>
<table class="display datatable"> 
    <thead>
        <tr>
            <th>{$smarty.const.FIELD_PROC}</th>
            <th>{$smarty.const.FIELD_UNIDS}</th>
            <th>{$smarty.const.FIELD_INDIC} / {$smarty.const.TXT_DATO}</th>
            <th>{$smarty.const.FIELD_RESP}</th>
            <th>{$smarty.const.FIELD_FECHA}</th>
            <th>{$smarty.const.FIELD_VAL}</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$valores_agrupados item=valor}
            <tr>
                <td>
                    {if $valor.cod_proceso == ''}
                        {$smarty.const.FIELD_DATOS}
                    {else}
                        <span style="display:none">{$valor.proceso}</span> 
                        <a href="index.php?page=proceso_mostrar&id_proceso={$valor.id_proceso}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_PROC_VER}">
                            {$valor.cod_proceso}
                        </a>
                    {/if}
                </td>
                <td>{$valor.subunidades}</td>
                <td>
                    {if $valor.cod_proceso==''}
                        <a href="index.php?page=dato_mostrar&id_dato={$valor.id_indicador}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_INDIC_IR}">{$valor.indicador}</a>
                    {else}
                        <a href="index.php?page=indicador_mostrar&id_indicador={$valor.id_indicador}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_INDIC_IR}">{$valor.indicador}</a>
                    {/if}
                </td>
                <td>{$valor.nombre_responsable} {$valor.apellidos_responsable}</td>
                <td>{$valor.fecha}</td>
                <td>{if $valor.valor == NULL}
                    <a href="index.php?page=medicion_editar&id_entidad={$valor.entidad_del_indicador}&id_medicion={$valor.id_medicion}&tipo={if $valor.cod_proceso == ''}dato{else}indicador{/if}" title="{$smarty.const.TXT_MED_VER}">{$smarty.const.TXT_NULO}</a>{/if}
                </td>
            </tr>
        {/foreach}
    </tbody>	
</table>
<!-- //Indicadores/Datos con Valores nulos agrupados -->

<!-- Indicadores/Datos con Valores nulos -->
<h2 id="tabla_nulos" class="box_head grad_grey_dark">{$smarty.const.TXT_INDIC_DAT_MED_NULA}</h2>
<form action='index.php?page=control&modulo=inicio&id_entidad={$entidad->id}' method='post' class='formdiv' name='formdiv' onsubmit="return confirm('{$smarty.const.MSG_VALS_CONFIRM_DESACT}');">
    <div class="button_bar clearfix">
        <button class="green send_left" type="submit" value="" name="enviar">
            <span>{$smarty.const.TXT_VALS_DESACT}</span>
        </button>
    </div>
    <table class="display datatable"> 
        <thead>
            <tr>
                <th>{$smarty.const.TXT_DESACT}</th>
                <th>{$smarty.const.FIELD_PROC}</th>
                <th>{$smarty.const.FIELD_UNID}</th>
                <th>{$smarty.const.FIELD_INDIC} / {$smarty.const.TXT_DATO}</th>
                <th>{$smarty.const.FIELD_FECHA}</th>
                <th>{$smarty.const.FIELD_VAL}</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$valores item=valor}
                <tr>
                    <td style="text-align: center"><input type='checkbox' name='id_valor[]' value='{$valor.id_valor}'/></td>
                    <td>
                        {if $valor.cod_proceso == ''}
                            {$smarty.const.FIELD_DATOS}
                        {else}
                            <span style="display:none">{$valor.proceso}</span> 
                            <a href="index.php?page=proceso_mostrar&id_proceso={$valor.id_proceso}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_PROC_VER}">
                                {$valor.cod_proceso}
                            </a>
                        {/if}
                    </td>
                    <td>{$valor.unidad}</td>
                    <td>
                        {if $valor.cod_proceso==''}
                            <a href="index.php?page=dato_mostrar&id_dato={$valor.id_indicador}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_INDIC_IR}">{$valor.indicador}</a>
                        {else}
                            <a href="index.php?page=indicador_mostrar&id_indicador={$valor.id_indicador}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_INDIC_IR}">{$valor.indicador}</a>
                        {/if}
                    </td>
                    <td>{$valor.fecha}</td>
                    <td>{if $valor.valor == NULL}
                        <a href="index.php?page=medicion_editar&id_entidad={$valor.entidad_del_indicador}&id_medicion={$valor.id_medicion}&tipo={if $valor.cod_proceso == ''}dato{else}indicador{/if}" title="{$smarty.const.TXT_MED_VER}">{$smarty.const.TXT_NULO}</a>{/if}
                    </td>
                </tr>
            {/foreach}
        </tbody>	
    </table>
</form>
<!-- //Indicadores/Datos con Valores nulos -->

<!-- Indicadores/Datos última modificación -->
<h2 id="tabla_modificados" class="box_head grad_grey_dark">{$smarty.const.TXT_INDIC_DAT_ULTIMA_MOD}</h2>
<table class="display datatable"> 
    <thead>
        <tr>
            <th>{$smarty.const.FIELD_PROC}</th> 
            <th>{$smarty.const.FIELD_UNID}</th>
            <th>{$smarty.const.FIELD_INDIC} / {$smarty.const.TXT_DATO}</th>
            <th>{$smarty.const.FIELD_FECHA}</th>
            <th>{$smarty.const.FIELD_FECHA_RECOGIDA}</th>
            <th>{$smarty.const.FIELD_VAL}</th>
        </tr>
    </thead>
    <tbody>
        {foreach from= $valores_ult_mod item=valor}
            <tr>
                <td>
                    {if $valor.cod_proceso == ''}
                        {$smarty.const.FIELD_DATOS}
                    {else}
                        <span style="display:none">{$valor.proceso}</span> 
                        <a href="index.php?page=proceso_mostrar&id_proceso={$valor.id_proceso}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_PROC_VER}">
                            {$valor.cod_proceso}
                        </a>
                    {/if}
                </td>
                <td>{$valor.unidad}</td>
                <td>
                    {if $valor.cod_proceso==''}
                        <a href="index.php?page=dato_mostrar&id_dato={$valor.id_indicador}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_INDIC_IR}">{$valor.indicador}</a>
                    {else}
                        <a href="index.php?page=indicador_mostrar&id_indicador={$valor.id_indicador}&id_entidad={$valor.entidad_del_indicador}" title="{$smarty.const.TXT_INDIC_IR}">{$valor.indicador}</a>
                    {/if}
                </td>
                <td>{$valor.fecha}</td>
                <td>{$valor.fecha_recogida|date_format:"%d-%m-%Y"}</td>
                <td>
                    <a href="index.php?page=medicion_editar&id_entidad={$valor.entidad_del_indicador}&id_medicion={$valor.id_medicion}&tipo={if $valor.cod_proceso == ''}dato{else}indicador{/if}" title="{$smarty.const.TXT_MED_VER}">{$valor.valor}</a>
                </td>
            </tr>
        {/foreach}
    </tbody>	
</table>
<!-- //Indicadores/Datos última modificación -->

<!-- Indicadores/Datos sin Mediciones -->
<h2 id="tabla_sin_med" class="box_head grad_grey_dark">{$smarty.const.TXT_INDIC_DAT_SIN_MED}</h2>
<table class="display datatable"> 
    <thead>
        <tr>
            <th>{$smarty.const.FIELD_PROC}</th>        
            <th>{$smarty.const.FIELD_INDIC} / {$smarty.const.TXT_DATO}</th>
            <th>{$smarty.const.FIELD_FECHA}</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$indicadores_sin_med item=indicador}
            <tr>
                <td>
                    {if $indicador.cod_proceso == ''}
                        {$smarty.const.FIELD_DATOS}
                    {else}
                        <a href="index.php?page=proceso_mostrar&id_proceso={$indicador.id_proceso}&id_entidad={$indicador.id_entidad}" title="{$smarty.const.TXT_PROC_VER}">
                            {$indicador.proceso}
                        </a>
                    {/if}
                </td>
                <td>
                    {if $indicador.cod_proceso==''}
                        <a href="index.php?page=dato_mostrar&id_dato={$indicador.id_indicador}&id_entidad={$indicador.id_entidad}" title="{$smarty.const.TXT_INDIC_IR}">{$indicador.indicador}</a>
                    {else}
                        <a href="index.php?page=indicador_mostrar&id_indicador={$indicador.id_indicador}&id_entidad={$indicador.id_entidad}" title="{$smarty.const.TXT_INDIC_IR}">{$indicador.indicador}</a>
                    {/if}
                </td>
                <td>{$fecha}</td>
            </tr>
        {/foreach}
    </tbody>	
</table>
<!-- //Indicadores/Datos sin Mediciones -->