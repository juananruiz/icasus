<!DOCTYPE html>
<html lang="es-ES">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="application-name" content="{$smarty.const.TXT_ICASUS}">
        <meta name="description" content="{$smarty.const.TXT_APP_DESCRIPCION}">
        <meta name="author" content="Juan Antonio Ruíz Rivas">
        <meta name="author" content="Juan Jesús Martín Corredera">
        <meta name="author" content="Joaquín Valonero Zaera">

        <title>{$_nombre_pagina} - {$smarty.const.TXT_ICASUS}</title>

        <link rel=icon href=favicon.ico sizes="32x32 48x48" type="image/vnd.microsoft.icon">

        <!-- Bootstrap Core CSS -->
        <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="lib/metisMenu.min.css" rel="stylesheet">

        <!-- Highslide -->
        <script type='text/javascript' src="lib/highslide/highslide-full.min.js"></script>
        <script type='text/javascript' src="lib/highslide/highslide.config.js"></script>
        <link rel="stylesheet" type="text/css" href="lib/highslide/highslide.css"/>

        <!-- Custom CSS -->
        <link href="css/estilo.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- Configuration Script -->
        {if isset($_javascript)}
            {foreach from=$_javascript item=script} 
                <script type='text/javascript' src="js/{$script}.js"></script>
            {/foreach}
        {/if}

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>

    <body {if !isset($_usuario)} class="login-page"{/if}>

        {if isset($_usuario)}
            {* Si se ha iniciado sesión *}
            <div id="wrapper">

                <!-- Navigation -->
                <nav id="top" class="navbar navbar-default navbar-fixed-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">{$smarty.const.TXT_MOSTAR_OCULTAR_NAV}</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" title="{$smarty.const.TXT_APP_DESCRIPCION}" href="index.php">
                            <img class="logo pull-left" alt="{$smarty.const.TXT_UNIVERSIDAD}" src="images/logo.png">
                            {$smarty.const.TXT_ICASUS}
                        </a>
                    </div>
                    <!-- /.navbar-header -->

                    <ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown">
                            <a class="dropdown-toggle" title="{$_usuario->login}" data-toggle="dropdown" href="#">
                                <i class="fa fa-user fa-fw"></i> {$_usuario->login} <i class="fa fa-caret-down"></i>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a title="{$smarty.const.TXT_USER_PERFIL}" href='index.php?page=usuario_mostrar&id_usuario={$_usuario->id}'><i class="fa fa-user fa-fw"></i> {$smarty.const.TXT_USER_PERFIL}</a>
                                </li>
                                <li><a title="{$smarty.const.TXT_MIS_NOTAS}" href='index.php?page=nota_mostrar'><i class="fa fa-sticky-note fa-fw"></i> {$smarty.const.TXT_MIS_NOTAS}</a>
                                </li>
                                <li class="divider"></li>
                                <li><a title="{$smarty.const.TXT_CERRAR_SESION}" href="index.php?page={$smarty.const.IC_TIPO_LOGIN}&logout=true"><i class="fa fa-sign-out fa-fw"></i> {$smarty.const.TXT_CERRAR_SESION}</a>
                                </li>
                            </ul>
                            <!-- /.dropdown-user -->
                        </li>
                        <!-- /.dropdown -->
                    </ul>
                    <!-- /.navbar-top-links -->

                    <div class="navbar-default sidebar" role="navigation" >
                        <div class="sidebar-nav navbar-collapse">
                            <ul class="nav" id="side-menu">
                                <li>
                                    <a title="{$smarty.const.TXT_INICIO}" href='index.php?page=inicio' accesskey='h'>
                                        <i class="fa fa-home fa-fw"></i> {$smarty.const.TXT_INICIO}</a>
                                </li>
                                <li>
                                    <a title="{$smarty.const.TXT_CUADROS_MANDO}" href='index.php?page=cuadro_listar'>
                                        <i class="fa fa-th fa-fw"></i> {$smarty.const.TXT_CUADROS_MANDO}</a>
                                </li>
                                <li>
                                    <a title="{$smarty.const.FIELD_UNIDS}" href='index.php?page=entidad_listar'>
                                        <i class="fa fa-sitemap fa-fw"></i> {$smarty.const.FIELD_UNIDS}</a>
                                </li>
                                <li>
                                    <a title="{$smarty.const.TXT_USERS}" href='index.php?page=usuario_listar'>
                                        <i class="fa fa-users fa-fw"></i> {$smarty.const.TXT_USERS}</a>
                                </li>
                                <li>
                                    <a title="{$smarty.const.TXT_AYUDA}" href='index.php?page=pagina_mostrar&alias=indice'>
                                        <i class="fa fa-question-circle fa-fw"></i> {$smarty.const.TXT_AYUDA}</a>
                                </li>
                                <li>
                                    <a title="{$smarty.const.TXT_ENLACES}" href="#">
                                        <i class="fa fa-external-link fa-fw"></i> {$smarty.const.TXT_ENLACES}<span class="fa arrow"></span></a>
                                    <ul class="nav nav-second-level">
                                        <li>
                                            <a title="{$smarty.const.TXT_UNIVERSIDAD}" href='http://www.us.es/' target="_blank"><i class="fa fa-university fa-fw"></i> {$smarty.const.TXT_UNIVERSIDAD}</a>
                                        </li>
                                        <li>
                                            <a title="{$smarty.const.TXT_RRHH}" href='http://recursoshumanos.us.es/' target="_blank"><i class="fa fa-male fa-fw"></i> {$smarty.const.TXT_RRHH}</a>
                                        </li>
                                        <li>
                                            <a title="{$smarty.const.TXT_BIBLIOTECA}" href='http://bib.us.es/' target="_blank"><i class="fa fa-book fa-fw"></i> {$smarty.const.TXT_BIBLIOTECA}</a>
                                        </li>
                                        <li>
                                            <a title="{$smarty.const.TXT_SECRETARIA}" href='https://sevius.us.es/' target="_blank"><i class="fa fa-tv fa-fw"></i> {$smarty.const.TXT_SECRETARIA}</a>
                                        </li>
                                    </ul>
                                    <!-- /.nav-second-level -->
                                </li>
                            </ul>
                        </div>
                        <!-- /.sidebar-collapse -->
                    </div>
                    <!-- /.navbar-default-sidebar -->
                </nav>                          

                <!-- Page Content -->
                <div id="page-wrapper">
                    <div class="container-fluid">
                        {if isset($entidad)}
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-red">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-lg-8">
                                                    <span class="panel-title" title="{$smarty.const.TXT_UNID}: {$entidad->nombre}"><i class="fa fa-sitemap fa-fw"></i> {$entidad->nombre}</span>
                                                </div>
                                                <!-- /.col-lg-8 -->
                                                <div class="col-lg-4">
                                                    <span class="panel-title" title="{$smarty.const.FIELD_ROL}: {$_rol}"><i class="fa fa-certificate fa-fw"></i> {$_rol}</span>
                                                </div>
                                                <!-- /.col-lg-4 -->
                                            </div>
                                            <!-- /.row -->
                                        </div>
                                        <!-- /.panel-heading -->
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <ul class="nav nav-pills">
                                                        <li role="presentation">
                                                            <a title="{$smarty.const.TXT_UNID_FICHA}" href='index.php?page=entidad_datos&id_entidad={$entidad->id}' class="btn btn-default">
                                                                <i class="fa fa-sitemap fa-fw"></i> {$smarty.const.TXT_UNID_FICHA}
                                                            </a>
                                                        </li>
                                                        <li role="presentation">
                                                            <a title="{$smarty.const.TXT_PROCS}" href='index.php?page=proceso_listar&id_entidad={$entidad->id}' class="btn btn-default">
                                                                <i class="fa fa-gears fa-fw"></i> {$smarty.const.TXT_PROCS}
                                                            </a>
                                                        </li>
                                                        <li role="presentation">
                                                            <a title="{$smarty.const.FIELD_INDICS}" href='index.php?page=indicador_listar&id_entidad={$entidad->id}' class="btn btn-default">
                                                                <i class="fa fa-dashboard fa-fw"></i> {$smarty.const.FIELD_INDICS}
                                                            </a>
                                                        </li>
                                                        <li role="presentation">
                                                            <a title="{$smarty.const.FIELD_DATOS}" href='index.php?page=dato_listar&id_entidad={$entidad->id}' class="btn btn-default">
                                                                <i class="fa fa-database fa-fw"></i> {$smarty.const.FIELD_DATOS}
                                                            </a>
                                                        </li>
                                                        <li role="presentation">
                                                            <a title="{$smarty.const.TXT_CONSULT}" href='index.php?page=consulta_avanzada&id_entidad={$entidad->id}' class="btn btn-default">
                                                                <i class="fa fa-eye fa-fw"></i> {$smarty.const.TXT_CONSULT}
                                                            </a>
                                                        </li>
                                                        <li role="presentation">
                                                            <a title="{$smarty.const.TXT_CUAD_RES}" href='index.php?page=cuadro_unidad&id_entidad={$entidad->id}' class="btn btn-default">
                                                                <i class="fa fa-dashcube fa-fw"></i> {$smarty.const.TXT_CUAD_RES}
                                                            </a>
                                                        </li>
                                                        {if $_control} 
                                                            <li role="presentation">
                                                                <a title="{$smarty.const.TXT_CONTROL}" href='index.php?page=control&modulo=inicio&id_entidad={$entidad->id}' class="btn btn-default">
                                                                    <i class="fa fa-sliders fa-fw"></i> {$smarty.const.TXT_CONTROL}
                                                                </a>
                                                            </li>
                                                        {/if}
                                                    </ul>
                                                </div>
                                                <!-- /.col-lg-12 -->
                                            </div>
                                            <!-- /.row -->
                                        </div>
                                        <!-- /.panel-body -->
                                    </div>
                                    <!-- /.panel -->
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>
                            <!-- /.row -->
                        {/if}
                        <div class="row">
                            <div class="col-lg-12">
                                <h1 class="page-header">{$_nombre_pagina}</h1>
                            </div>
                            <!-- /.col-lg-12 -->
                        </div>
                        <!-- /.row -->
                        {if isset($smarty.get.error)}
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="alert alert-danger alert-dismissible">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="{$smarty.const.TXT_CERRAR}">
                                            <span aria-hidden="true">&times;</span></button>
                                        <i class="fa fa-exclamation-circle fa-fw"></i> 
                                        {$smarty.get.error}
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>
                            <!-- /.row -->
                        {/if}
                        {if isset($error)}
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="alert alert-danger alert-dismissible">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="{$smarty.const.TXT_CERRAR}">
                                            <span aria-hidden="true">&times;</span></button>
                                        <i class="fa fa-exclamation-circle fa-fw"></i>  
                                        {$error}
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>
                            <!-- /.row -->
                        {/if}
                        {if isset($smarty.get.aviso)}
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="alert alert-warning alert-dismissible">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="{$smarty.const.TXT_CERRAR}">
                                            <span aria-hidden="true">&times;</span></button>
                                        <i class="fa fa-exclamation-triangle fa-fw"></i>
                                        {$smarty.get.aviso}
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>
                            <!-- /.row -->
                        {/if}
                        {if isset($aviso)}
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="alert alert-warning alert-dismissible">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="{$smarty.const.TXT_CERRAR}">
                                            <span aria-hidden="true">&times;</span></button>
                                        <i class="fa fa-exclamation-triangle fa-fw"></i> 
                                        {$aviso}
                                    </div>
                                </div>
                                <!-- /.col-lg-12 -->
                            </div>
                            <!-- /.row -->
                        {/if}
                        <div class="row">
                            <div class="col-lg-12">
                                {* El cuerpo del template va aqui *}
                                {include file=$plantilla}
                            </div>
                            <!-- /.col-lg-12 -->
                        </div>
                        <!-- /.row -->   
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- /#page-wrapper -->

                <!-- Footer -->
                <footer class="text-center footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-12">
                                {$smarty.const.TXT_ICASUS} - {$smarty.const.TXT_APP_DESCRIPCION}
                            </div>
                            <!-- /.col-lg-12 -->
                        </div>
                        <!-- /.row -->
                        <div class="row">
                            <div class="col-lg-12">
                                <small>{$smarty.const.FIELD_VERSION}: {$smarty.const.IC_VERSION} - {$smarty.const.FIELD_FECHA_REV}: {$smarty.const.IC_FECHA_REVISION}</small>
                            </div>
                            <!-- /.col-lg-12 -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.container-fluid -->
                </footer>
                <!-- /Footer -->

                <!-- Back to Top -->
                <a title="{$smarty.const.TXT_VOLVER_ARRIBA}" id="top-link-block" href="#top" class="btn btn-default hidden"  
                   {literal}
                       onclick="$('html,body').animate({scrollTop: 0}, 'slow');
                               return false;"
                   {/literal}>
                    <i class="fa fa-chevron-up"></i>
                </a>
                <!-- /Back to Top -->

            </div>
            <!-- /#wrapper -->
        {else}
            {* Si no hay sesión iniciada *}
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        {* El cuerpo del template va aqui *}
                        {include file=$plantilla}
                    </div>
                    <!-- /.col-md-8 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->  
        {/if}

        <!-- jQuery -->
        <script src="lib/jquery/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="lib/bootstrap/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="lib/metisMenu/metisMenu.min.js"></script>

        <!-- Custom JavaScript -->
        <script src="js/index.js"></script>

    </body>

</html>
