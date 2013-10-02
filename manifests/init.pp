class keyczar(
  $keyczart_binary='/usr/bin/keyczart',
) {

  file { $keyczart_binary:
    ensure => file,
    mode => 0777,
    source => "puppet:///modules/keyczar/keyczart",
    replace => false
  }
}
