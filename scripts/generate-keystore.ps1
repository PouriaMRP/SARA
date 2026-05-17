param(
    [string]$keystorePath = "release-keystore.jks",
    [string]$alias = "releasekey",
    [int]$validityDays = 3650
)

if (-Not (Get-Command keytool -ErrorAction SilentlyContinue)) {
    Write-Error "keytool not found in PATH. Install JDK or run this where keytool is available."
    exit 1
}

$password = Read-Host -AsSecureString "Enter keystore password"
$plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

keytool -genkeypair -v -keystore $keystorePath -alias $alias -keyalg RSA -keysize 2048 -validity $validityDays -storepass $plain -keypass $plain -dname "CN=Your Name, OU=OrgUnit, O=Organization, L=City, S=State, C=IR"

Write-Output "Keystore created at $keystorePath"

# Print base64 for GitHub secret
[Convert]::ToBase64String((Get-Content $keystorePath -Encoding Byte)) | Out-File -Encoding ASCII -FilePath ($keystorePath + ".base64.txt")
Write-Output "Base64 keystore written to $($keystorePath).base64.txt — copy its contents into GitHub secret 'KEYSTORE_BASE64'"
