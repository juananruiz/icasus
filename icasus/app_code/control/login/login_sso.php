<?php

require_once __DIR__ . '/../../../../cascara_core/phpCAS-1.3.8/CAS.php';

// Instancia el cliente
phpCAS::client(CAS_VERSION_2_0, IC_SSO_CAS_URL, IC_SSO_CAS_PORT, IC_SSO_CAS_PATH);
// Habilita la validación del certificado y de su CN
phpCAS::setCasServerCACert(CAS_SERVER_CA_CERT_PATH, true);
phpCAS::forceAuthentication();

$smarty->assign("_nombre_pagina", TXT_BIENVENIDO);

// Este controlador puede hacer tres cosas: autenticar, logout o mostrar la página inicial
// (que hace de presentación y tiene un enlace para autenticar)
if (filter_has_var(INPUT_GET, 'autenticar')) {
    $url = "https://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
    $usuario_sso_relacion = phpCAS::getAttribute('usesrelacion');
    $usuario_sso_login = phpCAS::getAttribute('uid;');
    $usuario_sso_nombre = phpCAS::getAttribute('givenname');
    $usuario_sso_apellidos = phpCAS::getAttribute('sn');;
    $usuario_sso_nif = phpCAS::getAttribute('irispersonaluniqueid');
    $usuario_sso_correo = phpCAS::getAttribute('irismailmainaddress');
    $acceso_autorizado = false;
    if (is_array($usuario_sso_relacion)) {
        foreach ($usuario_sso_relacion as $perfil) {
            if ($perfil == 'PAS' or $perfil == 'PDI' or $perfil == 'MISCELANEA' or $perfil == 'PDIEXTERNO') {
                $acceso_autorizado = true;
            }
        }
    } else {
        if ($usuario_sso_relacion == 'PAS' or $usuario_sso_relacion == 'PDI' or $usuario_sso_relacion == 'MISCELANEA'
                or $usuario_sso_relacion == 'PDIEXTERNO') {
            $acceso_autorizado = true;
        }
    }

    // Si algún perfil está autorizado vamos adentro en caso contrario avisamos al usuario
    if ($acceso_autorizado) {
        $usuario = new Usuario();

        if ($usuario->load_joined("login = '" . $usuario_sso_login . "'")) {
            // Si el usuario existe en icasus cargamos sus datos
            $_SESSION['usuario'] = $usuario;
            //$log = new $log;
            //$log->add('login',0,$usuario->id);
            // Si el usuario tiene unidades asignadas
            if ($usuario->entidades) {
                foreach ($usuario->entidades as $entidad) {
                    //Le redirigimos a su unidad principal si la hay
                    if ($entidad->principal) {
                        header("location:index.php?page=entidad_mostrar&id_entidad=" . $entidad->entidad->id);
                        exit();
                    }
                }
            }
            header("location:index.php");
        } else {
            // Si el usuario no existe lo damos de alta con los datos de ldap
            $usuario->login = $usuario_sso_login;
            $usuario->nombre = $usuario_sso_apellidos;
            $usuario->nif = $usuario_sso_nif;
            $usuario->apellidos = $usuario_sso_apellidos;
            $usuario->correo = $usuario_sso_correo;
            if ($usuario->save()) {
                $_SESSION['usuario'] = $usuario;
                header("location:index.php");
            } else {
                // Ha habido un problema al grabar el nuevo usuario en la base de datos (raro pero posible)
                $error = ERR_LOGIN_SSO;
                $smarty->assign('error', $error);
                header("location:index.php?error=" . $error);
            }
        }
    } else {
        // No se autoriza el acceso
        $error = ERR_LOGIN_SSO_AUT;
        $smarty->assign('error', $error);
        header("location:index.php?error=" . $error);
    }
} else if (filter_has_var(INPUT_GET, 'logout')) {
    session_unset();
    session_destroy();
    phpCAS::handleLogoutRequests();
    header('location:' . '/index.php');
} else {
    $plantilla = "login/login_sso.tpl";
}
