<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View_Medicamentos</title>
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
        $tsql= "select * from SCF.view_Medicamentos";
        $getResults= sqlsrv_query($conn, $tsql);
        while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) 
        {
            echo ("Nombre del medicamento: $row[Nombredelmedicamento]<hr>");
            echo ("Fecha de aplicacion: $row[Fechadeaplicacion]<hr>");
            echo ("Dosis aplicada: $row[Dosisaplicada]<hr>");
            echo ("Id de la res: $row[Iddelares]<hr>");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
</body>
</html>