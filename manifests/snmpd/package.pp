# == Class: snmp::snmpd::package
#
# This class manages the snmpd package installation
#
# Requires: stdlib
#
class snmp::snmpd::package (
  $ensure = $snmp::params::package_server_ensure
  ) inherits snmp::params {

  # validate parameters
  if !is_string($snmp::params::package_server) and !is_array($snmp::params::package_server) {
    fail('snmp::params::package_server must be a string or an array of packages to install')
  }

  # install the necessary package(s)
  package { $snmp::params::package_server:
    ensure => $ensure,
  }

}
