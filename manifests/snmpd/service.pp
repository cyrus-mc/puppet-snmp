# == Class: snmp::snmpd::service
#
# Thsi class manages the snmpd service
#
# Requires: stdlib
#
class snmp::snmpd::service (
  $ensure = $snmp::params::service_ensure,
  $enable = $snmp::params::service_enable
  ) inherits snmp::params {

  # include package class so that we can depend on it
  include snmp::snmpd::package

  # manage the snmpd service
  service { 'snmp-snmpd':
    ensure     => $ensure,
    name       => $snmp::params::service_name,
    enable     => $enable,
    hasrestart => $snmp::params::service_hasrestart,
    require    => Package[ $snmp::params::package_server ];
  }

}
