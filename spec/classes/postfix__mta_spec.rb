require 'spec_helper'

describe 'postfix::mta', :type => :class do
  context "On Redhat 6" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystem        => 'RedHat',
        :lsbmajdistrelease      => '6',
        :operatingsystemrelease => '6',
      }
    end
    context "postfix_relayhost unset" do
      it "Raise error about unset" do
        expect { subject
        }.to raise_error(Puppet::Error, /Must pass postfix_relayhost to Class/)
      end
    end
    context "postfix_relayhost set" do
      let (:params) {
        { :postfix_relayhost => '127.0.0.1' }
      }
      it { should include_class('postfix') }
      it { should include_class('postfix::mta') }
      it { should contain_file('/etc/postfix/main.cf') }
    end 
  end
end
