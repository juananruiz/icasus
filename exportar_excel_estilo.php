<?php
//---------------------------------------------------------------------------------------------------
// Proyecto: Icasus (http://wiki.us.es/icasus/)
// Archivo: cuadromando_exportar_excel_estilo.php
// Tipo: controlador
// Desarrolladores: Juanan Ruiz (juanan@us.es), Jesús Martín (jjmc@us.es)
//---------------------------------------------------------------------------------------------------
// Descripcion: Da estilo a la hojas de calculo excel 
//---------------------------------------------------------------------------------------------------

    //Logo y cabecera de la Hoja de Calculo
    $objDrawing = new PHPExcel_Worksheet_Drawing();
    $objDrawing->setName('logo');
    $objDrawing->setDescription('logo');
    $objDrawing->setPath('theme/usevilla/marca_use.gif');
    $objDrawing->setHeight(72);
    $objDrawing->setCoordinates('B1');
    $objDrawing->setWorksheet($excel->getActiveSheet());
    //une las celdas para el nombre del indicador
    $excel->getActiveSheet()->mergeCells('B5:F5');
    //Titulos de las columnas
    $excel->getActiveSheet()->setCellValue('B5', $indicador->nombre);
    $excel->getActiveSheet()->setCellValue('B7', 'Periodo');
    $excel->getActiveSheet()->setCellValue('C7', 'Valor');
    $excel->getActiveSheet()->setCellValue('D7', 'Objetivo');
    $excel->getActiveSheet()->setCellValue('E7', 'Objetivo Pactado');
    $excel->getActiveSheet()->setCellValue('F7', 'Objetivo Carta');
    //Colorear fondo del nombre del indicador
    $excel->getActiveSheet()->getStyle('B5')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);
    $excel->getActiveSheet()->getStyle('B5:F5')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
    $excel->getActiveSheet()->getStyle('B5:F5')->getFill()->getStartColor()->setARGB('FF990000');
    //Colorear fondo de cabeceras de la tabla
    $excel->getActiveSheet()->getStyle('B7:F7')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
    $excel->getActiveSheet()->getStyle('B7:F7')->getFill()->getStartColor()->setARGB('FF990000');
    $excel->getActiveSheet()->getStyle('B7:F7')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);
    //Poner automatico el ancho de las columnas
    $excel->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
    $excel->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);
    //Define el marco en negro alrededor de los datos
    $styleThinBlackBorderOutline = array(
        'borders' => array(
                'allborders' => array(
                        'style' => PHPExcel_Style_Border::BORDER_THIN,
                        'color' => array('argb' => 'FF990000'),
                ),
        ),
    );
?>
