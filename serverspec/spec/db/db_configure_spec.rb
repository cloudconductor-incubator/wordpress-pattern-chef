require 'spec_helper'

# Check listen port
describe port(3306) do
  it { should be_listening.with('tcp6') }
end
