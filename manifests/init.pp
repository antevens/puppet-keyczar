class python_keyczar(
  $keyczart_binary='/usr/bin/keyczart',
) {
  include stdlib
  package { 'python-pip': ensure => latest}
  package { 'python-keyczar': ensure => latest, provider => pip }
  file { $keyczart_binary:
    ensure => file,
    mode => 0777,
    source => "puppet:///modules/python_keyczar/keyczart",
    replace => false
  }
}
