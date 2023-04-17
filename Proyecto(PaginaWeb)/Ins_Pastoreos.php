<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ins_Pastoreos</title>
    <link rel="stylesheet" href="./estilo_button.css">
</head>
<body>
    <?php
        $NumeroLote = $_GET['NumeroLote'];
        $CantidadReses = $_GET['CantidadReses'];
        $FechaHoraInicio = $_GET['FechaHoraInicio'];
        $FechaHoraFinal = $_GET['FechaHoraFinal'];
        $espacio = ", o Espacios en blanco";
        
        $serverName = "DESKTOP-34JAGCF";
        $connectionOptions = array(
            "Database" => "SistemaControlFinca",
            "UID" => "Daniel",
            "PWD" => "proyecto"
        );    
        
        $conn = sqlsrv_connect($serverName, $connectionOptions) or die('Error al conectar con la base de datos');
        $tsql= "execute SCF.ins_Pastoreos '$NumeroLote', '$CantidadReses', '$FechaHoraInicio', '$FechaHoraFinal'";
        $stmt = sqlsrv_prepare($conn, $tsql);
        $result = sqlsrv_execute($stmt);
        if($stmt){
            $error = sqlsrv_errors();
            $key = array_values($error[0]);
            $result2 = substr($key[4], -19);
            if ($result2 == "NumeroLote Repetido"){
                echo($result2);
                echo($espacio);
            }else{
                $result3 = substr($key[4], -38);
                echo($result3);
            }
        }
    ?>
    <div class="Regresar">
            <input type="button" value="Regresar al inicio" onclick="window.location='vis_general.html'">
    </div>
    
    <div class="Atras">
            <input type="button" value="Atras" onclick="window.location='Ins_Pastoreos.html'">
    </div>
</body>
</html>