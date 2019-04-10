$content = ""
foreach($line in Get-Content useragents.txt) {
    $browser = ""
    $os = ""
    $browser = $line.Split("{/}")[0]
    $os = $line.split("{(})")[1]
    $os = $os.split("{;}")[0]
    if ($browser) {
        if ($os) {
            $content += "INSERT INTO useragents (browser, os) VALUES ('" + $browser + "', '" + $os + "')`n"
        } else {
            $content += "INSERT INTO useragents (browser, os) VALUES ('" + $browser + "', " + "NULL" + ")`n"
        }
    } else { 
        $content += "INSERT INTO useragents (browser, os) VALUES (" + "NULL, NULL" + ")`n"
    }
}
Add-Content osbrowsers.txt $content