# secc nrpe checks Rollout
class secc_nrpe_checks(
  $nrpe_homedir                 = '/home/nrpe',
  $manage_home_nrpe_bin_recurse = true,
  $manage_home_nrpe_bin_purge   = true,
  $manage_home_nrpe_bin_force   = true,

  $commands_in_general_cfg      = [],
  $manage_etc_nrped_recurse     = true,
  $manage_etc_nrped_purge       = true,

  $nrpe_module_repository       = undef,
  $custom_checks_module         = undef,

  $install_basic_nagios_plugins = true,
  $basic_nagios_plugins         = [
    'nagios-plugins-dig',
    'nagios-plugins-disk',
    'nagios-plugins-dns',
    'nagios-plugins-http',
    'nagios-plugins-procs',
    'nagios-plugins-smtp',
    'nagios-plugins-ssh',
    'nagios-plugins-tcp',
  ]
) {

  $_commands_in_general_cfg = hiera_array("${module_name}::commands_in_general_cfg", $commands_in_general_cfg)

# Validate values p3/p4 compatible
  if versioncmp($clientversion, '4.0.0') < 0 {
    validate_array($_commands_in_general_cfg)
  } else {
    validate_legacy(Array, 'validate_array', $_commands_in_general_cfg)
  }

  include secc_nrpe

  Class['secc_nrpe_checks::install'] -> Class['secc_nrpe_checks::config']
  contain secc_nrpe_checks::install
  contain secc_nrpe_checks::config

}
