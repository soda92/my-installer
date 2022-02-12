Push-Location "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build"
cmd /c "vcvars64.bat & set" | ForEach-Object {
        if ($_ -match "=") {
        $v = $_.split("=", 2); Set-Item -Force -Path "ENV:\$($v[0])" -Value "$($v[1])"
        }
    }
Pop-Location
Write-Host "Visual Studio 2022 Command Prompt variables set." -ForegroundColor Green

if (Test-Path -Path build){
    Remove-Item -Recurse build
}

cmake -B build -G "Ninja" `
    -DCMAKE_TOOLCHAIN_FILE="D:\src\vcpkg\scripts\buildsystems\vcpkg.cmake" `
    -DCMAKE_BUILD_TYPE="Release"

cmake --build build
makensis .\vcredist-and-msu.nsi
