#Convert Kelvin, Farhenheit and Celsius

#ask user input unit and value
[string][ValidateSet("c","f","k")]$unit = Read-Host "Please provide Unit of measurement (C, K or F) "
[float]$value = read-host "Please provide value for measurement"

#converting
if ($unit -eq "k") {
    $kelvin = $value;
    $farhenheit = ($value-273.15)*9/5+32;
    $celsius = $value-273.15;
    }

    else {
        if ($unit -eq "f") {
            $kelvin = ($value-32)*5/9+273.15;
            $farhenheit = $value;
            $celsius = ($value-32)*5/9;
            }

         else { $kelvin = $value+273.15;
                $farhenheit = $value*9/5+32;
                $celsius = $value;
                }
        }
#send value to array
$result = @( 
    [pscustomobject]@{
        Kelvin = [math]::Round($kelvin,2);
        Farhenheit = [math]::Round($farhenheit,2);
        Celsius = [math]::Round($celsius,2);
        }
    )
#display array
$result

#end of sript
