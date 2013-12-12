define python_keyczar::key (
  $ensure=present,
  $key_desc='Keyczart Key',
  $key_size=256,
  $version=1,
  $owner='root',
  $group='root',
  $purpose='crypt',
  $symlinks=[],
  $replace_symlinks=false,
) {
  # Create a keyczar pair
  if $ensure == present {
    # Generate names for files/directories
    $key_dir=$name
    $key_file="${key_dir}/${version}"
    $meta_file="${key_dir}/meta"

    # Make sure the key directory exists
    ensure_resource(
      'file', "${key_dir}", {
        'ensure' => 'directory',
        'owner' => "${owner}",
        'group' => "${group}",
        'mode' => 2770,
      }
    )

    # If any symlinks were specified we create them
    # Special handling since symlinks can be string or array
    if count(flatten([$symlinks])) > 0 {
      # Specify symlinks to create/replace
      file { $symlinks:
        ensure => "link",
        target => "${key_dir}",
        replace => $replace_symlinks, # Overwrite existing symlink or not
        force => false,
        backup => true, # Back up existing file to same directory ${file_name}.puppet-bak
      }
    }

    exec { 'keyczar_create_key':
      creates => "${meta_file}",
      command => "${python_keyczar::keyczart_binary} create --location='${key_dir}' --purpose='${purpose}' --name='${key_desc}'",
      require => File[$key_dir],
    }

    exec { 'keyczar_add_key':
      creates => "${key_file}",
      command => "${python_keyczar::keyczart_binary} addkey --location='${key_dir}' --size=${key_size}",
      require => File[$meta_file],
    }

    exec { 'keyczar_promote_key':
      # Only run when key has been generated for now assume only 1 version
      # Can extend to handle revoke and multiple verions, etc
      command => "${python_keyczar::keyczart_binary} promote --location='${key_dir}' --version=${version}",
      subscribe  => File[$key_file],
      refreshonly => true,
    }

    file { $meta_file:
      ensure => file,
      owner => $owner,
      group => $group,
      mode => 0640,
      require => Exec['keyczar_create_key'],
    }

    file { $key_file:
      ensure => file,
      owner => $owner,
      group => $group,
      mode => 0640,
      require => Exec['keyczar_add_key'],
    }
  } elsif $ensure == absent {
    # Remove all traces in case of absent
    file { $key_dir:
      ensure  => absent,
      force   => true,
      recurse => true,
      purge   => true,
    }
  }
}
