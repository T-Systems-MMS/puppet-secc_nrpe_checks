class secc_nrpe_checks::user {

  user { 'nrpe':
    ensure     => 'present',
    gid        => 'nrpe',
    comment    => 'NRPE user for the NRPE service',
    shell      => '/sbin/nologin',
    home       => '/home/nrpe',
    managehome => true,
  }

  group { 'nrpe':
    ensure  => 'present',
    name    => 'nrpe',
    require => User['nrpe'],
  }
 }