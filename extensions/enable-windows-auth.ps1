Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/windowsAuthentication" -Name Enabled -Value True -PSPath "IIS:\Sites\$SiteName\$AppName"

Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/anonymousAuthentication" -Name Enabled -Value False -PSPath "IIS:\Sites\$SiteName\$AppName"

IISRESET
