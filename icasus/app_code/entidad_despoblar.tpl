<div class="box grid_16 single_datatable">
  <form action='index.php?page=entidad_despoblar' method='post' class='formdiv' name='formdiv'>
    <input type='hidden' name='id_entidad' value='{$entidad->id}' />
    <div id="dt1" class="no_margin">
      <table class="display datatable">
      <thead>
      <tr><th></th><th>Nombre</th><th>Apellidos</th><th>Correo</th></tr>
      </thead>
      <tbody>
      {foreach from=$usuarios item=usuario}
      <tr class="gradex">
      <td><input type='checkbox' name='id_usuario[]' value='{$usuario->id_usuario}' /></td>
      <td>{$usuario->usuario->nombre}</td>
      <td>{$usuario->usuario->apellidos}</td>
      <td><a href='mailto:{$usuario->usuario->correo}'>{$usuario->usuario->correo}</a></td>
      </tr>
      {/foreach}
      </tbody>
      </table>			    
    </div>
    <div class="button_bar clearfix">
      <button class="green" type="submit" value="" name="enviar">
        <span>Desasignar usuarios marcados</span>
      </button>
    </div>
  </form>
</div>
