require 'spec_helper'

	nagios_basic_nrpe_plugins = [
		'nagios-plugins-dig',
		'nagios-plugins-disk',
		'nagios-plugins-dns',
		'nagios-plugins-http',
		'nagios-plugins-procs',
		'nagios-plugins-smtp',
		'nagios-plugins-ssh',
		'nagios-plugins-tcp',
	]

	describe user('nrpe') do
		it { should exist }
  		it { should have_home_directory '/home/nrpe' }
  		it { should have_login_shell '/sbin/nologin' }
	end

	describe file('/home/nrpe/') do
		it { should exist }
		it { should be_directory }
		it { should be_mode 755 }
		it { should be_owned_by 'nrpe' }
		it { should be_grouped_into 'nrpe'}
	end

	describe file('/home/nrpe/bin/') do
		it { should exist }
		it { should be_directory }
		it { should be_mode 750 }
		it { should be_owned_by 'nrpe' }
		it { should be_grouped_into 'nrpe'}
	end

	describe file('/etc/nrpe.d/') do
		it { should exist }
		it { should be_directory }
		it { should be_mode 755 }
		it { should be_owned_by 'root' }
		it { should be_grouped_into 'root'}
	end

	describe file('/etc/nrpe.d/general.cfg') do
		it { should exist }
		it { should be_mode 644 }
		it { should be_owned_by 'root' }
		it { should be_grouped_into 'root'}
	end

	describe package(nagios_basic_nrpe_plugins) do
	  it { should be_installed }
	end
