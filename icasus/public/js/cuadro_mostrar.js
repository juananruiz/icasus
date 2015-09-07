//--------------------------------------------------------------------------
// Proyecto Icasus <https://gestionproyectos.us.es/projects/r2h2-icasus/>
// Archivo: public/js/cuadro_mostrar.js
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesus Martin Corredera (jjmc@us.es),
// Joaquín Valonero Zaera (tecnibus1@us.es)
//--------------------------------------------------------------------------
//Incluye el código JavaScript para el fichero cuadro_mostrar.tpl que gestiona 
//las gráficas de los cuadros de mando.
//----------------------------------------------------------------------------

//Diaĺogo de confirmación para el botón de borrar panel
$(".borrar").on('click', function (evento) {
    var boton_borrar, id_panel;
    boton_borrar = $(this);
    id_panel = $(this).data("id_panel");
    $('#nombre_panel').html(boton_borrar.data('nombre_panel'));
    $("#dialogo_borrar_panel").dialog({
        autoOpen: true, modal: true,
        title: "Borrar Panel",
        buttons: [
            {
                text: "Cancelar",
                class: 'red',
                style: 'color:white;',
                click: function () {
                    $(this).dialog("close");
                }
            },
            {
                text: "Confirmar",
                class: 'green',
                style: 'color:white;',
                click: function () {
                    $(this).dialog("close");
                    $.ajax({
                        url: "index.php?page=panel_borrar&ajax=true&id_panel=" + id_panel,
                        success: function (datos) {
                            $(boton_borrar).parent().siblings('.section').html('<h4>Borrando ...</h4>');
                            boton_borrar.parents(".box").remove();
                        }
                    });
                }
            }

        ]
    });
    evento.preventDefault();
});

//----------------------------------------------------------------------------------------
//GRÁFICAS DE LOS PANELES
//----------------------------------------------------------------------------------------

