# == Class examples::config
#
# This class is called from examples for service config.
#
class examples::config {
  unless $::xgateway == '' {
    case $::location {
      'ny4': {
        file { '/etc/sysconfig/static-routes':
          ensure  => 'present',
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template('routes/static-routes-ny4.erb'),
        } ~>
          service { 'routes':
            ensure => 'running',
          }
      }
      'ld4': {
        file { '/etc/sysconfig/static-routes':
          ensure  => 'present',
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template('routes/static-routes-ld4.erb'),
        } ~>
          service { 'routes':
            ensure => 'running',
          }
      }
      default: {
        notify { 'Unable to determine environment. Taking no action.': }
      }
    }
  }
}
