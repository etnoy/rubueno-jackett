# == Class: jackett::install
#
class jackett::install (
  $manage_epel         = $jackett::manage_epel,
  $install_mono        = $jackett::install_mono,
  $mono_baseurl        = $jackett::mono_baseurl,
  $mono_gpgkey         = $jackett::mono_gpgkey,
  $mono_packages       = $jackett::mono_packages,
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

  if $manage_epel {
    package { 'epel-release':
      ensure => 'installed',
    }
  }

  if $install_mono {
    yumrepo { 'mono':
      ensure   => present,
      baseurl  => $mono_baseurl,
      gpgkey   => $mono_gpgkey,
      gpgcheck => true,
    } ->

    package { $mono_packages:
      ensure => installed,
    }
  }

  $_additional_packages = $additional_packages ? {
    Array   => true,
    default => false,
  }

  if $_additional_packages {
    package { $additional_packages:
      ensure => installed,
    }
  }

  group { $group:
    ensure => present,
  }

  user { $user:
    ensure     => present,
    shell      => '/sbin/nologin',
    groups     => $group,
    managehome => true,
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
    command => "/usr/bin/mv ${base_path}/Jackett/* ${base_path}",
    creates => "${base_path}/${executable}",
  }
}