//Paneles de líneas
$('.panel_linea').each(function () {
    var contenedor = $(this).attr('id');
    var id_panel = $(this).data("id_panel");
    var titulo = $(this).data("titulo_panel");
    var periodicidad = $(this).data("periodicidad");
    var fecha_inicio = $(this).data("fecha_inicio");
    var fecha_fin = $(this).data("fecha_fin");
    var fecha_inicio_es = (new Date(fecha_inicio)).toLocaleDateString();
    var fecha_fin_es = (new Date(fecha_fin)).toLocaleDateString();
    //Ancho de la leyenda del gráfico
    var ancho_leyenda = $(this).width() - ($(this).width() / 20);
    //Leyenda donde irań los indicadores relacionados
    var leyenda = $(this).next('.leyenda');
    leyenda.append('<p><h4>Indicador/es:</h4><p>');
    //Guarda el identificador de los indicadores representados para evitar 
    //la repetición de nombres y de valores de referencia
    var indicadores_procesados = new Array();
    //Guarda los datos de todas las series de cada indicador del panel
    var totalDataseries = new Array();

    //Obtenemos la lista de indicadores que forman el panel 
    //y los recorremos para sacar su serie
    $.getJSON("api_publica.php?metodo=get_indicadores_panel&id=" + id_panel).done(function (indicadores) {
        $.each(indicadores, function (index, indicador) {

            var urlApi = "api_publica.php?metodo=get_valores_con_timestamp&id=" + indicador.id +
                    "&fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin +
                    "&periodicidad=" + periodicidad;

            //Contenedor para los datos del gráfico
            var chartSerie = new HighchartSerie();

            if (periodicidad === "anual") {
                chartSerie.categoryType = "año";
            }
            else {
                chartSerie.categoryType = "medicion";
            }

            $.ajax({
                url: urlApi,
                type: "GET",
                dataType: "json",
                success: onDataReceived
            });

            function onDataReceived(datos) {
                datos.forEach(function (dato) {
                    //Si es un Total
                    if (indicador.id_entidad == 0) {
                        if (!dato.etiqueta_mini && !dato.referencia
                                && (dato.valor !== null)) {
                            chartSerie.add(dato);
                        }
                    }
                    //Si es una Unidad
                    else {
                        if (indicador.id_entidad == dato.id_unidad
                                && (dato.valor !== null)) {
                            chartSerie.add(dato, true);
                        }
                    }
                    //Si es una referencia
                    if (dato.referencia && (dato.valor !== null)
                            && indicadores_procesados.indexOf(indicador.id) === -1) {
                        chartSerie.add(dato);
                    }
                });

                //Incluye en listado de indicadores el indicador relacionado si no estaba ya
                if (indicadores_procesados.indexOf(indicador.id) === -1) {
                    leyenda.append('<p style="font-size:0.9em">\n\<a href="index.php?page=medicion_listar&id_indicador=' + indicador.id
                            + '" style="border:0">' + indicador.nombre + '</a></p>');
                    indicadores_procesados.push(indicador.id);
                }

                // Pide las series de datos a chartSerie
                var dataseries = chartSerie.getLinealSerie(indicador.nombre, index);
                // Si es no anual ocultamos valores de referencia
                if (chartSerie.categoryType !== "año") {
                    dataseries.forEach(function (dataserie, index) {
                        if (index !== 0) {
                            dataserie.visible = false;
                        }
                    });
                }

                //Sacar los datos de la dataserie y hacer un push en 
                //total_dataseries donde el nombre es el del indicador.
                dataseries.forEach(function (dataserie) {
                    totalDataseries.push(dataserie);
                });

                //Gráfico de líneas
                pintaGrafico({
                    chart: {
                        renderTo: contenedor,
                        events: {}
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: titulo,
                        style: {"fontSize": "14px"}
                    },
                    subtitle: {
                        text: 'Período: ' + fecha_inicio_es + ' al ' + fecha_fin_es
                    },
                    exporting: {
                        filename: titulo + ' (' + fecha_inicio_es + ' al ' + fecha_fin_es + ')'
                    },
                    xAxis: {
                        type: 'category'
                    },
                    yAxis: {
                        title: {
                            text: 'Valores'
                        }
                    },
                    plotOptions: {
                        series: {
                            dataLabels: {
                                enabled: true,
                                formatter: function () {
                                    return this.y ? ((Math.round(this.y * 100)) / 100) : null;
                                }
                            }
                        }
                    },
                    legend: {
                        width: ancho_leyenda
                    },
                    series: totalDataseries
                });
            }
        });
    });
});

