# == Class: jackett::service
#
class jackett::service (
  $service_enable = $jackett::service_enable,
  $service_name   = $jackett::service_name,
  $user           = $jackett::user,
  $group          = $jackett::user,
  $base_path      = $jackett::base_path,
  $executable     = $jackett::executable,
) {
  if $service_enable {
    include ::systemd

    systemd::unit_file { "${service_name}.service":
      content => template('jackett/systemd.erb'),
      enable  => true,
      active  => true,
    }
  }
}
