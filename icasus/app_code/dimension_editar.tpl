{if $aviso}<p class='aviso'>{$aviso}</p>{/if}
{if $error}<p class='error'>{$error}</p>{/if}
<h2>{$smarty.const.TXT_DIM_EDIT}</h2>

<form action='index.php?page=dimension_editar' method="post" class="datos" name="formeditar">
    <input type='hidden' name='id' value='{$dimension->id}' />
    <p><label for='nombre'>{$smarty.const.FIELD_NOMBRE}</label> 
        <input name='nombre' class='inp' value='{$dimension->nombre}' /></p>
    <p><input type='submit' name='submitcrear' value='{$smarty.const.TXT_BTN_ACEPTAR}' /></p>
</form>
