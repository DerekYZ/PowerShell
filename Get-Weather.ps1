#Function body
function get-weather {
#Fuction parameter define
[CmdletBinding()] #<<-- This turns a regular function into an advanced function
      param(#user define value
            [string]$location = (Read-host "Please input location: 'City, ST' or 'City, State'"),
            [Int32]$days = (Read-Host "Please set days of forecast (Max 3 days w/ free account)"),
            [string]$unit = (Read-Host "Please set temprature unit F or C")
      )

#Convert temp unit to upper case for better user experience
$unit = $unit.ToUpper()

#Pre-load weatherapi.com url and key
$uri = "http://api.weatherapi.com/v1/forecast.json?key=31547112f42d4761975204547211802&q="

#send request to weatherapi.com with geo info and days
$return_info = Invoke-RestMethod -uri ("$uri"+"$location"+"&days="+"$days")

#Process and push data into array by using for-loop
$data = @(#array name
  for ($i=0; $i -lt $days+1; $i++) {
      if ($i -eq 0) {#array [0] for today/ current weather
            [pscustomobject]@{
                  Location=("$location");
                  Date=(get-date).AddDays($i) | Get-Date -Format MMM-dd-yyyy;
                  "Weather"=$return_info.current.condition.text;
                  "Temp. Now ($unit)"=$return_info.current.("temp_"+"$unit");
                  "Feels like ($unit)"=$return_info.current.("feelslike_"+"$unit");
                  "Max Temp. ($unit)"=" ";
                  "Min Temp. ($unit)"=" ";#Due to data structure, index row needs max elements number
                              }
                  }
             else {
                   if ($days -eq 1) {
                  #array [1] for one day forecast because only one element in condition.text
                        [pscustomobject]@{
                              Location=("$location");
                              Date=(get-date).AddDays($i) | Get-Date -Format MMM-dd-yyyy;
                              "Weather"=$return_info.forecast.forecastday.day.condition.text;
                              "Max Temp. ($unit)"=$return_info.forecast.forecastday.day.("maxtemp_"+"$unit");
                              "Min Temp. ($unit)"=$return_info.forecast.forecastday.day.("mintemp_"+"$unit");
                                          }
                                    }
                   else {#array [2 or more] for day 2 and more (mutipal elements in condition.text)
                     [pscustomobject]@{
                        Location=("$location");
                        Date=(get-date).AddDays($i) | Get-Date -Format MMM-dd-yyyy;
                        "Weather"=$return_info.forecast.forecastday.day.condition.text[($i-1)];
                        "Max Temp. ($unit)"=$return_info.forecast.forecastday.day.("maxtemp_"+"$unit")[$i-1];
                        "Min Temp. ($unit)"=$return_info.forecast.forecastday.day.("mintemp_"+"$unit")[$i-1];
                                    }
                        }
                              }
            }      
      )
#Output/ display result
for ($j=0; $j -lt $days+1; $j++) {
     $data[$j]
      }
}
#End of function
