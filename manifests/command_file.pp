define secc_nrpe_checks::command_file (
  $commands = {},
  ) {

  if versioncmp($clientversion, '4.0.0') < 0 {
    validate_hash($commands)
  } else {
    validate_legacy(Hash, 'validate_hash', $commands)
  }

  include secc_nrpe_checks

  file { "/etc/nrpe.d/${title}.cfg":
    ensure  => file,
    content => template('secc_nrpe_checks/etc/nrpe.d/custom.cfg.erb'),
    group   => 'nrpe',
    mode    => '0640',
    owner   => 'nrpe',
    notify  => Service['nrpe'],
  }

}
