class jackett::params {

  $additional_packages = ['curl',
    'Ubuntu'  => 'libcurl4-openssl-dev',
    'Debian'  => 'libcurl4-openssl-dev',
    'CentOS'  => 'libcurl-devel',
    'RHEL'    => 'libcurl-devel',
    'Fedora'  => 'libcurl-devel',
    default => 'libcurl_dev',
  ]
  $user                = 'jackett'
  $base_path           = '/opt/Jackett'
  $config_folder       = "/home/${user}/.config"
  $app_folder          = "/home/${user}/.config/Jackett"
  $archive_name        = 'Jackett.Binaries.LinuxAMDx64.tar.gz'
  $archive_url         = '/usr/bin/curl -s https://api.github.com/repos/Jackett/Jackett/releases | grep "Jackett.Binaries.LinuxAMDx64.tar.gz" | grep browser_download_url | head -1 | cut -d \'"\' -f 4'
  $executable          = 'jackett'
  $service_enable      = true
  $service_name        = 'jackett'
}
