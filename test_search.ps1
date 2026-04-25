$file = "translations/et/LC_MESSAGES/messages.po"
$content = Get-Content $file -Raw
$matches = [regex]::Matches($content, '(?m)msgid\s+"(?<msgid>.+)"\s*[\r\n]+msgstr\s+""\s*(?:[\r\n]|$)')
Write-Host "Count: $($matches.Count)"
foreach ($m in $matches | Select-Object -First 20) {
    Write-Host "- $($m.Groups['msgid'].Value)"
}
