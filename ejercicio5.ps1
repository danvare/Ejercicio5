<#
    .DESCRIPTION
                Este script se encarga de mover archivos, determinados en un archivo csv, Entrada, donde se toma el origen y el destino.
                Luego crea un archivo csv, Salida, con la fecha de en la que se movio el archivo por ultima vez y la nueva ubicacion de este.
                La Entrada y la salida son pasadas por parametross del mismo nombre.

                1) Hay que correr el script
                2) Luego introducir Entrada
                3) Luego introducir Salida

    .EXAMPLE
            ./ejercicio5.ps1 ./Ejercicio5/ejemplo1.txt
#>

Param([Parameter(Position=1,Mandatory=$True)]
    [AllowEmptyString()]
    [string]$Entrance
    )


$FlagEYS = 0

if($Entrance -eq ""){
    "`nNo introdujo una direccion en la Entrada"
    $FlagEYS = 1
} else {
    try {
        $valido+=Import-Csv $Entrance
    } catch [System.Exception] {
        "`nArchivo de Entrada no encontrado"
        $FlagEYS = 1
    }
}
##
if($($FlagEYS -1) -eq 0){
    "`nNo introdujo una direccion de Entrada valida"
} else {
##
#
$Entrada = $Entrance

$File = Get-Content -Path $Entrada


    if($File -eq $null){
        "Vacio"
    } else {
        $DatosTabla = $File[0]
    }

    $Aexpo=@()
    
    $data=@()

    $arrayNuevo=@()

    $data1 = "$($comilla)Materia$($comilla),$($comilla)Final$($comilla),$($comilla)Recursan$($comilla),$($comilla)Recuperan$($comilla),$($comilla)Abandonaron$($comilla)"

#

$Dni = Get-Content $Entrada | %{ $_.Split('|')[0]; }

$Idmateria = Get-Content $Entrada | %{ $_.Split('|')[1]; }

$Parcial1 = Get-Content $Entrada | %{ $_.Split('|')[2]; }

$Parcial2 = Get-Content $Entrada | %{ $_.Split('|')[3]; }

$RecuParcial = Get-Content $Entrada | %{ $_.Split('|')[4]; }

$RecuNota = Get-Content $Entrada | %{ $_.Split('|')[5]; }

$Final = Get-Content $Entrada | %{ $_.Split('|')[6]; }

for($i=1;$i -lt $File.count;$i++){
$Flag = 1


    if($File[$i] -eq ""){
            "Renglon en blanco"
            $Flag = 0
    }

    if($Dni[$i] -eq ""){
            "Dni en Blanco"
            $Flag = 0
    }

    if($Idmateria[$i] -eq ""){
            "Idmateria en Blanco"
            $Flag = 0
    }

    if($Idmateria[$i] -eq ""){
            "Idmateria en Blanco"
            $Flag = 0
    }

    if($Parcial1[$i] -eq ""){
    } else {
        if($($Parcial1[$i]-10) -gt 0){
            "Parcial 1 mayor a 10"
            $Flag = 0
        } else {
            if($($Parcial1[$i]-1) -lt 0){
                "Parcial 1 menor a 1"
                $Flag = 0
            }
        }
    }

    if($Parcial2[$i] -eq ""){
    } else {
        if($($Parcial2[$i]-10) -gt 0){
            "Parcial 2 mayor a 10"
            $Flag = 0
        } else {
            if($($Parcial2[$i]-1) -lt 0){
                "Parcial 2 menor a 1"
                $Flag = 0
            }
        }
    }

    if($RecuParcial[$i] -eq ""){
    } else {
        if($($RecuParcial[$i]-10) -gt 0){
            "No hay mas de 2 parciales"
            $Flag = 0
        }
    }

    if($RecuNota[$i] -eq ""){
    } else {
        if($($RecuNota[$i]-10) -gt 0){
            "Nota de recuperatorio mayor a 10"
            $Flag = 0
        } else {
            if($($RecuNota[$i]-1) -lt 0){
                "Nota de recuperatorio menor a 1"
                $Flag = 0
            }
        }
    }

    if($Final[$i] -eq ""){
    } else {
        if($($Final[$i]-10) -gt 0){
            "Nota de recuperatorio mayor a 10"
            $Flag = 0
        } else {
            if($($Final[$i]-1) -lt 0){
                "Nota de recuperatorio menor a 1"
                $Flag = 0
            }
        }
    }

    if($($Flag-1) -eq 0){
        if($Parcial1[$i] -eq ""){
            if($Parcial2[$i] -eq ""){
                #No asistio a ningun parcial. Abandono
                $NuevoCampo = 1

                for($p=0;$p -lt $arrayNuevo.count;$p++){
                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                        $NuevoCampo = 0
                
                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                    }
                }

                if($($NuevoCampo -1) -eq 0){

                    $AFinal = 0
                    $ARecursan = 0
                    $Recuperan = 0
                    $Abandonaron = 1

                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                }
            } else {
                if($($Parcial2[$i]-7) -ge 0){
                    if($RecuParcial[$i] -eq ""){
                        #No asistio al primer parcial. Rindio bien el segundo. No asistio al Recuperatorio. Abandono
                        $NuevoCampo = 1

                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                $NuevoCampo = 0
                
                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                            }
                        }

                        if($($NuevoCampo -1) -eq 0){

                            $AFinal = 0
                            $ARecursan = 0
                            $Recuperan = 0
                            $Abandonaron = 1

                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                        }
                    } else {
                        if($($RecuParcial[$i]-1) -eq 0){
                            if($RecuNota[$i] -eq ""){
                                #No asistio al primer parcial. Rindio bien el segundo. No asistio al Recuperatorio. Iba a hacerlo. Abandono
                                $NuevoCampo = 1

                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                    }
                                }

                                if($($NuevoCampo -1) -eq 0){

                                    $AFinal = 0
                                    $ARecursan = 0
                                    $Recuperan = 0
                                    $Abandonaron = 1

                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                                }
                            } else {
                                if($($RecuNota[$i]-7) -ge 0){
                                    #No asistio al primer parcial. Rindio bien el segundo. Dio bien el Recuperatorio. Aprobado
                                } else {
                                    if($($RecuNota[$i]-4) -ge 0){
                                        if($Final[$i] -eq ""){
                                            #No asistio al primer parcial. Rindio bien el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                            $NuevoCampo = 1

                                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 1
                                                $ARecursan = 0
                                                $Recuperan = 0
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                            }
                                        } else {
                                            if($($Final[$i]-4) -ge 0){
                                                #No asistio al primer parcial. Rindio bien el segundo. Recuperatorio a Final. Dio bien el Final.
                                            }else {
                                                #No asistio al primer parcial. Rindio bien el segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                #            
                                                $NuevoCampo = 1

                                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 1
                                                    $ARecursan = 0
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                }
                                                #
                                            }
                                        }
                                    } else {
                                        #No asistio al primer parcial. Rindio bien el segundo. Dio mal el Recuperatorio. Recursa            
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 1
                                            $ARecursan = 0
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                        }
                                    }
                                }
                            }
                        } else {
                            #No asistio al primer parcial. Rindio bien el segundo. Se equivoco de Recuperatorio. Abandono
                            $NuevoCampo = 1

                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                    $NuevoCampo = 0
                
                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                }
                            }

                            if($($NuevoCampo -1) -eq 0){

                                $AFinal = 0
                                $ARecursan = 0
                                $Recuperan = 0
                                $Abandonaron = 1

                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                            }
                        }
                    }
                } else {
                    if($($Parcial2[$i]-4) -ge 0){
                        if($RecuParcial[$i] -eq ""){
                            #No asistio al primer parcial. Puede llegar a final por el segundo. No asistio al Recuperatorio. Abandono
                            $NuevoCampo = 1

                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                    $NuevoCampo = 0
                
                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                }
                            }

                            if($($NuevoCampo -1) -eq 0){

                                $AFinal = 0
                                $ARecursan = 0
                                $Recuperan = 0
                                $Abandonaron = 1

                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                            }
                        } else {
                                if($($RecuParcial[$i]-1) -eq 0){
                                    if($RecuNota[$i] -eq ""){
                                        #No asistio al primer parcial. Puede llegar a final por el segundo. No asistio al Recuperatorio. Iba a hacerlo. Abandono
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 0
                                            $Recuperan = 0
                                            $Abandonaron = 1

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                                        }
                                    } else {
                                    if($($RecuNota[$i]-4) -ge 0){
                                        if($Final[$i] -eq ""){
                                            #No asistio al primer parcial. Puede llegar a final por el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                            $NuevoCampo = 1

                                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 1
                                                $ARecursan = 0
                                                $Recuperan = 0
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                            }
                                        } else {
                                            if($($Final[$i]-4) -ge 0){
                                                #No asistio al primer parcial. Puede llegar a final por el segundo. Recuperatorio a Final. Dio bien el Final.
                                            } else {
                                                #No asistio al primer parcial. Puede llegar a final por el segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                $NuevoCampo = 1

                                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 1
                                                    $ARecursan = 0
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                }
                                            }
                                        }
                                    } else {
                                        #No asistio al primer parcial. Puede llegar a final por el segundo. Dio mal el Recuperatorio. Recursa
                                        $NuevoCampo = 1

                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 1
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                        }
                                    }
                                }
                            } else {
                                #No asistio al primer parcial. Puede llegar a final por el segundo. Se equivoco de Recuperatorio. Abandono
                                $NuevoCampo = 1

                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                    }
                                }

                                if($($NuevoCampo -1) -eq 0){

                                    $AFinal = 0
                                    $ARecursan = 0
                                    $Recuperan = 0
                                    $Abandonaron = 1

                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                                }
                            }
                        }
                    } else {
                        #No asistio al primer parcial. Dio mal el segundo. Abandono
                        $NuevoCampo = 1

                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                $NuevoCampo = 0
                
                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                            }
                        }

                        if($($NuevoCampo -1) -eq 0){

                            $AFinal = 0
                            $ARecursan = 0
                            $Recuperan = 0
                            $Abandonaron = 1

                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                        }
                    }
                }
            }
        } else {
            if($($Parcial1[$i]-7) -ge 0){
                if($Parcial2[$i] -eq ""){
                    if($RecuParcial[$i] -eq ""){
                        #Dio bien el primer parcial. No asistio al segundo. No asistio al Recuperatorio. Abandono
                        $NuevoCampo = 1

                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                $NuevoCampo = 0
                
                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                            }
                        }

                        if($($NuevoCampo -1) -eq 0){

                            $AFinal = 0
                            $ARecursan = 0
                            $Recuperan = 0
                            $Abandonaron = 1

                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                        }
                    } else {
                        if($($RecuParcial[$i]-2) -eq 0){
                            if($RecuNota[$i] -eq ""){
                                #Dio bien el primer parcial. No asistio al segundo. No asistio al Recuperatorio. Iba a hacerlo. Abandono
                                $NuevoCampo = 1

                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                    }
                                }

                                if($($NuevoCampo -1) -eq 0){

                                    $AFinal = 0
                                    $ARecursan = 0
                                    $Recuperan = 0
                                    $Abandonaron = 1

                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                                }
                            } else {
                                if($($RecuNota[$i]-7) -ge 0){
                                    #Dio bien el primer parcial. No asistio al segundo. Dio bien el Recuperatorio.
                                } else {
                                    if($($RecuNota[$i]-4) -ge 0){
                                        if($Final[$i] -eq ""){
                                            #Dio bien el primer parcial. No asistio al segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                            $NuevoCampo = 1

                                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 1
                                                $ARecursan = 0
                                                $Recuperan = 0
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                            }
                                        } else {
                                            if($($Final[$i]-4) -ge 0){
                                                #Dio bien el primer parcial. No asistio al segundo. Recuperatorio a Final. Dio bien el Final.
                                            } else {
                                                #Dio bien el primer parcial. No asistio al segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    } else {
                                        #Dio bien el primer parcial. No asistio al segundo. Dio mal el Recuperatorio. Recursa
                                        $NuevoCampo = 1

                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 1
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                        }
                                    }
                                }
                            }
                        } else {
                            #Dio bien el primer parcial. No asistio al segundo. Se equivoco de Recuperatorio. Abandono
                            $NuevoCampo = 1

                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                    $NuevoCampo = 0
                
                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                }
                            }

                            if($($NuevoCampo -1) -eq 0){

                                $AFinal = 0
                                $ARecursan = 0
                                $Recuperan = 0
                                $Abandonaron = 1

                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                            }
                        }
                    }
                } else {
                    if($($Parcial2[$i]-7) -ge 0){
                        #Dio bien el primer parcial. Dio bien el segundo.
                    } else {
                        if($($Parcial2[$i]-4) -ge 0){
                            if($RecuParcial[$i] -eq ""){
                                if($Final[$i] -eq ""){
                                    #Dio bien el primer parcial. Puede llegar al Final por el segundo. No asistio al Recuperatorio. No asistio al Final. Puede Recuperar
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                            $NuevoCampo = 0
                
                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                        $AFinal = 0
                                        $ARecursan = 0
                                        $Recuperan = 1
                                        $Abandonaron = 0

                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                    }
                                } else {
                                    if($($Final[$i]-4) -ge 0){
                                        #Dio bien el primer parcial. Puede llegar al Final por el segundo. No asistio al Recuperatorio. Dio bien el Final.
                                    } else {
                                        #Dio bien el primer parcial. Puede llegar al Final por el segundo. No asistio al Recuperatorio. Dio mal el Final. Recursa
                                        $NuevoCampo = 1

                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 1
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                        }
                                    }
                                }
                            } else {
                                if($($RecuParcial[$i]-2) -eq 0){
                                    if($RecuNota[$i] -eq ""){
                                        if($Final[$i] -eq ""){
                                            #Dio bien el primer parcial. Puede llegar al Final por el segundo. No asistio al Recuperatorio. Iba a hacerlo. No asistio al Final. Puede Recuperar 
                                            $NuevoCampo = 1

                                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 0
                                                $ARecursan = 0
                                                $Recuperan = 1
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                            }
                                        } else {
                                            if($($Final[$i]-4) -ge 0){
                                                #Dio bien el primer parcial. Puede llegar al Final por el segundo. No asistio al Recuperatorio. Iba a hacerlo. Dio bien el Final.
                                            } else {
                                                #Dio bien el primer parcial. Puede llegar al Final por el segundo. No asistio al Recuperatorio. Iba a hacerlo. Dio mal el Final. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    } else {
                                        if($($RecuNota[$i]-7) -ge 0){
                                            #Dio bien el primer parcial. Puede llegar al Final por el segundo. Dio bien el Recuperatorio.
                                        } else {
                                            if($($RecuNota[$i]-4) -ge 0){
                                                if($Final[$i] -eq ""){
                                                    #Dio bien el primer parcial. Puede llegar al Final por el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                                    $NuevoCampo = 1

                                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                            $NuevoCampo = 0
                
                                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                        }
                                                    }

                                                    if($($NuevoCampo -1) -eq 0){

                                                        $AFinal = 1
                                                        $ARecursan = 0
                                                        $Recuperan = 0
                                                        $Abandonaron = 0

                                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                    }
                                                } else {
                                                    if($($Final[$i]-4) -ge 0){
                                                        #Dio bien el primer parcial. Puede llegar al Final por el segundo. Recuperatorio a Final. Dio bien el Final.
                                                    } else {
                                                        #Dio bien el primer parcial. Puede llegar al Final por el segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                        $NuevoCampo = 1

                                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                                $NuevoCampo = 0
                
                                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                            }
                                                        }

                                                        if($($NuevoCampo -1) -eq 0){

                                                            $AFinal = 0
                                                            $ARecursan = 1
                                                            $Recuperan = 0
                                                            $Abandonaron = 0

                                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                        }
                                                    }
                                                }
                                            } else {
                                                #Dio bien el primer parcial. Puede llegar al Final por el segundo. Dio mal el Recuperatorio. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    if($Final[$i] -eq ""){
                                        #Dio bien el primer parcial. Puede llegar al Final por el segundo. Se equivoco de Recuperatorio. No asistio al Final. Puede Recuperar
                                        #
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 0
                                            $Recuperan = 1
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                        }
                                        #
                                    } else {
                                        if($($Final[$i]-4) -ge 0){
                                            #Dio bien el primer parcial. Puede llegar al Final por el segundo. Se equivoco de Recuperatorio. Dio bien el Final.
                                        } else {
                                            #Dio bien el primer parcial. Puede llegar al Final por el segundo. Se equivoco de Recuperatorio. Dio mal el Final. Recursa
                                            $NuevoCampo = 1

                                            for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 0
                                                $ARecursan = 1
                                                $Recuperan = 0
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            if($RecuParcial[$i] -eq ""){
                                #Dio bien el primer parcial. Dio mal el segundo. No asistio al Recuperatorio. Puede Recuperar
                                $NuevoCampo = 1

                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                    }
                                }

                                if($($NuevoCampo -1) -eq 0){

                                    $AFinal = 0
                                    $ARecursan = 0
                                    $Recuperan = 1
                                    $Abandonaron = 0

                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                }
                            } else {
                                if($($RecuParcial[$i]-2) -eq 0){
                                    if($RecuNota[$i] -eq ""){
                                        #Dio bien el primer parcial. Dio mal el segundo. No asistio al Recuperatorio. Iba a hacerlo. Puede Recuperar
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 0
                                            $Recuperan = 1
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                        }
                                    } else {
                                        if($($RecuNota[$i]-7) -ge 0){
                                            #Dio bien el primer parcial. Dio mal el segundo. Dio bien el Recuperatorio.
                                        } else {
                                            if($($RecuNota[$i]-4) -ge 0){
                                                if($Final[$i] -eq ""){
                                                    #Dio bien el primer parcial. Dio mal el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                                    $NuevoCampo = 1

                                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                            $NuevoCampo = 0
                
                                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                        }
                                                    }

                                                    if($($NuevoCampo -1) -eq 0){

                                                        $AFinal = 1
                                                        $ARecursan = 0
                                                        $Recuperan = 0
                                                        $Abandonaron = 0

                                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                    }
                                                } else {
                                                    if($($Final[$i]-4) -ge 0){
                                                        #Dio bien el primer parcial. Dio mal el segundo. Recuperatorio a Final. Dio bien el Final.
                                                    } else {
                                                        #Dio bien el primer parcial. Dio mal el segundo. Recuperatorio a Final. Dio bien el Final. Recursa
                                                        $NuevoCampo = 1

                                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                                $NuevoCampo = 0
                
                                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                            }
                                                        }

                                                        if($($NuevoCampo -1) -eq 0){

                                                            $AFinal = 0
                                                            $ARecursan = 1
                                                            $Recuperan = 0
                                                            $Abandonaron = 0

                                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                        }
                                                    }
                                                }
                                            } else {
                                                #Dio bien el primer parcial. Dio mal el segundo. Dio mal el Recuperatorio. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    #Dio bien el primer parcial. Dio mal el segundo. Se equivoco de Recuperatorio. Puede Recuperar
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                            $NuevoCampo = 0
                
                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                        $AFinal = 0
                                        $ARecursan = 0
                                        $Recuperan = 1
                                        $Abandonaron = 0

                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if($($Parcial1[$i]-4) -ge 0){
                    if($Parcial2[$i] -eq ""){
                        if($RecuParcial[$i] -eq ""){
                            #Puede llegar a final por el primer parcial. No asistio al segundo. No asistio al Recuperatorio. Abandono
                            $NuevoCampo = 1

                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                    $NuevoCampo = 0
                
                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                }
                            }

                            if($($NuevoCampo -1) -eq 0){

                                $AFinal = 0
                                $ARecursan = 0
                                $Recuperan = 0
                                $Abandonaron = 1

                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                            }
                        } else {
                            if($($RecuParcial[$i]-2) -eq 0){
                                if($RecuNota[$i] -eq ""){
                                    #Puede llegar a final por el primer parcial. No asistio al segundo. No asistio al Recuperatorio. Iba a hacerlo. Abandono
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                            $NuevoCampo = 0
                
                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                        $AFinal = 0
                                        $ARecursan = 0
                                        $Recuperan = 0
                                        $Abandonaron = 1

                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                                    }
                                } else {
                                    if($($RecuNota[$i]-4) -ge 0){
                                        if($Final[$i] -eq ""){
                                            #Puede llegar a final por el primer parcial. No asistio al segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                            $NuevoCampo = 1

                                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 1
                                                $ARecursan = 0
                                                $Recuperan = 0
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                            }
                                        } else {
                                            if($($Final[$i]-4) -ge 0){
                                                #Puede llegar a final por el primer parcial. No asistio al segundo. Recuperatorio a Final. Dio bien el Final.
                                            } else {
                                                #Puede llegar a final por el primer parcial. No asistio al segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    } else {
                                        #Puede llegar a final por el primer parcial. No asistio al segundo. Dio mal el Recuperatorio. Recursa
                                        $NuevoCampo = 1

                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 1
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                        }
                                    }
                                }
                            } else {
                                #Puede llegar a final por el primer parcial. No asistio al segundo. Se equivoco de Recuperatorio. Recursa
                                $NuevoCampo = 1

                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                    }
                                }

                                if($($NuevoCampo -1) -eq 0){

                                    $AFinal = 0
                                    $ARecursan = 1
                                    $Recuperan = 0
                                    $Abandonaron = 0

                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                }
                            }
                        }
                    } else {
                        if($($Parcial2[$i]-7) -ge 0){
                            if($RecuParcial[$i] -eq ""){
                                if($Final[$i] -eq ""){
                                    #Puede llegar a final por el primer parcial. Dio bien el segundo. No asistio al Recuperatorio. No asistio al Final. Puede Recuperar                                        
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                            $NuevoCampo = 0
                
                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                        $AFinal = 0
                                        $ARecursan = 0
                                        $Recuperan = 1
                                        $Abandonaron = 0

                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                    }
                                } else {
                                    if($($Final[$i]-4) -ge 0){
                                        #Puede llegar a final por el primer parcial. Dio bien el segundo. No asistio al Recuperatorio. Dio bien el Final.
                                    } else {
                                        #Puede llegar a final por el primer parcial. Dio bien el segundo. No asistio al Recuperatorio. Dio mal el Final. Recursa
                                        $NuevoCampo = 1

                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 1
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                        }
                                    }
                                }
                            } else {
                                if($($RecuParcial[$i]-1) -eq 0){
                                    if($RecuNota[$i] -eq ""){
                                        if($Final[$i] -eq ""){
                                            #Puede llegar a final por el primer parcial. Dio bien el segundo. No asistio al Recuperatorio. Iba a hacerlo. No asistio al Final. Puede Recuperar                                        
                                            #
                                            $NuevoCampo = 1

                                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 0
                                                $ARecursan = 0
                                                $Recuperan = 1
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                            }
                                            #
                                        } else {
                                            if($($Final[$i]-4) -ge 0){
                                                #Puede llegar a final por el primer parcial. Dio bien el segundo. No asistio al Recuperatorio. Iba a hacerlo. Dio bien el Final.
                                            } else {
                                                #Puede llegar a final por el primer parcial. Dio bien el segundo. No asistio al Recuperatorio. Iba a hacerlo. Dio mal el Final. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    } else {
                                        if($($RecuNota[$i]-7) -ge 0){
                                            #Puede llegar a final por el primer parcial. Dio bien el segundo. Dio bien el Recuperatorio.
                                        } else {
                                            if($($RecuNota[$i]-4) -ge 0){
                                                if($Final[$i] -eq ""){
                                                    #Puede llegar a final por el primer parcial. Dio bien el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                                    $NuevoCampo = 1

                                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                            $NuevoCampo = 0
                
                                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                        }
                                                    }

                                                    if($($NuevoCampo -1) -eq 0){

                                                        $AFinal = 1
                                                        $ARecursan = 0
                                                        $Recuperan = 0
                                                        $Abandonaron = 0

                                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                    }
                                                } else {
                                                    if($($Final[$i]-4) -ge 0){
                                                        #Puede llegar a final por el primer parcial. Dio bien el segundo. Recuperatorio a Final. Dio bien el Final.
                                                    } else {
                                                        #Puede llegar a final por el primer parcial. Dio bien el segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                        $NuevoCampo = 1

                                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                                $NuevoCampo = 0
                
                                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                            }
                                                        }

                                                        if($($NuevoCampo -1) -eq 0){

                                                            $AFinal = 0
                                                            $ARecursan = 1
                                                            $Recuperan = 0
                                                            $Abandonaron = 0

                                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                        }
                                                    }
                                                }
                                            } else {
                                                #Puede llegar a final por el primer parcial. Dio bien el segundo. Dio mal el Recuperatorio. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    if($Final[$i] -eq ""){
                                        #Puede llegar a final por el primer parcial. Dio bien el segundo. Se equivoco de Recuperatorio. No asistio al Final. Puede Recuperar                                        
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 0
                                            $Recuperan = 1
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                        }
                                    } else {
                                        if($($Final[$i]-4) -ge 0){
                                            #Puede llegar a final por el primer parcial. Dio bien el segundo. Se equivoco de Recuperatorio. Dio bien el Final.
                                        } else {
                                            #Puede llegar a final por el primer parcial. Dio bien el segundo. Se equivoco de Recuperatorio. Dio mal el Final. Recursa
                                            $NuevoCampo = 1

                                            for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 0
                                                $ARecursan = 1
                                                $Recuperan = 0
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            if($($Parcial2[$i]-4) -ge 0){
                                if($Final[$i] -eq ""){
                                    #Puede llegar a final por el primer parcial. Puede llegar a final por el segundo. No asistio al Final. Apto para dar Final
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                        $AFinal = 1
                                        $ARecursan = 0
                                        $Recuperan = 0
                                        $Abandonaron = 0

                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                    }
                                } else {
                                    if($($Final[$i]-4) -ge 0){
                                        #Puede llegar a final por el primer parcial. Puede llegar a final por el segundo. Dio bien el Final.
                                    } else {
                                        #Puede llegar a final por el primer parcial. Puede llegar a final por el segundo. Dio mal el Final. Recursa
                                        $NuevoCampo = 1

                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 1
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                        }
                                    }
                                }
                            } else {
                                if($RecuParcial[$i] -eq ""){
                                    #Puede llegar a final por el primer parcial. Dio mal el segundo. No asistio al Recuperatorio. Puede Recuperar
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                            $NuevoCampo = 0
                
                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 1
                                            $ARecursan = 0
                                            $Recuperan = 0
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                    }
                                } else {
                                    if($($RecuParcial[$i]-2) -eq 0){
                                        if($RecuNota[$i] -eq ""){
                                            #Puede llegar a final por el primer parcial. Dio mal el segundo. No asistio al Recuperatorio. Iba a hacerlo. Puede Recuperar                                        
                                            $NuevoCampo = 1

                                            for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 0
                                                $ARecursan = 0
                                                $Recuperan = 1
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                            }
                                        } else {
                                            if($($RecuNota[$i]-4) -ge 0){
                                                if($Final[$i] -eq ""){
                                                    #Puede llegar a final por el primer parcial. Dio mal el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                                    $NuevoCampo = 1

                                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                            $NuevoCampo = 0
                
                                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                        }
                                                    }

                                                    if($($NuevoCampo -1) -eq 0){

                                                            $AFinal = 1
                                                            $ARecursan = 0
                                                            $Recuperan = 0
                                                            $Abandonaron = 0

                                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                    }
                                                } else {
                                                    if($($Final[$i]-4) -ge 0){
                                                        #Puede llegar a final por el primer parcial. Dio mal el segundo. Recuperatorio a Final. Dio bien el Final. Aprobado
                                                    } else {
                                                        #Puede llegar a final por el primer parcial. Dio mal el segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                        $NuevoCampo = 1

                                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                                $NuevoCampo = 0
                
                                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                            }
                                                        }

                                                        if($($NuevoCampo -1) -eq 0){

                                                            $AFinal = 0
                                                            $ARecursan = 1
                                                            $Recuperan = 0
                                                            $Abandonaron = 0

                                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                        }
                                                    }
                                                }
                                            } else {
                                                #Puede llegar a final por el primer parcial. Dio mal el segundo. Dio mal el Recuperatorio. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    } else {
                                        #Puede llegar a final por el primer parcial. Dio mal el segundo. Se equivoco de Recuperatorio. Puede Recuperar                                        
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 0
                                            $Recuperan = 1
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if($Parcial2[$i] -eq ""){
                        #Dio mal el primer parcial. No asistio al segundo. Abandono
                        $NuevoCampo = 1

                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                $NuevoCampo = 0
                
                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$([int]$arrayNuevo[$p].Split('|')[4]+1)"

                            }
                        }

                        if($($NuevoCampo -1) -eq 0){

                            $AFinal = 0
                            $ARecursan = 0
                            $Recuperan = 0
                            $Abandonaron = 1

                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
        
                        }
                    } else {
                        if($($Parcial2[$i]-7) -ge 0){
                            if($RecuParcial[$i] -eq ""){
                                #Dio mal el primer parcial. Dio bien el segundo. No asistio al recuperatorio. Puede Recuperar
                                $NuevoCampo = 1

                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                    }
                                }

                                if($($NuevoCampo -1) -eq 0){

                                    $AFinal = 0
                                    $ARecursan = 0
                                    $Recuperan = 1
                                    $Abandonaron = 0

                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                }
                            } else {
                                if($($RecuParcial[$i]-1) -eq 0){
                                    if($RecuNota[$i] -eq ""){
                                        #Dio mal el primer parcial. Dio bien el segundo. No asistio al recuperatorio. Iba a hacerlo. Puede Recuperar                                        
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 0
                                            $Recuperan = 1
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                        }
                                    } else {
                                        if($($RecuNota[$i]-7) -ge 0){
                                            #Dio mal el primer parcial. Dio bien el segundo. Dio bien el recuperatorio.
                                        } else {
                                            if($($RecuNota[$i]-4) -ge 0){
                                                if($Final[$i] -eq ""){
                                                    #Dio mal el primer parcial. Dio bien el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                                    $NuevoCampo = 1

                                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                            $NuevoCampo = 0
                
                                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                        }
                                                    }

                                                    if($($NuevoCampo -1) -eq 0){

                                                            $AFinal = 1
                                                            $ARecursan = 0
                                                            $Recuperan = 0
                                                            $Abandonaron = 0

                                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                    }
                                                } else {
                                                    if($($Final[$i]-4) -ge 0){
                                                        #Dio mal el primer parcial. Dio bien el segundo. Recuperatorio a Final. Dio bien el Final.
                                                    } else {
                                                        #Dio mal el primer parcial. Dio bien el segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                        $NuevoCampo = 1

                                                        for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                            if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                                $NuevoCampo = 0
                
                                                                $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                            }
                                                        }

                                                        if($($NuevoCampo -1) -eq 0){

                                                            $AFinal = 0
                                                            $ARecursan = 1
                                                            $Recuperan = 0
                                                            $Abandonaron = 0

                                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                        }
                                                    }
                                                }
                                            } else {
                                                #Dio mal el primer parcial. Dio bien el segundo. Dio mal el Recuperatorio. Recursa
                                                $NuevoCampo = 1

                                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                    $AFinal = 0
                                                    $ARecursan = 1
                                                    $Recuperan = 0
                                                    $Abandonaron = 0

                                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    #Dio mal el primer parcial. Dio bien el segundo. Se equivoco de Recuperatorio. Puede Recuperar
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                            $NuevoCampo = 0
                
                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                        $AFinal = 0
                                        $ARecursan = 0
                                        $Recuperan = 1
                                        $Abandonaron = 0

                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                    }
                                }
                            }
                        } else {
                            if($($Parcial2[$i]-4) -ge 0){
                                if($RecuParcial[$i] -eq ""){
                                    #Dio mal el primer parcial. Puede ir a Final por el segundo. No asistio al Recuperatorio. Puede Recuperar
                                    $NuevoCampo = 1

                                    for($p=0;$p -lt $arrayNuevo.count;$p++){
                                        if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                            $NuevoCampo = 0
                
                                            $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                        }
                                    }

                                    if($($NuevoCampo -1) -eq 0){

                                        $AFinal = 0
                                        $ARecursan = 0
                                        $Recuperan = 1
                                        $Abandonaron = 0

                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                    }
                                } else {
                                    if($($RecuParcial[$i]-1) -eq 0){
                                        if($($RecuNota[$i]-4) -ge 0){
                                            if($Final[$i] -eq ""){
                                                #Dio mal el primer parcial. Puede ir a Final por el segundo. Recuperatorio a Final. No asistio al Final. Apto para dar Final
                                                $NuevoCampo = 1

                                                for($p=0;$p -lt $arrayNuevo.count;$p++){
                                                    if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){

                                                        $NuevoCampo = 0
                
                                                        $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$([int]$arrayNuevo[$p].Split('|')[1]+1)|$($arrayNuevo[$p].Split('|')[2])|$($arrayNuevo[$p].Split('|')[3])|$($arrayNuevo[$p].Split('|')[4])"

                                                    }
                                                }

                                                if($($NuevoCampo -1) -eq 0){

                                                        $AFinal = 1
                                                        $ARecursan = 0
                                                        $Recuperan = 0
                                                        $Abandonaron = 0

                                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                            
                                                }
                                            } else {
                                                if($($Final[$i]-4) -ge 0){
                                                    #Dio mal el primer parcial. Puede ir a Final por el segundo. Recuperatorio a Final. Dio bien el Final.
                                                } else {
                                                    #Dio mal el primer parcial. Puede ir a Final por el segundo. Recuperatorio a Final. Dio mal el Final. Recursa
                                                    $NuevoCampo = 1

                                                    for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                        if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                            $NuevoCampo = 0
                
                                                            $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                        }
                                                    }

                                                    if($($NuevoCampo -1) -eq 0){

                                                        $AFinal = 0
                                                        $ARecursan = 1
                                                        $Recuperan = 0
                                                        $Abandonaron = 0

                                                        $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                                    }
                                                }
                                            }
                                        } else {
                                            #Dio mal el primer parcial. Puede ir a Final por el segundo. Dio mal el Recuperatorio. Recursa
                                            $NuevoCampo = 1

                                            for($j=0;$j -lt $arrayNuevo.count;$j++){
                                                if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                                    $NuevoCampo = 0
                
                                                    $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                                }
                                            }

                                            if($($NuevoCampo -1) -eq 0){

                                                $AFinal = 0
                                                $ARecursan = 1
                                                $Recuperan = 0
                                                $Abandonaron = 0

                                                $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                            }
                                        }
                                    } else {
                                        #Dio mal el primer parcial. Puede ir a Final por el segundo. Se equivoco de Recuperatorio. Puede Recuperar                                        
                                        $NuevoCampo = 1

                                        for($p=0;$p -lt $arrayNuevo.count;$p++){
                                            if($($Idmateria)[$i] -eq $arrayNuevo[$p].Split('|')[0]){
                                                $NuevoCampo = 0
                
                                                $arrayNuevo[$p] = "$($arrayNuevo[$p].Split('|')[0])|$($arrayNuevo[$p].Split('|')[1])|$($arrayNuevo[$p].Split('|')[2])|$([int]$arrayNuevo[$p].Split('|')[3]+1)|$($arrayNuevo[$p].Split('|')[4])"

                                            }
                                        }

                                        if($($NuevoCampo -1) -eq 0){

                                            $AFinal = 0
                                            $ARecursan = 0
                                            $Recuperan = 1
                                            $Abandonaron = 0

                                            $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"
                        
                                        }
                                    }
                                }
                            } else {
                                #Dio mal el primer parcial. Dio mal el segundo. Recursa
                                $NuevoCampo = 1

                                for($j=0;$j -lt $arrayNuevo.count;$j++){
                                    if($($Idmateria)[$i] -eq $arrayNuevo[$j].Split('|')[0]){

                                        $NuevoCampo = 0
                
                                        $arrayNuevo[$j] = "$($arrayNuevo[$j].Split('|')[0])|$($arrayNuevo[$j].Split('|')[1])|$([int]$arrayNuevo[$j].Split('|')[2]+1)|$($arrayNuevo[$j].Split('|')[3])|$($arrayNuevo[$j].Split('|')[4])"

                                    }
                                }

                                if($($NuevoCampo -1) -eq 0){

                                    $AFinal = 0
                                    $ARecursan = 1
                                    $Recuperan = 0
                                    $Abandonaron = 0

                                    $arrayNuevo += "$($Idmateria[$i])|$AFinal|$ARecursan|$Recuperan|$Abandonaron"

        
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}            
#

for($k=0;$k -lt $arrayNuevo.count;$k++){
                $Save = New-Object psobject -Property @{
                    Materia = "$($comilla)$($arrayNuevo[$k].Split('|')[0])$($comilla)"
                    Final= "$($comilla)$($arrayNuevo[$k].Split('|')[1])$($comilla)"
                    Recursan= "$($comilla)$($arrayNuevo[$k].Split('|')[2])$($comilla)"
                    Recuperan= "$($comilla)$($arrayNuevo[$k].Split('|')[3])$($comilla)"
                    Abandonaron= "$($comilla)$($arrayNuevo[$k].Split('|')[4])$($comilla)"
                } | select Materia,Final,Recursan,Recuperan,Abandonaron
       $Aexpo += $Save

}

#

$Text = "$($Entrada.Split('/')[0])/"

for($j=1;$j -lt $($Entrada.Split('/').Count -1);$j++){

    $Text += "$($Entrada.Split('/')[$j])/"

}

$TextNE = $($Entrada.Split('/')[$($Entrada.Split('/').Count -1)])

$Text += "salida$($TextNE.Split('.')[0])"
$TextOld = "$($Text)old.csv"
$Text += ".csv"

$Aexpo       

$Aexpo | Export-Csv -Path $TextOld -NoTypeInformation


Import-Csv $TextOld | sort Materia | Export-Csv -Path $Text -NoTypeInformation

Remove-Item -Path $TextOld
$Text

##
}
##