//Paneles de barras
$(".panel_barra").each(function () {
    var contenedor = $(this).attr('id');
    var id_panel = $(this).data("id_panel");
    var titulo = $(this).data("titulo_panel");
    var periodicidad = $(this).data("periodicidad");
    //Ancho de la leyenda del gráfico
    var ancho_leyenda = $(this).width() - ($(this).width() / 20);
    //Leyenda donde irań los indicadores relacionados
    var leyenda = $(this).next('.leyenda');
    leyenda.append('<p><h4>Indicador base (gráfico de barras):</h4><p>');
    //Guarda los totales del indicador base
    var totales = new Array();
    //Guarda los datos de todas las series de cada indicador del panel
    var totalDataseries = new Array();
    //Nos indica si es un gráfico de barras
    var barras = true;

    //Obtenemos la lista de indicadores que forman el panel 
    //y los recorremos para sacar su serie
    $.getJSON("api_publica.php?metodo=get_indicadores_panel&id=" + id_panel).done(function (indicadores) {
        $.each(indicadores, function (index, indicador) {

            var urlApi = "api_publica.php?metodo=get_valores_con_timestamp&id=" + indicador.id
                    + "&periodicidad=" + periodicidad;

            // contenedor para los datos del indicador
            var chartSerie = new HighchartSerie();

            $.ajax({
                url: urlApi,
                type: "GET",
                dataType: "json",
                success: onDataReceived
            });

            function onDataReceived(datos) {
                datos.forEach(function (dato) {
                    if (dato.etiqueta_mini) {
                        chartSerie.add(dato);
                    }
                    //Total para el indicador base
                    else if (dato.id_unidad == 0 && index === 0) {
                        var pos = dato.medicion + ' - ' + indicador.nombre;
                        totales[pos] = parseFloat(dato.valor);
                    }
                });

                //Actualizamos la leyenda
                if (index === 0 && indicadores.length > 1) {
                    //Incluye en la leyenda el indicador base
                    leyenda.append('<p style="font-size:0.9em">\n\<a href="index.php?page=medicion_listar&id_indicador=' + indicador.id
                            + '" style="border:0">' + indicador.nombre + '</a></p>');
                    leyenda.append('<p><h4>Indicador/es complementarios (gráfico/s de líneas):</h4><p>');

                }
                else {
                    //Incluye en la leyenda el indicador relacionado
                    leyenda.append('<p style="font-size:0.9em">\n\<a href="index.php?page=medicion_listar&id_indicador=' + indicador.id
                            + '" style="border:0">' + indicador.nombre + '</a></p>');
                }

                // Pide las series de datos a chartSerie
                var dataseries;
                //Indicador base gráfico de barras
                if (index === 0) {
                    dataseries = chartSerie.getBarSerie(indicador.nombre);
                    // Hacemos visible el último año
                    dataseries[dataseries.length - 1].visible = true;
                    dataseries[dataseries.length - 1].selected = true;
                }
                //Resto de indicadores gráficos de líneas
                else if (index !== 0) {
                    dataseries = chartSerie.getLinealSerie(indicador.nombre, index);
                    //Ocultamos los últimos años
                    for (var i = 0, n = dataseries.length - 1; i !== n; i++) {
                        dataseries[i].visible = false;
                    }
                }

                //Sacar los datos de la dataserie y hacer un push en 
                //total_dataseries donde el nombre es el del indicador.
                dataseries.forEach(function (dataserie) {
                    totalDataseries.push(dataserie);
                });

                //Gráfico combinado (barras y líneas)
                pintaGrafico({
                    chart: {
                        renderTo: contenedor,
                        events: {}
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: titulo,
                        style: {"fontSize": "14px"}
                    },
                    exporting: {
                        filename: titulo
                    },
                    xAxis: {
                        type: 'category'
                    },
                    yAxis: {
                        title: {
                            text: 'Valores'
                        }
                    },
                    plotOptions: {
                        series: {
                            dataLabels: {
                                enabled: true,
                                formatter: function () {
                                    return this.y ? ((Math.round(this.y * 100)) / 100) : null;
                                }
                            },
                            events: {
                                // Pintamos la media al hacer click en él.
                                legendItemClick: function (event) {
                                    if (this.visible) {
                                        this.chart.yAxis[0].removePlotLine(this.name);
                                    } else {
                                        this.chart.yAxis[0].addPlotLine({
                                            label: {
                                                text: '<span title="Total ' + this.name + ': ' + Math.round(totales[this.name] * 100) / 100 + '">Total: <b>'
                                                        + Math.round(totales[this.name] * 100) / 100 + '</b></span>',
                                                x: -50,
                                                y: 10,
                                                useHTML: true,
                                                style: {
                                                    color: this.color
                                                }
                                            },
                                            value: totales[this.name],
                                            color: this.color,
                                            width: 2,
                                            id: this.name
                                        });
                                    }
                                }
                            }
                        },
                        column: {
                            dataLabels: {
                                enabled: true,
                                formatter: function () {
                                    return this.y ? ((Math.round(this.y * 100)) / 100) : null;
                                }
                            }
                        }
                    },
                    legend: {
                        width: ancho_leyenda
                    },
                    series: totalDataseries
                }, totales);
            }
        });
    });
});

