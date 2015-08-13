# Class: snmp::params
#
# This class provides default parameters for the snmp module
#
# Requires: stdlib
#
class snmp::params {

  # non-OS specific default parameters
  $package_server_ensure      = hiera('snmp::server::package_ensure', 'present')
  $service_ensure             = hiera('snmp::server::service_ensure', 'running')
  $service_enable             = hiera('snmp::server::service_enable', true)

  case $::osfamily {
    # RedHat configuration
    'RedHat': {
      $package_server         = hiera('snmp::server::package', [ 'net-snmp', 'net-snmp-utils', 'net-snmp-perl' ])
      
      $service_name           = hiera('snmp::server::service_name', 'snmpd')
      $service_hasrestart     = hiera('snmp::server::service_hasrestart', true)

      $config_path            = hiera('snmp::config_path', '/etc/snmp')
      $snmpd_options          = hiera('snmp::snmpd_options', '/etc/sysconfig/snmpd')
    }

    default: {
      fail("Class['snmp']: Unsupported osfamily: ${::osfamily}")
    }
  }

}
