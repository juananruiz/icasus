<div class="box grid_16">
    <div class="toggle_container">
        <div class="block">
            <form action="index.php?page=cuadro_grabar" method="post" id="formcuadro" name="formcuadro" class="validate_form">
                <input type="hidden" name="id" value="{$cuadro->id}" />

                <fieldset class="label_side">
                    <label>{$smarty.const.FIELD_NOMBRE_CUADRO}</label>
                    <div>
                        <input name="nombre"class="required" type="text" value="{$cuadro->nombre}">
                        <div class="required_tag tooltip hover left" title="{$smarty.const.MSG_FIELD_REQ}"></div>
                    </div>
                </fieldset>

                <fieldset class="label_side">
                    <label>{$smarty.const.FIELD_COMENTARIOS}</label>
                    <div><textarea  class="inp" name="comentarios">{$cuadro->comentarios}</textarea></div>
                </fieldset>

                <fieldset class="label_side">
                    <label>{$smarty.const.FIELD_VISIBILIDAD}</label>
                    <div>
                        <label class="radio">
                            <input type="radio" name="privado" id="privado1" value="0" {if $cuadro->privado == 0}checked{/if}>
                            {$smarty.const.TXT_PUBLICO}
                        </label>
                        <label class="radio">
                            <input type="radio" name="privado" id="privado2" value="1" {if $cuadro->privado == 1}checked{/if}>
                            {$smarty.const.TXT_PRIVADO}
                        </label>
                    </div>
                </fieldset>

                <div class="button_bar clearfix">
                    <button class="light send_left" type="reset" value="{$smarty.const.TXT_CANCEL}" name="proceso_cancel" 
                            onclick="history.back();">
                        <div class="ui-icon ui-icon-closethick"></div>
                        <span>{$smarty.const.TXT_CANCEL}</span>
                    </button>
                    <button class="green send_right" type="submit" value="{$smarty.const.TXT_GRABAR}" name="indicador_submit">
                        <span>{$smarty.const.TXT_GRABAR}</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
