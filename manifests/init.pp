class keyczar(
  $key_dir='/etc/keyczar',
  $keyczart_binary='/usr/bin/keyczart',
  $key_desc='Keyczart Key',
  $key_size=256
) {
  $key_file="${key_dir}/${version}"
  $meta_file="${key_dir}"

  # Make sure the key directory exists
  ensure_resource(
    'file', "${key_dir}", {
      'ensure' => 'directory',
      'owner' => "${owner}",
      'group' => "${group}",
      'mode' => 2770,
    }
  ) -> # Do this brefore anything else, next create the key

  exec { 'keyczar_create_key':
    creates => "${meta_file}",
    command => "${keyczart_binary} create --location='${key_dir}' --purpose=crypt --name='${key_desc}'",
  }

  exec { 'keyczar_add_key':
    creates => "${key_file}",
    command => "${keyczart_binary} addkey --location='${key_dir}' --size=${key_size}",
    require => Exec['keyczar_create_key'],
  }

  exec { 'keyczar_promote_key':
    # Only run when key has been generated for now assume only 1 version
    # Can extend to handle revoke and multiple verions, etc
    command => "${keyczart_binary} promote --location='${key_dir}' --version=1",
    subscribe  => File[ $key_file ],
    refreshonly => true,
  }

  file { $meta_file:
    ensure => file,
    owner => $owner,
    group => $group,
    mode => 0640,
  }

  file { $key_file:
    ensure => file,
    owner => $owner,
    group => $group,
    mode => 0640,
    require => [ Exec['keyczar_add_key'], File["${meta_file}"]],
  }
}
