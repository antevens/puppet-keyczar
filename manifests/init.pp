class python_keyczar(
  $keyczart_binary='/usr/bin/keyczart',
) {
  include stdlib
  ensure_packages(['python-pip'])
  package { 'python-keyczar': 
    ensure => latest, 
    provider => pip,
    require => Package['python-pip'],
  }
  file { $keyczart_binary:
    ensure => file,
    mode => 0777,
    source => "puppet:///modules/python_keyczar/keyczart",
    replace => false
  }
}