//Paneles de tarta
$(".panel_tarta").each(function () {
    var contenedor = $(this).attr('id');
    var id_panel = $(this).data("id_panel");
    var titulo = $(this).data("titulo_panel");
    var id_medicion = $(this).data("id_medicion");
    //Ancho de la leyenda del gráfico
    var ancho_leyenda = $(this).width() - ($(this).width() / 20);
    //Variables para guardar el nombre y total de la medición solicitada
    var medicion, total = 0;
    //Leyenda donde ira el indicador relacionado
    var leyenda = $(this).next('.leyenda');
    leyenda.append('<p><h4>Indicador:</h4><p>');

    //Obtenemos la lista de indicadores que forman el panel 
    //y los recorremos para sacar su serie
    $.getJSON("api_publica.php?metodo=get_indicadores_panel&id=" + id_panel).done(function (indicadores) {
        $.each(indicadores, function (index, indicador) {

            var urlApi = "api_publica.php?metodo=get_valores_con_timestamp&id=" + indicador.id;

            // contenedor para los datos del gráfico
            var chartSerie = new HighchartSerie();

            //Incluye en la leyenda el indicador relacionado
            leyenda.append('<p style="font-size:0.9em"><a href="index.php?page=medicion_listar&id_indicador=' + indicador.id
                    + '" style="border:0">' + indicador.nombre + '</a></p>');

            $.ajax({
                url: urlApi,
                type: "GET",
                dataType: "json",
                success: onDataReceived
            });

            function onDataReceived(datos) {
                //Buscamos la medición para luego obtener su total
                while (!medicion) {
                    datos.forEach(function (dato) {
                        if (dato.id_medicion == id_medicion) {
                            medicion = dato.medicion;
                        }
                    });
                }
                datos.forEach(function (dato) {
                    if (dato.etiqueta_mini && dato.id_medicion == id_medicion) {
                        chartSerie.add(dato);
                    }
                    //Guardamos el total
                    if (medicion == dato.medicion && dato.id_unidad == 0) {
                        total = parseFloat(dato.valor);
                    }
                });

                //Redondeamos el total
                total = Math.round(total * 100) / 100;

                //Pide las series de datos a chartSerie
                var dataseries = chartSerie.getPieSerie();

                //Gráfico de tarta
                pintaGrafico({
                    chart: {
                        renderTo: contenedor,
                        events: {}
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: titulo,
                        style: {"fontSize": "14px"}
                    },
                    subtitle: {
                        text: 'Medición: ' + medicion + ' Total: ' + total
                    },
                    exporting: {
                        filename: titulo + '(Medición: ' + medicion + ')'
                    },
                    xAxis: {
                        type: 'category'
                    },
                    yAxis: {
                        title: {
                            text: 'Valores'
                        }
                    },
                    plotOptions: {
                        series: {
                            dataLabels: {
                                enabled: true,
                                formatter: function () {
                                    return this.y ? ((Math.round(this.y * 100)) / 100)
                                            + ' (' + (Math.round(this.percentage * 100) / 100) + '%)' : null;
                                }
                            }
                        }
                    },
                    tooltip: {
                        formatter: function () {
                            html = '<span style="font-size: 10px">' + this.key + '</span><br/>';
                            html += '<span >\u25CF</span> ' + this.series.name + ': <b>' + this.y
                                    + ' (' + (Math.round(this.percentage * 100) / 100) + '%)' + '</b><br/>';
                            return html;
                        }
                    },
                    legend: {
                        width: ancho_leyenda
                    },
                    series: dataseries
                });
            }
        });
    });
});

//Paneles de tabla
$(".panel_tabla").each(function () {
    var id_panel = $(this).data("id_panel");
    var leyenda = $(this).next('.leyenda');
    leyenda.insertBefore($(this));
    $.getJSON("api_publica.php?metodo=get_indicadores_panel&id=" + id_panel, function (indicadores) {
        // De momento cogemos solo el primer indicador por si viene mas de uno 
        var indicador = indicadores[0];
        leyenda.html('<h4>' + indicador.nombre + '</h4>');
        $.getJSON("api_publica.php?metodo=get_valores_con_timestamp&id=" + indicador.id, function (datos) {
            var items = [];
            // Tomamos la entidad a mostrar del panel_indicador actual
            var id_entidad = indicador.id_entidad;
            $.each(datos, function (i, dato) {
                var paridad;
                if (dato.id_unidad == id_entidad)
                {
                    if (i % 2 === 0) {
                        paridad = "odd";
                    } else {
                        paridad = "even";
                    }
                    items.push('<tr class="' + paridad + '"><td>' + dato.medicion + '</td><td>' + dato.valor + '</td></tr>');
                }
            });
            $('<table />', {'class': 'static',
                'data-id_indicador': indicador.id,
                html: items.join('')
            }).appendTo('#panel_' + id_panel);
        });
    });
});

