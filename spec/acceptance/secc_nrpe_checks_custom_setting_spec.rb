require 'spec_helper_acceptance'

describe 'Class secc_nrpe_checks' do

    basic_nagios_plugins = [
    	'nagios-plugins-dig',
    	'nagios-plugins-disk',
    	'nagios-plugins-dns',
    	'nagios-plugins-http',
    	'nagios-plugins-procs',
    	'nagios-plugins-smtp',
    	'nagios-plugins-ssh',
    	'nagios-plugins-tcp',
    ]

    let(:manifest) {
    <<-EOS
      class { 'secc_nrpe':
        nrpe_homedir => '/opt/monitoring',
      } ->
      class { 'secc_nrpe_checks':
        install_basic_nagios_plugins => false,
        nrpe_homedir                 => '/opt/monitoring',
      }
    EOS
    }

    it 'should run without errors' do
      expect(apply_manifest(manifest, :catch_failures => true).exit_code).to eq(2)
    end

    it 'should re-run without changes' do
      expect(apply_manifest(manifest, :catch_changes => true).exit_code).to be_zero
    end

    describe user('nrpe') do
      it { should exist }
      it { should have_home_directory '/opt/monitoring' }
      it { should have_login_shell '/sbin/nologin' }
    end

    describe file('/opt/monitoring') do
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

    nagios_basic_nrpe_plugins.each do |plugin|
      describe package(plugin) do
        it { should_not be_installed }
      end
    end
end
