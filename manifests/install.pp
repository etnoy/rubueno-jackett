# == Class: jackett::install
#
class jackett::install (
  $additional_packages = $jackett::additional_packages,
  $user                = $jackett::user,
  $group               = $jackett::user,
  $base_path           = $jackett::base_path,
  $config_folder       = $jackett::config_folder,
  $app_folder          = $jackett::app_folder,
  $archive_name        = $jackett::archive_name,
  $archive_url         = $jackett::archive_url,
  $executable          = $jackett::executable,
) {

  $_additional_packages = $additional_packages ? {
    Array   => true,
    default => false,
  }

  if $_additional_packages {
    package { $additional_packages:
      ensure => installed,
    }
  }

  file { [ $base_path, $config_folder, $app_folder ]:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  $_archive_url = strip(generate('/bin/sh', '-c', "${archive_url}"))

  archive { $archive_name:
    path         => "/tmp/${archive_name}",
    source       => "${_archive_url}",
    extract      => true,
    extract_path => $base_path,
    creates      => "${base_path}/${executable}",
    cleanup      => true,
    require      => File[$base_path],
    user         => $user,
    group        => $group,
  } ->
  exec { 'move jackett files to correct folder':
    command => "mv ${base_path}/Jackett/* ${base_path}",
    creates => "${base_path}/${executable}",
  }
}
