pushd $PSScriptRoot
$outDir = "export"
mkdir $outDir | Out-Null
Get-ChildItem *.scad -Exclude "ittybox.scad" | ForEach-Object { openscad -o "$outDir/$($_.BaseName).stl" $_.Name }
popd