# secc nrpe checks Rollout
class secc_nrpe_checks(
#  $epelreponame                  = 'epel',

  $manage_home_nrpe_bin_recurse   = true,
  $manage_home_nrpe_bin_purge     = true,
  $manage_home_nrpe_bin_force     = true,
  
  $commands_in_general_cfg        = [ undef ],
  $manage_etc_nrped_recurse       = true,
  $manage_etc_nrped_purge         = true,

) {
  
  require secc_nrpe

#  include secc_nrpe_checks::user
  
  class { 'secc_nrpe_checks::config':
#    epelreponame                  => $epelreponame,
    
    manage_home_nrpe_bin_recurse  => $manage_home_nrpe_bin_recurse,
    manage_home_nrpe_bin_purge    => $manage_home_nrpe_bin_purge,
    manage_home_nrpe_bin_force    => $manage_home_nrpe_bin_force,
    
    commands_in_general_cfg       => $commands_in_general_cfg,
    manage_etc_nrped_recurse      => $manage_etc_nrped_recurse,
    manage_etc_nrped_purge        => $manage_etc_nrped_purge,
  }
}
