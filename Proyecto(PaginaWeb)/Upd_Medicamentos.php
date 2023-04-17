<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upd_Medicamentos</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $Nombre = $_GET['Nombre']; 
        $NombreNuevo = $_GET['NombreNuevo']; 
        $CantidadDisponible = $_GET['CantidadDisponible']; 
        $FechaExpiracion = $_GET['FechaExpiracion'];
        $Descripcion = $_GET['Descripcion'];
        $espacio = ", o Espacios en blanco";

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.upd_Medicamentos '$Nombre', '$NombreNuevo', '$CantidadDisponible', '$FechaExpiracion', '$Descripcion'";
        $stmt = sqlsrv_prepare($conn, $tsql);
        $result = sqlsrv_execute($stmt);
        if($stmt){
            $error = sqlsrv_errors();
            $key = array_values($error[0]);
            $result2 = substr($key[4], -18);
            if ($result2 == "Nombre Inexistente"){
                echo($result2);
                echo($espacio);
            }else{
                $result3 = substr($key[4], -43);
                echo($result3);
            }
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Upd_Medicamentos.html'">
    </div>
</body>
</html>