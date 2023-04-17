<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sel_Ventas</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $Fecha = $_GET['Fecha'];

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );    
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.sel_Ventas '$Fecha'";
        $getResults= sqlsrv_query($conn, $tsql);
        if($getResults){
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) 
            {
                echo ("Fecha: $row[Fecha]<hr>");
                echo ("Total de Litros: $row[TotaldeLitros]<hr>");
            }
        }else{
            echo("Venta inexistente");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Sel_Ventas.html'">
    </div>
</body>
</html>