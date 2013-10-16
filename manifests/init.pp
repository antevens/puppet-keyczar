class python_keyczar(
  $keyczart_binary='/usr/bin/keyczart',
) {
  include python_keyczar::install_pip
  package { 'python-keyczar':
    ensure => latest,
    provider => pip,
    require => Class['python_keyczar::install_pip'],
  }
  file { $keyczart_binary:
    ensure => file,
    mode => 0777,
    source => "puppet:///modules/python_keyczar/keyczart",
    replace => false,
    require => Package['python-keyczar'],
  }
}
