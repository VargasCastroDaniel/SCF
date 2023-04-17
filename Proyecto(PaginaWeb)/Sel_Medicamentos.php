<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sel_Medicamentos</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $Nombre = $_GET['Nombre'];

        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.sel_Medicamentos '$Nombre'";
        $getResults= sqlsrv_query($conn, $tsql);
        
        if($getResults){
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) 
            {
                echo ("Nombre: $row[Nombre]<hr>");
                echo ("Cantidad disponible: $row[Cantidaddisponible]<hr>");
                echo ("Fecha de expiracion: $row[Fechadeexpiracion]<hr>");
                echo ("Descripcion: $row[Descripcion]<hr>");
            }
        }else{
            echo("Medicamento inexistente");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Sel_Medicamentos.html'">
    </div>
</body>
</html>