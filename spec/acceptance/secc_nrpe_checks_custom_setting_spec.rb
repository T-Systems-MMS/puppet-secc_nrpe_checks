require 'spec_helper_acceptance'

describe 'Class secc_nrpe_checks custom settings' do
  after :all do
    run_shell('service nrpe stop', expect_failures: true)
  end

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

  manifest = <<-EOS
    class { 'secc_nrpe':
      nrpe_homedir => '/opt/monitoring',
    }
    class { 'secc_nrpe_checks':
      install_basic_nagios_plugins => false,
      nrpe_homedir                 => '/opt/monitoring',
    }
  EOS

  it 'runs without errors' do
    idempotent_apply(manifest)
  end

  describe user('nrpe') do
    it { is_expected.to exist }
    it { is_expected.to have_home_directory '/opt/monitoring' }
    it { is_expected.to have_login_shell '/sbin/nologin' }
  end

  describe file('/opt/monitoring') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'nrpe' }
    it { is_expected.to be_grouped_into 'nrpe' }
  end

  describe file('/opt/monitoring/bin/') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 750 }
    it { is_expected.to be_owned_by 'nrpe' }
    it { is_expected.to be_grouped_into 'nrpe' }
  end

  describe file('/etc/nrpe.d/') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into 'root' }
  end

  describe file('/etc/nrpe.d/general.cfg') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into 'root' }
  end

  basic_nagios_plugins.each do |plugin|
    describe package(plugin) do
      it { is_expected.not_to be_installed }
    end
  end
end
