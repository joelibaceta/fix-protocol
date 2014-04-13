require_relative '../../spec_helper'

describe 'Fix::Messages::Heartbeat' do

  before do
    @msg = "8=FIX.4.4\x019=74\x0135=0\x0149=AAAA\x0156=BBB\x0134=2\x0152=20080420-15:16:13\x01112=L.0001.0002.0003.151613\x0110=034\x01"
  end

  describe '#test_req_id' do
    it 'should return the correct value' do
      h = Fix.parse(@msg)
      h.test_req_id.should eql("L.0001.0002.0003.151613")
    end
  end

  describe '#dump' do
    it 'should return the same message that was parsed' do
      Fix.parse(@msg).dump.should eql(@msg)
    end 
  end

end