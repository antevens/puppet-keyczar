class python_keyczar(
  $keyczart_binary='/usr/bin/keyczart',
) {
  class { python_keyczar::install_pip: } 
  class { python_keyczar::install: keyczart_binary => $keyczart_binary }
  Class['python_keyczar::install_pip'] -> Class['python_keyczar::install'] 
}
