# Class: snmp::snmpd
#
# This class manages the snmp daemon (package, server and config)
#
# Requires: stdlib
#
class snmp::snmpd (
  $service_enable = $snmp::params::service_enable,
  $service_ensure = $snmp::params::service_ensure,
  $package_ensure = $snmp::params::package_server_ensure,
  $agentaddress,
  $ro_community,
  $ro_network,
  $rw_community,
  $rw_network,
  $com2sec,
  $groups,
  $views,
  $access,
  $sysname,
  $location,
  $contact
  ) inherits snmp::params {

  # call sub classes
  class {

    'snmp::snmpd::package':
    ensure   => $package_ensure;
  
    'snmp::snmpd::service':
    ensure   => $service_ensure,
    enable   => $service_enable;

    'snmp::snmpd::config':
    agentaddress => $agentaddress,
    ro_community => $ro_community,
    ro_network   => $ro_network,
    rw_community => $rw_community,
    rw_network   => $rw_network,
    com2sec      => $com2sec,
    groups       => $groups,
    views        => $views,
    access       => $access,
    sysname      => $sysname,
    location     => $location,
    contact      => $contact,

  }
}
