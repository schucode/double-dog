require 'spec_helper'

describe DoubleDog::CreateAccount do

  before (:each) do
    @use_case = DoubleDog::CreateAccount.new
    @use_case.stub(:admin_session?).and_return(false, true)
    #expect(@use_case).to receive(:admin_session?).and_return(true)
  end

  describe 'Validation' do

    it "requires the creator to be an admin" do

      #@use_case = DoubleDog::CreateAccount.new
      #expect(@use_case).to receive(:admin_session?).and_return(false)

      result = @use_case.run(:session_id => 'nope', :username => 'a', :password => 'b')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :not_admin
    end

    it "requires a username" do
      # @use_case = DoubleDog::CreateAccount.new
      # expect(@use_case).to receive(:admin_session?).and_return(true)

      result = @use_case.run(:session_id => 0, :password => 'bluh')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_username
    end

    # DUP with three characters
    it "requires a username to be at least three characters" do
      # @use_case = DoubleDog::CreateAccount.new
      # expect(@use_case).to receive(:admin_session?).and_return(true)

      result = @use_case.run(:session_id => 0, :username => 'ab', :password => 'bluh')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_username
    end

    # DUP with password three characters
    it "requires a password" do
      # @use_case = DoubleDog::CreateAccount.new
      # expect(@use_case).to receive(:admin_session?).and_return(true)

      result = @use_case.run(:session_id => 0, :username => 'bob')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_password
    end

    it "requires a password with at least three characters" do
      # @use_case = DoubleDog::CreateAccount.new
      # expect(@use_case).to receive(:admin_session?).and_return(true)

      result = @use_case.run(:session_id => 0, :username => 'bob', :password => '12')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_password
    end
  end

  it "creates an account" do
    # @use_case = DoubleDog::CreateAccount.new
    # expect(@use_case).to receive(:admin_session?).and_return(true)

    result = @use_case.run(:session_id => 0, :username => 'bob', :password => 'letmein')
    expect(result[:success?]).to eq true

    user = result[:user]
    expect(user.id).to_not be_nil
    expect(user.username).to eq 'bob'
    expect(user.has_password? 'letmein').to eq true
  end

end
