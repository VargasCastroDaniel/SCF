<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upd_Ordeños</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $FechaHora = $_GET['FechaHora'];
        $FechaHoraNueva = $_GET['FechaHoraNueva'];
        $LitrosLeche = $_GET['LitrosLeche'];
        $espacio = ", o Espacios en blanco";

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.upd_Ordeños '$FechaHora', '$FechaHoraNueva', '$LitrosLeche'";
        $stmt = sqlsrv_prepare($conn, $tsql);
        $result = sqlsrv_execute($stmt);
        if($stmt){
            $error = sqlsrv_errors();
            $key = array_values($error[0]);
            $result2 = substr($key[4], -21);
            if ($result2 == "FechaHora Inexistente"){
                echo($result2);
                echo($espacio);
            }else{
                $result3 = substr($key[4], -38);
                echo($result3);
            }
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Upd_Ordeños.html'">
    </div>
</body>
</html>