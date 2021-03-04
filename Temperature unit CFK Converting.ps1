#Convert Kelvin, Farhenheit and Celsius

#check input unit other than k/f/c
do {[string]$unit = Read-Host "Please provide Unit of measurement (C, K or F):>"}
while ($unit -ne "k" -and $unit -ne "f" -and $unit -ne "c") 
#set limit
[float]$limitk = 0
[float]$limitf = -459.7
[float]$limitc = -273.16
[float]$value = read-host "Please provide value for measurement:>"
#converting
switch ($unit) {
    {($_ -eq "k") -and ($value -ge $limitk)} {
        $kelvin = $value;
        $farhenheit = ($value-273.15)*9/5+32;
        $celsius = $value-273.15;
    }
    {($_ -eq "f") -and ($value -ge $limitf)} {
        $kelvin = ($value-32)*5/9+273.15;
        $farhenheit = $value;
        $celsius = ($value-32)*5/9;
    }
    {($_ -eq "c") -and ($value -ge $limitc)} {
        $kelvin = $value+273.15;
        $farhenheit = $value*9/5+32;
        $celsius = $value;   
    }
    default {
    write-host ("Invalid input value, minimum 0 K/ -273.16 C/ -459.7 F. Your input:"+$value+$unit);
    exit;
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
