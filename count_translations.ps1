$files = @("translations/en/LC_MESSAGES/messages.po", "translations/et/LC_MESSAGES/messages.po")
foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "File: $file"
        $content = Get-Content $file -Raw
        $entries = $content -split "(?m)^\s*`r?`n"
        
        $emptyEntries = $entries | Where-Object {
            $_ -match 'msgid\s+".+"' -and $_ -match 'msgstr\s+""\s*$' -and $_ -notmatch 'msgid\s+""'
        }
        
        Write-Host "Count: $($emptyEntries.Count)"
        $emptyEntries | Select-Object -First 20 | ForEach-Object {
            if ($_ -match 'msgid\s+"(.*)"') {
                Write-Host $Matches[1]
            }
        }
    } else {
        Write-Host "File not found: $file"
    }
}
