# == Class: snmp
#
# Thsi is the main snmp class
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'snmp':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Matthew Ceroni <matthew.ceroni@8x8.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class snmp (

  $agentaddress    = [ 'udp:127.0.0.1:161', 'udp6:[::1]:161' ],
  $ro_community    = '',
  $ro_network      = '',
  $rw_community    = '',
  $rw_network      = '',
  $com2sec         = [],
  $groups          = [],
  $views           = [],
  $access          = [],
  $sysname         = $::fqdn,
  $location        = '',
  $contact         = '',
  $service_manage  = true,
  $service_enable  = true,
  $service_ensure  = 'running',
  $package_manage  = true,
  $config_manage   = true,
  $snmpd_config    = undef,
  

) inherits snmp::params {

  # validate inputs
  validate_bool($package_manage, $service_manage, $config_manage)

  anchor { 'snmp::begin': } ->
  class {
    '::snmp::install':
    manage => $package_manage,
  } ->
  class {
    '::snmp::config':
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
    config       => $snmpd_config,
    manage       => $config_manage,
  } ->
  class {
    '::snmp::service':
    service_enable => $service_enable,
    service_ensure => $service_ensure,
    manage         => $service_manage,
  } ->
  anchor { 'snmp::end': }

}
