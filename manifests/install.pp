class python_keyczar::install(
  $keyczart_binary,
) {
  package { ['python-keyczar']:
    ensure => latest,
    provider => pip,
    require => Class['python_keyczar::install_pip'],
  }
  package { ['python-dev', 'python-crypto', 'python-pyasn1']:
    ensure => latest,
    before => Package['python-keyczar']
  }
  file { $keyczart_binary:
    ensure => file,
    mode => 0777,
    source => "puppet:///modules/python_keyczar/keyczart",
    replace => false,
    require => Package['python-keyczar', 'python-crypto', 'python-pyasn1'],
  }
}
