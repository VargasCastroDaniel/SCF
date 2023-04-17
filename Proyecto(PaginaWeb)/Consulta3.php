<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta_Alto_Grado_3</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $Cedula = $_GET['Cedula'];

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.Consulta3 '$Cedula'";
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
            <input type="button" value="Atras" onclick="window.location='Consulta3.html'">
    </div>
</body>
</html>