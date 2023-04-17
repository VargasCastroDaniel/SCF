<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View_Reses</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "select * from SCF.view_Reses";
        $getResults= sqlsrv_query($conn, $tsql);
        while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) 
        {
            echo ("Id de la res: $row[Iddelares]<hr>");
            echo ("Numero de lote: $row[Numerodelote]<hr>");
            echo ("Tipo de alimentacion: $row[Tipo]<hr>");
            echo ("Fecha y Hora de la alimentacion: $row[FechaHora]<hr>");
            echo ("Descripcion de la alimentacion: $row[Descripcion]<hr>");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
</body>
</html>