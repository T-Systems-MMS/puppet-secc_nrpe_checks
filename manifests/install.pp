class secc_nrpe_checks::install {
  if $::secc_nrpe_checks::nagios_basic_nrpe_plugins {
    package { $::secc_nrpe_checks::nagios_basic_nrpe_plugins:
      ensure          => installed,
      install_options => [
        {
          '--enablerepo' => $::secc_nrpe::epelreponame
        }
      ],
    }
  }
}