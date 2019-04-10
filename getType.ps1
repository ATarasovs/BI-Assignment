foreach($line in Get-Content csuristems.txt) {
    $type = ""
    $type = $line.Split("{.}")[1]
    if ($type) {
        $content = "INSERT INTO splitfiles (type) VALUES ('" + $type + "')"
    } else { 
        $content = "INSERT INTO splitfiles (type) VALUES (" + "NULL" + ")"
    }
    Add-Content files.txt $content
}