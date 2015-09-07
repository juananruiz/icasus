//------------------------------------------------------------------------------
// Proyecto: Icasus <https://gestionproyectos.us.es/projects/r2h2-icasus/>
// Archivo: public/js/indicador_crear.js
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin Corredera (jjmc@us.es),
// Joaquín Valonero Zaera (tecnibus1@us.es)
//------------------------------------------------------------------------------
// Incluye el código JavaScript para el fichero indicador_crear.tpl
//------------------------------------------------------------------------------

$(document).ready(function () {
    $('#tab_crear_indicador').tabs({disabled: [1, 2]});
    //mostrar selección de agregación temporal
    $('#periodicidad').on('click', function () {
        var valor = $(this).attr('value');
        if (valor === 'Bienal' || valor === 'Anual')
        {
            $('#total_anual').css('display', 'none');
        }
        else
        {

            $('#total_anual').css('display', 'block');
        }
    });
    //mostrar tipo de medición
    $('.medicion').on('click', function () {
        var valor = $(this).attr('value');
        if (valor === '1' || valor === '2')
        {
            $('#total').css('display', 'block');
            $('#div_unidad').css('display', 'none');
            $('#div_subunidades').css('display', 'block');
            $(".subunidad").attr("checked", "checked");
            $(".unidad").removeAttr("checked");
        }
        else if (valor === '0')
        {
            $('#total').css('display', 'none');
            $('#div_unidad').css('display', 'block');
            $('#div_subunidades').css('display', 'none');
            $(".subunidad").removeAttr("checked");
            $(".unidad").attr("checked", "checked");
        }
    });
    //validar formulario
    var anyo = new Date().getFullYear();
    var validator = $('#formindicador').validate({
        rules: {
            codigo: {required: true},
            id_proceso: {required: true},
            nombre: {required: true},
            formulacion: {required: true},
            historicos: {
                required: true,
                min: 2008,
                max: anyo
            },
            id_responsable: {required: true},
            id_responsable_medicion: {required: true},
            tipo_seleccion_responsable: {required: true},
            'subunidades[]': {required: true}
        },
        ignore: ':hidden',
        messages: {
            codigo: 'Debe insertar un código',
            id_proceso: 'Debe seleccionar un proceso',
            nombre: 'Debe dar un nombre',
            formulacion: 'Debe indicar su formulación',
            historicos: {
                required: 'Debe indicar un año de inicio para el Histórico del Indicador',
                min: 'El Histórico debe ser igual o posterior al año 2008',
                max: 'El Histórico debe ser igual o anterior al año actual'
            },
            id_responsable: 'Seleccionar un responsable',
            id_responsable_medicion: 'Seleccionar el responsable de medición',
            tipo_seleccion_responsable: 'Seleccionar el tipo de medición',
            'subunidades[]': 'Debe seleccionar al menos una Unidad'
        }
    });
    //Boton previo
    $('button.btnPrev').on('click', function () {
        var actualTab = $('#tab_crear_indicador').tabs('option', 'selected');
        $('#tab_crear_indicador').tabs('enable', actualTab - 1).tabs('select', actualTab - 1).tabs('disable', actualTab);
    });
    //Boton next
    $('button.btnNext').on('click', function () {
        var actualTab = $('#tab_crear_indicador').tabs('option', 'selected');
        var estavalidado = $('#formindicador').valid();
        if (estavalidado === true)
        {
            $('#tab_crear_indicador').tabs('enable', actualTab + 1).tabs('select', actualTab + 1).tabs('disable', actualTab);
        }
        else
        {
            validator.focusInvalid();
        }
        return false;
    });
});

