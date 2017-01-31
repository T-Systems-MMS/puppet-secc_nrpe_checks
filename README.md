# AMCS SecC - NRPE Checks Module

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [nrpe]](#setup)
    * [What [nrpe] affects](#what-[nrpe]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [nrpe]](#beginning-with-[nrpe])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Diese Modul ist das Schwestermodul zu SecC NRPE.

## Module Description

Das Modul kann Checks automatisiert ausrollen und managen. Commands können in die general.cfg eingetragen werden. Allerdings ist dieses Modul ohne SecC NRPE **nicht** lauffähig.

## Setup

### What [nrpe] affects

1. Files
    * '/home/nrpe/bin/checks_*'

1. Templates
	* '/etc/nrpe.d/general.cfg'

### Beginning with [nrpe]

* Für die Grundfunktionalität von NRPE Checks muss die Main Class inkludiert werden.

## Usage

* Für die Verwendung des Moduls secc_nrpe_checks ist die Nutzung von secc_nrpe **zwingend** erforderlich!
* Die Abhängigkeit zum Modul SecC NRPE ist mit require secc_nrpe in der init.pp verankert.

Es gibt zwei Verwendungsarten dieses Moduls:

* Kopieren des Moduls in das jeweilige Projekt-/Servicerepo.
  * Dies ist notwendig, wenn die zu nutzenden NRPE-Checks nicht in einem separaten GIT-Repository liegen.
  * Das Modul kann dann nicht über ein Puppetfile eingebunden werden.
* Nutzen des Moduls im Puppetfile
  * Hier können NRPE-Checks aus einem eigenen GIT-Repository eingebunden werden. Dazu müssen folgende Dinge konfiguriert werden:
    * die Variable `$nrpe_module_repository` muss auf die URL des entsprechenden Repositories gesetzt werden.
    * Die Variablen `manage_home_nrpe_bin_purge` und `manage_home_nrpe_bin_force` müssen auf `false` gesetzt werden.

Beispiel:

```
secc_nrpe_checks::nrpe_module_repository: https://$USERNAME:$PASSWORD@git.t-systems-mms.eu/scm/amcs700103/amcs_7001_03_nrpe_checks.git
secc_nrpe_checks::manage_home_nrpe_bin_purge: false
secc_nrpe_checks::manage_home_nrpe_bin_force: false
```


## Reference

1. Classes
    * secc_nrpe_checks
    * secc_nrpe_checks::config

## Limitations

* Modul wurde erfolgreich gegen CentOS6, CentOS7, RHEL6, RHEL7 getestet.

## Development

* Änderungen am Modul sollten auch im Serverspec amcs_secc_nrpe_checks_spec.rb nachgezogen werden.

## Release Notes/Contributors/Etc

* Initialrelease.
