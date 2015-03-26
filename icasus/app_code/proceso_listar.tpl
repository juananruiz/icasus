<h3>
    {if $_control}
        <a href="index.php?page=proceso_crear&id_entidad={$entidad->id}">
            <img src='/icons/ff16/cog_add.png' /> {$smarty.const.TXT_PROC_CREAR}
        </a> 
    {/if}
</h3>

{if $procesos} 
    <div class="box grid_16">
        <div class="block">	
            <div id="dt1" class="no_margin">
                <table class="display datatable"> 
                    <thead>                       
                        <tr class="gradeX">
                            <th>{$smarty.const.FIELD_COD}</th>
                            <th>{$smarty.const.FIELD_TIPO_PROC}</th>
                            <th>{$smarty.const.FIELD_PROC_MADRE}</th>
                            <th>{$smarty.const.FIELD_NOMBRE}</th>
                            <th>{$smarty.const.FIELD_PROPIETARIO}</th>
                            <th>{$smarty.const.FIELD_ACCIONES}</th>
                        </tr>
                    </thead>                      
                    <tbody>                       
                        {foreach from=$procesos item=proceso}
                            <tr class="gradeX">    
                                <td nowrap>{$proceso->codigo}</td>
                                <td nowrap>{$proceso->alcance}</td>
                                <td>
                                    {if $proceso->madre->id > 0}
                                        <a title="{$smarty.const.TXT_PROC_VER}" href="index.php?page=proceso_mostrar&id_proceso={$proceso->madre->id}&id_entidad={$proceso->madre->id_entidad}">
                                            {$proceso->madre->nombre}
                                        </a>
                                    {else}
                                        {$smarty.const.TXT_PROC_ES_MADRE}
                                    {/if}
                                </td>
                                <td><a title="{$smarty.const.TXT_PROC_VER}" href="index.php?page=proceso_mostrar&id_proceso={$proceso->id}&id_entidad={$proceso->id_entidad}">
                                        <img src='/icons/ff16/cog.png' alt='{$smarty.const.TXT_ICON}'/> {$proceso->nombre}
                                    </a>
                                </td>
                                <td>
                                    <a title="{$smarty.const.TXT_USER_VER}" href="index.php?page=usuario_mostrar&id_usuario={$proceso->propietario->id}">{$proceso->propietario->nombre}
                                        {$proceso->propietario->apellidos}</a>
                                </td>
                                <td width="10%">
                                    {if $_control}
                                        <a href='index.php?page=proceso_editar&id_proceso={$proceso->id}&id_entidad={$proceso->id_entidad}'>
                                            <img title="{$smarty.const.TXT_EDIT}" src='/icons/ff16/cog_edit.png' alt='{$smarty.const.TXT_ICON}' />
                                        </a>&nbsp;
                                        <a href='index.php?page=proceso_borrar&id_proceso={$proceso->id}&id_entidad={$proceso->id_entidad}'
                                           onClick="return confirm('{$smarty.const.MSG_PROC_CONFIRM_BORRAR}');">
                                            <img title="{$smarty.const.TXT_BORRAR}" src='/icons/ff16/cog_delete.png' alt='{$smarty.const.TXT_ICON}' />
                                        </a>&nbsp;
                                    {/if}
                                    <a href='index.php?page=archivo_gestionar&id_proceso={$proceso->id}&id_entidad={$proceso->id_entidad}'>
                                        <img title="{$smarty.const.TXT_ARCHIVOS}" src='/icons/ff16/box.png' alt='{$smarty.const.TXT_ICON}' />
                                    </a>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>	
{else}
    <div class="alert alert_blue">
        <img height="24" width="24" src="theme/danpin/images/icons/small/white/alert_2.png">
        {$smarty.const.MSG_UNID_NO_PROC}
    </div>
{/if}


{if $entidad->id == 14}
    <div class="box grid_16">
        <div style="border:1px solid silver; padding:5px;">
            <img src="images/mapa_procesos_biblioteca.png" border="0" usemap="#Map" style="text-align:center;" />
            <map name="Map" id="Map">
                <area shape="rect" coords="96,66,263,94" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1920" />
                <area shape="rect" coords="355,66,475,93" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1921" />
                <area shape="rect" coords="287,169,362,190" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1913" />
                <area shape="rect" coords="277,200,368,225" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1914" />
                <area shape="rect" coords="197,264,272,301" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1915" />
                <area shape="rect" coords="330,260,438,284" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1916" />
                <area shape="rect" coords="330,286,437,311" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1917" />
                <area shape="rect" coords="248,349,324,375" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1918" />
                <area shape="rect" coords="328,349,398,374" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1919" />
                <area shape="rect" coords="42,386,156,432" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1907" />
                <area shape="rect" coords="164,387,256,480" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1922" />
                <area shape="rect" coords="265,388,389,431" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1923" />
                <area shape="rect" coords="393,387,484,432" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1911" />
                <area shape="rect" coords="492,387,595,432" href="index.php?page=proceso_mostrar&id_entidad=14&id_proceso=1912" />
            </map>                                                                                      
        </div>
    </div>
{/if}

