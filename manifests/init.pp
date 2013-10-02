class python_keyczar(
  $keyczart_binary='/usr/bin/keyczart',
) {
  package { 'python-keyczar': ensure => latest }
  file { $keyczart_binary:
    ensure => file,
    mode => 0777,
    source => "puppet:///modules/keyczar/keyczart",
    replace => false
  }
}