//Paneles de tabla multi
//Se usa en "la biblioteca en cifras"
//Solo pinta años completos de momento
//Es una función "digna de mejora"
$(".panel_tabla_multi").each(function () {
    var fecha_inicio = $(this).attr("data-fecha_inicio");
    var fecha_fin = $(this).attr("data-fecha_fin");
    var id_panel = $(this).data("id_panel");
    var leyenda = $(this).next('.leyenda');
    var altura;
    var apiURL;
    var htmlTabla;
    var cuenta_indicadores;

    leyenda.insertBefore($(this));
//    leyenda.html('<h4>Poner algo aquí</h4>');

    fecha = new Date(fecha_inicio);
    anio_inicio = fecha.getFullYear();
    fecha = new Date(fecha_fin);
    anio_fin = fecha.getFullYear();
    htmlTabla += "<thead><tr><th>Nombre</th>";
    for (anio = anio_inicio; anio <= anio_fin; anio++) {
        htmlTabla += "<th>" + anio + "</th>";
    }
    htmlTabla += "</tr></thead>";

    apiURL = "api_publica.php?metodo=get_indicadores_panel_con_datos&id=" + id_panel
            + "&fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin;

    $.getJSON(apiURL, function (indicadores) {
        $.each(indicadores, function (i, datos) {
            var indicador = datos.indicador;
            var paridad;
            if (i % 2 === 0) {
                paridad = "odd";
            } else {
                paridad = "even";
            }
            htmlTabla += '<tr class="' + paridad + '"><td>' + indicador.nombre + '</td>';
            anio = anio_inicio;
            $.each(datos.valores, function (j, valor) {
                // Comprueba que el valor corresponde a la columna del año 
                while (valor.anio > anio + j) {
                    htmlTabla += '<td>&nbsp;</td>';
                    anio++;
                }
                htmlTabla += '<td>' + valor.valor + '</td>';
            });
            htmlTabla += '</tr>';
            cuenta_indicadores = i;
        });
        $('<table />', {'class': 'static', html: htmlTabla}).appendTo('#panel_' + id_panel);
        //Ajustamos la altura de la gráfica y del contenedor según el número de indicadores del panel
        altura = (200 + (25 * cuenta_indicadores));
        $("#panel_" + id_panel).css("height", altura + "px");
        $("#panel_" + id_panel).closest(".alturo").css("height", altura + "px");
    });
});

