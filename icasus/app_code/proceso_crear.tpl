
<div class="box grid_16">
	<div class="toggle_container">
		<div class="block">
			<form method="post" action="index.php?page=proceso_grabar" class="validate_form">
			  <input type="hidden" name="id_entidad" value="{$entidad->id}" />

			
			  <fieldset class="label_side">
				<label>Proceso madre</label>
				<div>
					<select name="madre" class="required select_box">
					  <option value="0">Es un Proceso Madre</option>
					  {foreach from=$procesos_madre item=proceso_madre}
					    <option value="{$proceso_madre->id}">
					    {$proceso_madre->codigo} - {$proceso_madre->nombre}</option>
					  {/foreach} 
					  </select>
				</div>
			  </fieldset> 
			  <fieldset class="label_side">
				<label>Nombre proceso</label>
				<div>
					<input type="text" name="nombre" class="required" />
					<div class="required_tag"></div>
				</div>
			  </fieldset> 
        <div class="columns clearfix">
          <div class="col_33">
            <fieldset>
              <label>C&oacute;digo</label>
              <div>
                <input type="text" name="codigo" placeholder="Indique un código estandarizado y único" class="required" />
                <div class="required_tag"></div>
              </div>
            </fieldset> 
          </div>
          <div class="col_33">
            <fieldset>
            <label>Versi&oacute;n</label>
            <div>
              <input type="text" name="revision" placeholder="Número de la versión actual de la ficha de proceso"  class="required" />
              <div class="required_tag"></div>
            </div>
            </fieldset>  
          </div>
          <div class="col_33">
            <fieldset>
            <label>Fecha</label>
            <div>
              <input type="text" name="fecha_revision" placeholder="Fecha de la revisión actual" class="required" />
              <div class="required_tag"></div>
            </div>
            </fieldset>  
          </div>
        </div>
        <div class="columns clearfix">
          <div class="col_50">
            <fieldset>
            <label>Propietario</label>
              <div>
                <select name="id_propietario" class="select_box">
                  {foreach from=$usuarios_entidad item=usuario_entidad}
                    <option value="{$usuario_entidad->usuario->id}">{$usuario_entidad->usuario->nombre} {$usuario_entidad->usuario->apellidos} {if $usuario_entidad->usuario->puesto} - {$usuario_entidad->usuario->puesto} {/if}
                    </option>
                  {/foreach}              
                  </select>
            </div>
            </fieldset> 
          </div>
          <div class="col_50">
            <fieldset>
              <label>Tipo de proceso</label>
              <div>
                <select name="alcance" class="select_box">
                    <option value="Indefinido">Indefinido ...</option>
                  <option value="Apoyo">Apoyo</option>
                  <option value="Operativo">Operativo</option>
                  <option value="Directivo/Gestion">Directivo/Gestión</option>
                </select>   
            </div>
            </fieldset> 
          </div>
        </div>
			  <fieldset class="label_side">
          <label>Misi&oacute;n</label>
          <div>
            <textarea  class="autogrow" name="mision"></textarea>
          </div>
			  </fieldset>   
			  <fieldset class="label_side">
          <label>Equipo de proceso</label>
          <div>
					<textarea class="autogrow" name="equipo_de_proceso"></textarea>
				</div>
			  </fieldset>      
			  <fieldset class="label_side">
          <label>Resultados clave</label>
          <div>
            <textarea class="autogrow" name="resultados_clave"></textarea>
          </div>
			  </fieldset>
        <div class="columns clearfix">
          <div class="col_50">
            <fieldset>
              <label>Entradas / Proveedores</label>
              <div>
                <textarea name="entradas"></textarea>
              </div>
            </fieldset>  
          </div>
          <div class="col_50">
            <fieldset>
              <label>Salidas / Clientes</label>
              <div>
                <textarea name="salidas"></textarea>
              </div>
            </fieldset>   
          </div>
        </div>
			  <fieldset class="label_side">
          <label>Actividades</label>
          <div>
            <textarea class="autogrow" name="actividades"></textarea>
			    </div>
			  </fieldset> 
			  <fieldset class="label_side">
          <label>Variables de control</label>
          <div>
            <textarea class="autogrow" name="variables_control"></textarea>
			    </div>
			  </fieldset> 
			  <fieldset class="label_side">
          <label>Documentaci&oacute;n</label>
          <div>
					<input type="text" name="documentacion" />
			    </div>
			  </fieldset>
			  <fieldset class="label_side">
          <label>Mediciones</label>
          <div>
            <textarea  class="autogrow" name="mediciones"></textarea>
			    </div>
			  </fieldset>   
			  <fieldset class="label_side">
          <label>Registros</label>
          <div>
            <textarea  class="autogrow" name="registros" id="registros"></textarea>
			    </div>
			  </fieldset>    
			   
			  <div class="button_bar clearfix">
					<button class="green" type="submit" value="Grabar" name="proceso_submit">
						<span>Grabar</span>
					</button>
				</div>    
			</form>
		</div>
	</div>
</div>
