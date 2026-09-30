param([string]$RootDir)
if (-not $RootDir) { Write-Error "Usage: .\scan_corruption.ps1 -RootDir 'C:\path\to\project'"; exit 1 }

$extensions = @("*.kt","*.java","*.dart","*.py","*.ts","*.tsx","*.js","*.jsx","*.swift",
                "*.go","*.rs","*.cpp","*.c","*.h","*.xml","*.json","*.yaml","*.yml",
                "*.toml","*.gradle","*.kts","*.md","*.txt","*.html","*.css","*.sql",
                "*.pro","*.properties","*.cfg","*.ini","*.env","*.sh","*.bat","*.ps1")

$allFiles = @()
foreach ($ext in $extensions) {
    $allFiles += Get-ChildItem -Recurse -File $RootDir -Filter $ext -ErrorAction SilentlyContinue |
                 Where-Object { $_.FullName -notmatch '[\\/](build|\.gradle|node_modules|\.dart_tool|__pycache__|\.next|dist|\.agents)[\\/]' }
}

$corrupted = @()
$ok = @()
foreach ($f in $allFiles) {
    $content = Get-Content -Raw -Path $f.FullName -ErrorAction SilentlyContinue
    if ($null -eq $content -or $content -match '^\x00+$') {
        $corrupted += $f
        Write-Output "CORRUPTED: $($f.FullName) ($($f.Length) bytes)"
    } else {
        $ok += $f
    }
}

Write-Output "`n=== SCAN SUMMARY ==="
Write-Output "Total scanned: $($allFiles.Count)"
Write-Output "Corrupted: $($corrupted.Count)"
Write-Output "Intact: $($ok.Count)"
