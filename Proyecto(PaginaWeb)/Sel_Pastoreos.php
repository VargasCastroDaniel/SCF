<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sel_Pastoreos</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $NumeroLote = $_GET['NumeroLote'];

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );    
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.sel_Pastoreos '$NumeroLote'";
        $getResults= sqlsrv_query($conn, $tsql);
        
        if($getResults){
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) 
            {
                echo ("Numero de lote: $row[Numerodelote]<hr>");
                echo ("Cantidad de Reses: $row[CantidaddeReses]<hr>");
                echo ("Fecha y Hora de inicio: $row[FechayHoradeinicio]<hr>");
                echo ("Fecha y Hora de finalizacion: $row[FechayHoradefinalizacion]<hr>");
            }
        }else{
            echo("Pastoreo inexistente");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Sel_Pastoreos.html'">
    </div>
</body>
</html>