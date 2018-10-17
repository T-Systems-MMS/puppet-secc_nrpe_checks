# AMCS SecC - NRPE Checks Module

[![Build Status](https://travis-ci.org/T-Systems-MMS/puppet-secc_nrpe_checks.svg?branch=master)](https://travis-ci.org/T-Systems-MMS/puppet-secc_nrpe_checks)


1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [nrpe]](#setup)
  * [What [nrpe] affects](#what-[nrpe]-affects)
  * [Beginning with [nrpe]](#beginning-with-[nrpe])
4. [Usage - Configuration options and additional functionality](#usage)
  * [Configuring [nrpe] /etc/nrpe.d](#Configuring-[nrpe]-/etc/nrpe.d)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module is a companion module for `secc_nrpe`

## Module Description

This module is used to manage checks.
Commands will be inserted into `general.cfg`.
This module **can not** run without `secc_nrpe`.

## Setup

### What [nrpe] affects

* Files
  * `/home/nrpe/bin/checks_*`

* Templates
  * `/etc/nrpe.d/general.cfg`

### Beginning with [nrpe]

* this module only handles NRPE checks, for NRPE configuration you need to incluce the base class `secc_nrpe`

## Usage

* This module has a hard dependency to `secc_nrpe`, you **can not** use this without it

There are two use cases for this module:

* copy this module into your repository
  * this is necessary if your checks are not in a separate git repository
  * you place your checks inside this puppet module
  * do not use Puppetfile to manage this module 
* use this module via Puppetfile inclusion
  * NRPE checks need to be installed from a separate git repository
  * this is controlled with the following variables:
    * `nrpe_module_repository` points to the correct git repository URL
    * `manage_home_nrpe_bin_purge` and `manage_home_nrpe_bin_force` set to `false`

Example:

```
secc_nrpe_checks::nrpe_module_repository: https://$USERNAME:$PASSWORD@yourgitserver.example.com/scm/yourproject/your_nrpe_checks.git
secc_nrpe_checks::manage_home_nrpe_bin_purge: false
secc_nrpe_checks::manage_home_nrpe_bin_force: false
```

### Configuring [nrpe] /etc/nrpe.d

Via the define `secc_nrpe_checks::command_file` it is possible to include external NRPE commands in the directory `/etc/nrpe.d` 

An example call might look like this:

```
secc_nrpe_checks::command_file { 'this_is_a_test':
  commands => {
    'NRPE_first_command' => {
      command => '/bin/true',
    }
  }
}
```

The result is a file `/etc/nrpe.d/this_is_a_test.cfg` with the content:

```
### MANAGED BY PUPPET ['secc_nrpe_checks']  ###

command[NRPE_first_command]=/bin/true
```
## Reference

1. Classes
    * `secc_nrpe_checks`
    * `secc_nrpe_checks::config`
1. Defines
    * `secc_nrpe_checks::command_file`

## Limitations

* This module was tested with CentOS6 and CentOS7

## Development

* Please document changes withing the module using git commits
* Execution of tests: `bundler install`, `bundler exec rake`
