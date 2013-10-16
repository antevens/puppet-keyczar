class python_keyczar::install_pip {
  include stdlib
  ensure_packages(['python-pip'])
}
