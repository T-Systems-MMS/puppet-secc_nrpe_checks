class secc_nrpe_checks::install {
  if $secc_nrpe_checks::install_basic_nagios_plugins {
    package { $::secc_nrpe_checks::basic_nagios_plugins:
      ensure          => installed,
      install_options => [
        {
          '--enablerepo' => '*epel*'
        }
      ],
    }
  }
}