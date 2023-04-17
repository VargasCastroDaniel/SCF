<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Del_T_Vacunaciones</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $Cedula = $_GET['Cedula'];
        $FH_Vacunacion = $_GET['FH_Vac'];

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.del_TrabajadoresVacunaciones '$Cedula', '$FH_Vacunacion'";
        $stmt = sqlsrv_prepare($conn, $tsql);
        $result = sqlsrv_execute($stmt);
        if($result == true){
            echo("TrabajadoresVacunaciones eliminada");
        }else{
            echo("TrabajadoresVacunaciones Inexistente");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Del_T_Vacunaciones.html'">
    </div>
</body>
</html>