//Panel de datos Rebiun
$(".panel_rebiun").each(function () {
    var fecha = new Date();
    var anio_inicio = fecha.getFullYear() - 2;
    var anio_fin = fecha.getFullYear() - 1;
    var fecha_inicio = anio_inicio + "-01-01";
    var fecha_fin = anio_fin + "-12-31";
    var id_panel = $(this).data("id_panel");
    var paridad;
    var buscador = '<p style="font-weight:bold">Buscar:&nbsp;<input type="text" id="search" placeholder="Teclear..." /></p>';
    $('#panel_' + id_panel).append(buscador);
    var htmlTabla = '<table id="tabla_rebiun" class="static">';

    //Creamos la cabecera de la tabla
    htmlTabla += "<thead><tr><th>Código</th><th>Nombre</th>";
    htmlTabla += "<th>" + anio_inicio + "</th><th>" + anio_fin + "</th>";
    htmlTabla += "<th>Evolución</th></tr></thead><tbody>";

    $.getJSON("api_publica.php?metodo=get_indicadores_panel&id=" + id_panel).done(function (indicadores) {
        $.each(indicadores, function (index, indicador) {

            if (index % 2 === 0) {
                paridad = "odd";
            } else {
                paridad = "even";
            }

            htmlTabla += '<tr class="' + paridad + '"><td style="white-space:nowrap">' + indicador.codigo + '</td><td>' + indicador.nombre + '</td>';

            var urlApi = "api_publica.php?metodo=get_valores_con_timestamp&id=" + indicador.id +
                    "&fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin;

            $.ajax({
                url: urlApi,
                type: "GET",
                async: false,
                dataType: "json",
                success: onDataReceived
            });

            var valor_anio_inicio;
            var valor_anio_fin;
            var evolucion;

            function onDataReceived(datos) {
                valor_anio_inicio = null;
                valor_anio_fin = null;
                datos.forEach(function (dato) {
                    //Buscamos el total del año inicial
                    if (dato.id_unidad == 0 && dato.medicion == anio_inicio) {
                        valor_anio_inicio = Math.round(dato.valor * 100) / 100;
                        htmlTabla += '<td title="Valor" style="white-space:nowrap">' + valor_anio_inicio + '</td>';
                    }
                    //Buscamos el total del año final
                    if (dato.id_unidad == 0 && dato.medicion == anio_fin) {
                        valor_anio_fin = Math.round(dato.valor * 100) / 100;
                        htmlTabla += '<td title="Valor" style="white-space:nowrap">' + valor_anio_fin + '</td>';
                    }
                });
                if (valor_anio_inicio === null) {
                    htmlTabla += '<td  style="white-space:nowrap">---</td>';
                }
                if (valor_anio_fin === null) {
                    htmlTabla += '<td  style="white-space:nowrap">---</td>';
                }
                //Si existen ambos totales calculamos su diferencia
                if (valor_anio_inicio !== null && valor_anio_fin !== null) {
                    evolucion = Math.round((valor_anio_fin - valor_anio_inicio) * 100) / 100;
                    if (evolucion > 0) {
                        htmlTabla += '<td title="Incremento" style="color:green;white-space:nowrap;font-weight:bold;">' + evolucion + '</td></tr>';
                    }
                    else if (evolucion < 0) {
                        htmlTabla += '<td title="Descenso" style="color:red;white-space:nowrap;font-weight:bold;">' + evolucion + '</td></tr>';
                    }
                    else {
                        htmlTabla += '<td title="Constante" style="white-space:nowrap;font-weight:bold;">Constante</td></tr>';
                    }
                }
                else {
                    htmlTabla += '<td style="white-space:nowrap">---</td>';
                }
            }
        });
        htmlTabla += '</tbody></table>';
        $('#panel_' + id_panel).append(htmlTabla);
        $("#search").keyup(function () {
            _this = this;
            // Show only matching TR, hide rest of them
            $.each($("#tabla_rebiun tbody").find("tr"), function () {
                console.log($(this).text());
                if ($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) === -1)
                    $(this).hide();
                else
                    $(this).show();
            });
        });
    });
});

