<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta_Alto_Grado_4</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $Cedula = $_GET['IdRes'];
        $FechaI = $_GET['FechaI'];
        $FechaF = $_GET['FechaF'];

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.Consulta4 '$IdRes', '$FechaI', '$FechaF'";
        $getResults= sqlsrv_query($conn, $tsql);
        
        $tsq= "select * from SCF.Prints";
        $getResult= sqlsrv_query($conn, $tsq);
        while ($row = sqlsrv_fetch_array($getResult, SQLSRV_FETCH_ASSOC)) 
        {
            echo ("$row[Dato]<hr>");
        }

    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Consulta4.html'">
    </div>
</body>
</html>