# == Define: snmp::config_fragment
#
# == Parameters
#
#       [namevar]
#               The name of the resources. 
#
#	[type]
#		string, the type of plugin. Valid values are application, 
#		agent, registration
#
#	[ensure]
#		boolean, whether to ensure plugin is present or not
#
#	[ddl]
#		boolean, does a DDL accompany this plugin
#
#	[application]
#		boolean, does an application accompany this plugin
#
#	[plugin_base]
#		string, directory where plugins get installed
#
# == Examples
#
#
# == Authors
#       Author Name <matthew.ceroni@monitise.com>
#
# [Remember: no empty lines between comments and class definition]
define snmp::config_fragment ( $ensure = present ) {

  include ::snmp::params

    concat::fragment { "snmpd_config-${name}":
      ensure => $ensure,
      target => $snmp::params::snmpd_config,
      order  => '10',
      source => "puppet:///modules/snmp/snmpd_config-${name}",
    }

}
