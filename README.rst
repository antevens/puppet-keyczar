keyczar for puppet
=================
This installs and configures `Keyczar`_.

This is a `puppet`_ module that uses Python's `pip`_.  Puppet has a
built-in pip provider, but it's implementation leaves out a few pieces:

* No ability to install from requirements file.
* No ability to add extra arguments
* No support for using mirrors or specifying alternate indexes.

This module uses the puppet-python module to get around these limitations.


Usage
-----
Make sure this module is available by adding this repository's contents
in a directory called ``keyczar`` inside your Puppet's ``moduledir``.
It also requires the `puppet-python`_ module and `puppet-stdlib` as well.


Creating Keyczar keys
""""""""""""""""""""""

First you need to initialize the keyczar class::
    class { "keycar": }

You create a new key with the ``keyczar::key`` resource like this::
    # Set up Keyczar key(s)
    python_keyczar::key { $sde_keyczar_dir:
      key_desc => "Key for ${fqdn}",
      owner => 'root',
      group => 'root'
    }
}

Configuration
-------------
TBD

.. _distribute: http://packages.python.org/distribute/
.. _pip: http://www.pip-installer.org/
.. _puppet: http://puppetlabs.com/
.. _puppetlabs-rabbitmq: https://github.com/puppetlabs/puppetlabs-rabbitmq/
.. _this version: https://github.com/jalli/puppet-keyczar
