require 'spec_helper'
	
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