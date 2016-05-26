# secc nrpe checks Rollout
class secc_nrpe_checks(
  $epelreponame                 = 'epel',

  $manage_home_nrpe_bin_recurse = true,
  $manage_home_nrpe_bin_purge   = true,
  $manage_home_nrpe_bin_force   = true,
  
  $commands_in_general_cfg = [ "command[SYSTEM_disk-inodes]=/home/nrpe/bin/check_disk -W 20% -K 10% -p /dev/shm" , "command[SYSTEM_disk-inodes]=/home/nrpe/bin/check_disk -W 20% -K 10% -p /dev/shm" ],

) {

  include secc_nrpe_checks::user
  
  class { 'secc_nrpe_checks::config':
    epelreponame                  => $epelreponame,
    
    manage_home_nrpe_bin_recurse  => $manage_home_nrpe_bin_recurse,
    manage_home_nrpe_bin_purge    => $manage_home_nrpe_bin_purge,
    manage_home_nrpe_bin_force    => $manage_home_nrpe_bin_force,
    
    commands_in_general_cfg       => $commands_in_general_cfg,
  }
}
