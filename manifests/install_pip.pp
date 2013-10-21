class python_keyczar::install_pip {
  # Make sure Pip is installed without conflicting with other modules
  # Would use stdlib ensure_package but it does not work due to PIP being a 
  # provider (package provider)
  case $::osfamily {
    'redhat': {
      exec { 'yum -y install python-pip':
        alias => 'pip',
        path => '/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin:/bin',
        unless => 'which pip',
      }
    }
    'debian': {
      exec { 'apt-get -y install python-pip':
        alias => 'pip',
        path => '/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin:/bin',
        unless => 'which pip',
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
