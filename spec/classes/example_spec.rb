require 'spec_helper'

describe 'examples' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "examples class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('examples::params') }
          it { is_expected.to contain_class('examples::install').that_comes_before('examples::config') }
          it { is_expected.to contain_class('examples::config') }
          it { is_expected.to contain_class('examples::service').that_subscribes_to('examples::config') }

          it { is_expected.to contain_service('examples') }
          it { is_expected.to contain_package('examples').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'examples class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('examples') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
