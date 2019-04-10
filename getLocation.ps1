$usedIPs = @()
[System.Collections.ArrayList]$usedIPs = $usedIPs

foreach($line in Get-Content IPs.txt) {
    if($line -match $regex){
        if ($usedIPs -NotContains $line) { 
            $usedIPs.Add($line)
            $country = ""
            $region = ""
            $city = ""
            $postal = ""
            $country =  curl ipinfo.io/$line/country
            $city =  curl ipinfo.io/$line/city
            $postal =  curl ipinfo.io/$line/postal

            $query = 'INSERT INTO dim_user (ip,country,region,city,postal) VALUES ('
            $query += "'" + $line + "', "
            if ($country.Content) {
                $country2 = $country.Content -replace "`t|`n|`r",""
                $countryNames = Get-Content names.json | ConvertFrom-Json
                $countryName = $countryNames | Select -ExpandProperty $country2

                $query += "'" + $countryName + "', "
            } else {
                $query += "NULL" + ', ' 
            }

            if ($city.Content) {
                $city2 = $city.Content -replace "`t|`n|`r",""
                $query += "'" + $city2 + "', "
            } else {
               $query += "NULL" + ', '  
            }

            if ($postal.Content) {
                $postal2 = $postal.Content -replace "`t|`n|`r",""
                $query += "'" + $postal2 + "')"
            } else {
               $query += "NULL" + ')'    
            }

            Add-Content insert_locations_queries.txt $query
        }
    }
}