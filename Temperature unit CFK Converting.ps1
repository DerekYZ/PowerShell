#Convert Kelvin, Farhenheit and Celsius

#check input unit other than k/f/c
[string]$unit = Read-Host "Please provide Unit of measurement (C, K or F)"
while ($unit -ne "k" -and $unit -ne "f" -and $unit -ne "c") {[string]$unit = Read-Host "Invalid unit, must be C/K/F"}
[float]$value = read-host "Please provide value for measurement"
#converting
switch ($unit) { 
    k { while ($value -lt [float]0) {[float]$value = read-host "Invalid Kelvin value, minimum 0"}
        $result = @( [pscustomobject]@{
            Kelvin = [math]::Round($value,2);
            Farhenheit = [math]::Round(($value-273.15)*9/5+32,2);
            Celsius = [math]::Round($value-273.15,2);
        })
    }
    f { while ($value -lt [float]-459.7) {[float]$value = read-host "Invalid Farhenheit value, minimum -459.7"}
        $result = @( [pscustomobject]@{
            Kelvin = [math]::Round(($value-32)*5/9+273.15,2);
            Farhenheit = [math]::Round($value,2);
            Celsius = [math]::Round(($value-32)*5/9,2);
        })
    }
    c { while ($value -lt [float]-273.15) {[float]$value = read-host "Invalid Celsius value, minimum -273.15"}
        $result = @( [pscustomobject]@{
            Kelvin = [math]::Round($value+273.15,2);
            Farhenheit = [math]::Round($value*9/5+32,2);
            Celsius = [math]::Round($value,2);
        })
    }
}
#display array
$result
