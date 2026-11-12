param([string]$Password)

if (-not $Password) {
    $secure = Read-Host "Password de RWBLAB_TEST" -AsSecureString
    $Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure))
}

if ([string]::IsNullOrWhiteSpace($Password)) {
    Write-Host "Error: La contrasena no puede estar vacia." -ForegroundColor Red
    exit 1
}

$env:AUTH_PASSWORD = $Password
.\mvnw.cmd test