//Paneles de métrica
$(".panel_metrica").each(function () {
    var id_panel = $(this).data("id_panel");
    var id_medicion = $(this).data("id_medicion");
    //Leyenda donde ira el indicador relacionado
    var leyenda = $(this).next('.leyenda');
    leyenda.append('<p><h4>Indicador:</h4><p>');
    var medicion; //etiqueta de la medición a mostrar
    var unidad; //etiqueta de la unidad a mostrar

    $.getJSON("api_publica.php?metodo=get_indicadores_panel&id=" + id_panel).done(function (indicadores) {
        // De momento cogemos solo el primer indicador por si viene mas de uno 
        var indicador = indicadores[0];

        $.getJSON("api_publica.php?metodo=get_valores_con_timestamp&id=" + indicador.id).done(function (datos) {
            var html = "";
            // Tomamos la entidad a mostrar del panel_indicador actual
            var id_entidad = indicador.id_entidad;
            //Si es un total
            if (id_entidad == 0) {
                var total = 0;
                //Buscamos y guardamos la medición 
                while (!medicion) {
                    $.each(datos, function (i, dato) {
                        if (dato.id_medicion == id_medicion)
                        {
                            medicion = dato.medicion;
                        }
                    });
                }
                //Guardada la medición localizamos el total
                $.each(datos, function (i, dato) {
                    if (dato.medicion == medicion && dato.id_unidad == 0)
                    {
                        total = parseFloat(dato.valor);
                        unidad = dato.unidad;
                    }
                });
                //Redondeamos el total
                total = Math.round(total * 100) / 100;
                html = "<p style='font-size:2em; color:maroon; padding:20px 0 0 0; text-align:center; line-height:6px;'>" + total + "</p>";
                html += "<p style='padding:0 0 20px 0; text-align: center;line-height: 10px;'><strong>Valor Total</strong></p>";
            }
            //Si es una unidad
            else {
                var valor = 0;
                $.each(datos, function (i, dato) {
                    if (dato.id_medicion == id_medicion && id_entidad == dato.id_unidad)
                    {
                        valor = parseFloat(dato.valor);
                        //Guardamos la medición y la unidad perteneciente
                        if (!medicion && !unidad) {
                            medicion = dato.medicion;
                            unidad = dato.unidad;
                        }
                    }
                });
                //Redondeamos el valor
                valor = Math.round(valor * 100) / 100;
                html = "<p style='font-size:2em; color:maroon; padding:20px 0 0 0; text-align:center; line-height:6px;'>" + valor + "</p>";
                html += "<p style='padding:0 0 20px 0; text-align: center;line-height: 10px;'><strong>" + unidad + "</strong></p>";
            }
            $('<div/>', {'class': 'centrado',
                html: html
            }).appendTo('#panel_' + id_panel);

            leyenda.append('<p style="font-size:0.9em"><a href="index.php?page=medicion_listar&id_indicador=' + indicador.id
                    + '" style="border:0">' + indicador.nombre + ' - ' + unidad + ' (' + medicion + ')</a></p>');
        });
    });
});

//Función que pinta nuestra gráfica
function pintaGrafico(chartOptions, totales) {
    $(document).ready(function () {
        // Añadimos evento al hacer click en el gráfico
        chartOptions.chart.events.click = function () {
            hs.htmlExpand(document.getElementById(chartOptions.chart.renderTo), {
                width: 9999,
                height: 9999,
                allowWidthReduction: true
            }, {
                chartOptions: chartOptions,
                totales: totales
            });
        };
        var chart = new Highcharts.Chart(chartOptions);
        if (totales) {
            // Pinta la media del último grupo de datos (último periodo)
            chart.getSelectedSeries().forEach(function (selected) {
                chart.yAxis[0].addPlotLine({
                    label: {
                        text: '<span title="Total ' + selected.name + ': ' + Math.round(totales[selected.name] * 100) / 100 + '">Total: <b>'
                                + Math.round(totales[selected.name] * 100) / 100 + '</b></span>',
                        x: -50,
                        y: 10,
                        useHTML: true,
                        style: {
                            color: selected.color
                        }
                    },
                    value: totales[selected.name],
                    color: selected.color,
                    width: 2,
                    id: selected.name
                });
            });
        }
    });
}

// Crea un nuevo gráfico con un popup de Highslide
var i = 0; //Contador de popus
hs.Expander.prototype.onAfterExpand = function () {
    if (this.custom.chartOptions) {
        var chartOptions = this.custom.chartOptions;
        chartOptions.chart.height = 600;
        chartOptions.chart.renderTo = $('.highslide-body')[i];
        chartOptions.chart.events.click = function () {
        };
        var hsChart = new Highcharts.Chart(chartOptions);
        if (this.custom.totales) {
            var totales = this.custom.totales;
            // Pinta la media del último grupo de datos (último periodo)
            hsChart.getSelectedSeries().forEach(function (selected) {
                hsChart.yAxis[0].addPlotLine({
                    label: {
                        text: '<span title="Total ' + selected.name + ': ' + Math.round(totales[selected.name] * 100) / 100 + '">Total: <b>'
                                + Math.round(totales[selected.name] * 100) / 100 + '</b></span>',
                        x: -50,
                        y: 10,
                        useHTML: true,
                        style: {
                            color: selected.color
                        }
                    },
                    value: totales[selected.name],
                    color: selected.color,
                    width: 2,
                    id: selected.name
                });
            });
        }
        i++;
    }
};