# secc nrpe checks Rollout
class secc_nrpe_checks(

  $manage_home_nrpe_bin_recurse = true,
  $manage_home_nrpe_bin_purge   = true,
  $manage_home_nrpe_bin_force   = true,

  $commands_in_general_cfg      = [],
  $manage_etc_nrped_recurse     = true,
  $manage_etc_nrped_purge       = true,

  $nrpe_module_repository       = undef,
) {

  $_commands_in_general_cfg = hiera_array("${module_name}::commands_in_general_cfg", $commands_in_general_cfg)

# Validate values p3/p4 compatible
  if versioncmp($clientversion, '4.0.0') < 0 {
    validate_array($_commands_in_general_cfg)
  } else {
    validate_legacy(Array, 'validate_array', $_commands_in_general_cfg)
  }

  require secc_nrpe

  contain secc_nrpe_checks::config
}
