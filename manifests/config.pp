class secc_nrpe_checks::config(
  
  $manage_home_nrpe_bin_recurse,
  $manage_home_nrpe_bin_purge,
  $manage_home_nrpe_bin_force,
  
  $commands_in_general_cfg,
  $manage_etc_nrped_recurse,
  $manage_etc_nrped_purge,

  $nrpe_module_repository,
) {
  
  file { '/home/nrpe/bin/':
    ensure  => directory,
    owner   => 'nrpe',
    group   => 'nrpe',
    mode    => '0750',
    recurse => $manage_home_nrpe_bin_recurse,
    purge   => $manage_home_nrpe_bin_purge,
    force   => $manage_home_nrpe_bin_force,
    source  => 'puppet:///modules/secc_nrpe_checks/home/nrpe/bin',
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
  }

  if $nrpe_module_repository {
    vcsrepo { '/home/nrpe/bin/':
      ensure   => latest,
      provider => git,
      source   => $nrpe_module_repository,
    }
  }
}
