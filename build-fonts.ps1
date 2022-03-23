Param (
    $CommitHash
)
New-Item -ItemType "folder" -Name "Iosevka"
Copy-Item "private-build-plans.toml" -Destination "Iosevka/private-build-plans.toml"
Set-Location -Path "Iosevka"
git init
git remote add origin https://github.com/be5invis/iosevka
git fetch --depth 1 origin $CommitHash
git checkout FETCH_HEAD
try {if(Get-Command npm){Write-Information "npm exists"}}
catch {throw "npm not found"}
npm install ttfautohint
$items = @('iosevka-rs', 'iosevka-rs-slab', 'iosevka-rs-mono', 'iosevka-rs-mono-slab', 'iosevka-rs-terminal', 'iosevka-rs-terminal-slab')
foreach ($str in $items)
{
    npm run build -- contents::$str
    Copy-Item -Path "dist/$str" -Destination "../$str" -Recurse
}
Set-Location -Path ".."
Remove-Item -Recurse -Path "Iosevka"