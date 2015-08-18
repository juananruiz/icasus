<?php

//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus 
// Archivo: csv_grabar.php
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin Corredera (jjmc@us.es),
// Joaquín Valonero Zaera (tecnibus1@us.es)
//---------------------------------------------------------------------------------------------------
// Descripcion: Graba el contenido de un  fichero CSV en la base de datos
//---------------------------------------------------------------------------------------------------
global $smarty;
global $plantilla;
global $usuario;
$usuario_entidad = new Usuario_entidad();

if (filter_has_var(INPUT_POST, 'id_entidad'))
{
    $id_entidad = filter_input(INPUT_POST, 'id_entidad', FILTER_SANITIZE_NUMBER_INT);
    // Comprobamos que el usuario esté autorizado
    if ($usuario_entidad->comprobar_responsable_entidad($usuario->id, $id_entidad))
    {
        $ficheros_procesados = 0;
        $registros_grabados = 0;  //los que realmente se graban 
        $registros_ajenos = 0;    // los que no pertenecen a la entidad actual
        $lineas_totales = 0;      // total de líneas procesadas en todos los ficheros
        $lineas_fallidas = 0;     // líneas que no hacen referencia a ningún indicador

        foreach ($_FILES["fichero_csv"]["error"] as $indice => $error)
        {
            // Esto es una guarrería pero está sacada del manual oficial de php.net
            // así que es una "guarrerida oficial"
            if ($error == UPLOAD_ERR_OK)
            {
                $tmp_name = $_FILES["fichero_csv"]["tmp_name"][$indice];
                $name = $_FILES["fichero_csv"]["name"][$indice];
                $manejador = fopen($tmp_name, "r");

                if ($manejador !== FALSE)
                {
                    $ficheros_procesados ++;
                    while (($datos = fgetcsv($manejador, 1000, ",", "'")) !== FALSE)
                    {
                        $lineas_totales ++;
                        $medicion = new Medicion();
                        $medicion->id_indicador = $datos[0];
                        $medicion->periodo_inicio = $datos[1];
                        $medicion->periodo_fin = $datos[2];
                        $medicion->etiqueta = $datos[3];
                        $indicador = new Indicador();
                        $entidad = new Entidad();
                        if ($indicador->load("id = $medicion->id_indicador"))
                        {
                            $entidad->load("id = $indicador->id_entidad");
                            // Comprobamos que el indicador pertenece a la entidad actual o a su madre
                            // Podría optimizarse comprobando si el indicador a cambiado respecto al anterior
                            if ($indicador->id_entidad == $id_entidad OR $entidad->id_madre == $id_entidad)
                            {
                                if ($medicion->save())
                                {
                                    $valor = new Valor();
                                    $valor->id_medicion = $medicion->id;
                                    $valor->id_usuario = $usuario->id;
                                    $valor->id_entidad = $id_entidad;
                                    $valor->fecha_recogida = date('Y-m-d h:m:i');
                                    $valor->valor_parcial = $datos[4];
                                    $valor->valor = $datos[4];
                                    if ($valor->save())
                                    {
                                        $registros_grabados ++;
                                    }
                                }
                            }
                            else
                            {
                                $registros_ajenos ++;
                            }
                        }
                        else
                        {
                            $lineas_fallidas ++;
                        }
                    } // termina el while
                    fclose($manejador);
                }
                // $indicador = new indicador();
            }
        }
        $aviso = MSG_MEDS_GRABADAS . ": $registros_grabados. ";
        $aviso.= MSG_ARCHIVOS_PROCESADOS . ": $ficheros_procesados. ";
        $aviso.= MSG_TOTAL_LINEAS . ": $lineas_totales. ";
        if ($registros_ajenos > 0)
        {
            $aviso .= "$registros_ajenos " . MSG_MEDS_INDIC_NO_UNID;
        }
        if ($lineas_fallidas > 0)
        {
            $aviso .= " $lineas_fallidas " . MSG_LINEAS_NO_REF_INDIC;
        }
        header("Location: index.php?page=csv_importar&id_entidad=$id_entidad&aviso=$aviso");
    }
    else
    {
        $error = ERR_DATO_IMPORT_NO_AUT;
        header('location:index.php?error=' . $error);
    }
}
else
{
    $error = ERR_ARCHIVO_NO_SEL;
    header("Location: index.php?page=csv_importar&error=$error");
}
