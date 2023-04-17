<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sel_T_Vacunaciones</title>
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
        $tsql= "execute SCF.sel_TrabajadoresVacunaciones '$Cedula'";
        $getResults= sqlsrv_query($conn, $tsql);
        
        if($getResults){
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) 
            {
                echo ("Nombre del Trabajador: $row[NombredelTrabajador]<hr>");
                echo ("Cedula: $row[Cedula]<hr>");
                echo ("Fecha y hora de la vacunacion: $row[Fechadelavacunacion]<hr>");
            }
        }else{
            echo("Trabajador inexistente");
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Sel_T_Vacunaciones.html'">
    </div>
</body>
</html>