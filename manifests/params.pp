class jackett::params {
  $manage_epel         = true
  $install_mono        = true
  $mono_baseurl        = 'http://download.mono-project.com/repo/centos/'
  $mono_gpgkey         = 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
  $mono_packages       = ['mono-core', 'mono-devel', 'mono-locale-extras']
  $additional_packages = ['curl', 'libcurl-devel']
  $user                = 'jackett'
  $base_path           = '/opt/Jackett'
  $config_folder       = "/home/${user}/.config"
  $app_folder          = "/home/${user}/.config/Jackett"
  $archive_name        = 'Jackett.Binaries.Mono.tar.gz'
  $archive_url         = '/usr/bin/curl -s https://api.github.com/repos/Jackett/Jackett/releases | grep "Jackett.Binaries.Mono.tar.gz" | grep browser_download_url | head -1 | cut -d \'"\' -f 4'
  $executable          = 'JackettConsole.exe'
  $service_enable      = true
  $service_name        = 'jackett'
}
