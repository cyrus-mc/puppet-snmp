require 'spec_helper'
describe 'snmpd' do

  context 'with defaults for all parameters' do
    it { should contain_class('snmpd') }
  end
end
