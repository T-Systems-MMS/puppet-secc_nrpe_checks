class secc_nrpe_checks::config(
  $epelreponame,
  
  $manage_home_nrpe_bin_recurse,
  $manage_home_nrpe_bin_purge,
  $manage_home_nrpe_bin_force,
  
  $commands_in_general_cfg,
) {
  
  package { 'nrpe':
    ensure => installed,
    alias  => 'nrpe',
    install_options => ['--enablerepo', "${epelreponame}"],
  }
  
  file { '/home/nrpe/bin/':
    ensure  => directory,
    owner   => 'nrpe',
    group   => 'nrpe',
    mode    => '0750',
    recurse => $manage_home_nrpe_bin_recurse,
    purge   => $manage_home_nrpe_bin_purge,
    force   => $manage_home_nrpe_bin_force,
    source  => 'puppet:///modules/secc_nrpe_checks/home/nrpe/bin',
    require => File['/home/nrpe/'],
  }
  
  file { '/etc/nrpe.d/':
    ensure  => directory,
    recurse => true,
    purge   => true,
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
#   source  => 'puppet:///modules/secc_nrpe_checks/etc/nrpe.d/general.cfg',
    require => File['/etc/nrpe.d/'],
  }
  
  
}