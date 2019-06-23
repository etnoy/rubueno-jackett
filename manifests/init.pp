# == Class: jackett
#
class jackett (
  $additional_packages = $jackett::params::additional_packages,
  $user                = $jackett::params::user,
  $group               = $jackett::params::user,
  $base_path           = $jackett::params::base_path,
  $install_path        = $jackett::params::install_path,
  $config_folder       = $jackett::params::config_folder,
  $app_folder          = $jackett::params::app_folder,
  $archive_name        = $jackett::params::archive_name,
  $archive_url         = $jackett::params::archive_url,
  $executable          = $jackett::params::executable,
  $service_enable      = $jackett::params::service_enable,
  $service_name        = $jackett::params::service_name,
) inherits jackett::params {

  contain jackett::install
  contain jackett::service

  Class['jackett::install'] ~>
  Class['jackett::service']
}
