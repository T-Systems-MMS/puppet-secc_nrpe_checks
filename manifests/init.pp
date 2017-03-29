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
  
  if empty($commands_in_general_cfg) {
    $_commands_in_general_cfg = hiera_array("${module_name}::commands_in_general_cfg", {})
  } else {
    $_commands_in_general_cfg = $commands_in_general_cfg
  }

  require secc_nrpe

  class { 'secc_nrpe_checks::config':

    manage_home_nrpe_bin_recurse => $manage_home_nrpe_bin_recurse,
    manage_home_nrpe_bin_purge   => $manage_home_nrpe_bin_purge,
    manage_home_nrpe_bin_force   => $manage_home_nrpe_bin_force,

    commands_in_general_cfg      => $_commands_in_general_cfg,
    manage_etc_nrped_recurse     => $manage_etc_nrped_recurse,
    manage_etc_nrped_purge       => $manage_etc_nrped_purge,
    nrpe_module_repository       => $nrpe_module_repository,

  }
}
