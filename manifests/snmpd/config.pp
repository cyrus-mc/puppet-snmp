# == Class: snmp::snmpd::config
#
# This class manages the configuration of snmpd
#
# Requires: stdlib
#
class snmp::snmpd::config (
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

  # include package class so that we can depend on it
  include snmp::snmpd::package
  include snmp::snmpd::service

  # validate the input
  if ! is_array($agentaddress) and ! is_string($agentaddress) {
    fail('snmp::server::config::agentaddress must be supplied as a string or an array')
  }

  validate_string($sysname, location, $contact)

  # must be an array
  validate_array($com2sec, $views, $groups, $access)

  if ! is_ip_address($ro_network) {
    fail('snmp::server::config::ro_network must be a valid IP address')
  }

  if $rw_network != '' and ! is_ip_address($rw_network) {
    fail('snmp::server::config::rw_network must be a valid IP address')
  }

  concat {
    "${snmp::params::config_path}/snmpd.conf":
    ensure  => 'present',
    notify  => Service [ 'snmp-snmpd' ],
    require => Package[ $snmp::params::package_server ];
  }

  # combine template with local additions to create snmpd.conf
  concat::fragment {
    'snmpd_conf-template':
    target  => "${snmp::params::config_path}/snmpd.conf",
    content => template('snmp/snmpd.conf.erb'),
    order   => '01';

    'snmpd_conf-local':
    ensure  => "${snmp::params::config_path}/snmpd.conf.local",
    target  => "${snmp::params::config_path}/snmpd.conf",
    order   => '99',
  }

}
