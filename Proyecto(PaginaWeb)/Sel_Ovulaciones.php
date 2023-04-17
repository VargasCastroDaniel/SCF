<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sel_Ovulaciones</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $FechaHora = $_GET['FechaHora'];

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );    
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.sel_Ovulaciones '$FechaHora'";
        $getResults= sqlsrv_query($conn, $tsql);
       
        if($getResults){
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) 
            {
                echo ("Fecha y Hora de la ovulacion: $row[FechayHora]<hr>");
                echo ("Descripcion: $row[Descripcion]<hr>");
            }
        }else{
            echo("Ovulacion inexistente");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Sel_Ovulaciones.html'">
    </div>
</body>
</html>