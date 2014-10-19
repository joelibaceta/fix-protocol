require_relative '../../../spec_helper'

describe 'FP::Messages::Logon' do

  context 'a parsed message' do
    before do
      msg = "8=FIX.4.4\x019=74\x0135=A\x0149=INVMGR\x0156=BRKR\x0134=1\x0152=20000426-12:05:06\x0198=0\x01108=30\x01553=USERNAME\x0110=110\x01"
      @parsed = FP.parse(msg)
    end

    it 'should be of the correct type' do
      expect(@parsed).to be_a_kind_of(FP::Messages::Logon)
    end

    it 'should return the correct field values' do
      expect(@parsed.username).to eql('USERNAME')
      expect(@parsed.heart_bt_int).to eql(30)
    end
  end

  describe '#username' do
    it 'should set a body field' do
      m = FP::Messages::Logon.new
      m.username = 'john'
      expect(m.nodes[3].value).to eql('john')
      expect(m.nodes[3].tag).to eql(553)
      expect(m.username).to eql('john')
    end
  end

  describe '#validate' do
    before do 
      @msg = FP::Messages::Logon.new
    end

    it 'should be invalid' do
      expect(@msg.valid?).to be_falsey
    end

    it 'should report the lack of username' do
      expect(@msg.errors).to include('Missing value for <username> field')
    end

    it 'should report the lack of sender_comp_id' do
      expect(@msg.errors).to include('Missing value for <sender_comp_id> field')
    end

    it 'should report the lack of target_comp_id' do
      expect(@msg.errors).to include('Missing value for <target_comp_id> field')
    end
  end 

  describe '#dump' do
    it 'should return nil when the message to dump is invalid' do
      expect(FP::Messages::Logon.new.dump).to be_nil
    end

    it 'should generate a proper message string' do
      msg = FP::Messages::Logon.new
      msg.header.sender_comp_id = 'TEST_SENDER'
      msg.header.target_comp_id = 'TEST_TARGET'
      msg.header.msg_seq_num    = 1
      msg.username              = 'TEST_USERNAME'

      expect(msg.dump).to be_a_kind_of(String)
    end
  end

end
