class secc_nrpe_checks::config {

  $manage_home_nrpe_bin_recurse = $::secc_nrpe_checks::manage_home_nrpe_bin_recurse
  $manage_home_nrpe_bin_purge = $::secc_nrpe_checks::manage_home_nrpe_bin_purge
  $manage_home_nrpe_bin_force = $::secc_nrpe_checks::manage_home_nrpe_bin_force
  $commands_in_general_cfg = $::secc_nrpe_checks::commands_in_general_cfg
  $manage_etc_nrped_recurse = $::secc_nrpe_checks::manage_etc_nrped_recurse
  $manage_etc_nrped_purge = $::secc_nrpe_checks::manage_etc_nrped_purge
  $nrpe_module_repository = $::secc_nrpe_checks::nrpe_module_repository
  $custom_checks_module = $::secc_nrpe_checks::custom_checks_module

  if $nrpe_module_repository {
    vcsrepo { "${::secc_nrpe_checks::nrpe_homedir}/bin/":
      ensure   => latest,
      provider => git,
      source   => $nrpe_module_repository,
      notify   => File["${::secc_nrpe_checks::nrpe_homedir}/bin"],
    }

    file { "${::secc_nrpe_checks::nrpe_homedir}/bin/":
      ensure  => directory,
      owner   => 'nrpe',
      group   => 'nrpe',
      mode    => '0750',
      recurse => true,
    }
  }
  elsif $custom_checks_module {
    file { "${::secc_nrpe_checks::nrpe_homedir}/bin/":
      ensure  => directory,
      owner   => 'nrpe',
      group   => 'nrpe',
      mode    => '0750',
      recurse => $manage_home_nrpe_bin_recurse,
      purge   => $manage_home_nrpe_bin_purge,
      force   => $manage_home_nrpe_bin_force,
      source  => "puppet:///modules/${custom_checks_module}"
    }
  } else {
    file { "${::secc_nrpe_checks::nrpe_homedir}/bin/":
      ensure  => directory,
      owner   => 'nrpe',
      group   => 'nrpe',
      mode    => '0750',
      recurse => $manage_home_nrpe_bin_recurse,
      purge   => $manage_home_nrpe_bin_purge,
      force   => $manage_home_nrpe_bin_force,
    }
  }

  file { '/etc/nrpe.d/':
    ensure  => directory,
    recurse => $manage_etc_nrped_recurse,
    purge   => $manage_etc_nrped_purge,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/etc/nrpe.d/general.cfg':
    ensure  => present,
    content => template('secc_nrpe_checks/etc/nrpe.d/general.cfg.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/nrpe.d/'],
    notify  => Service['nrpe'],
  }
}
