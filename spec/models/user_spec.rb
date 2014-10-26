require 'rails_helper'

describe User do
	before { @user = FactoryGirl.build(:user) }

	subject { @user }
	
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:auth_token) }
	
	it { should validate_presence_of(:email) }

	it { should validate_uniqueness_of(:email) }
	it { should validate_confirmation_of(:password) }
	it { should allow_value('example@domain.com').for(:email) }
	it { should validate_uniqueness_of(:auth_token)}
		
	it { should be_valid }

	describe "#generate_authentication_token!" do
		it "generates an unique token" do
			Devise.stub(:friendly_token).and_return("uniquetoken12345")
			@user.generate_authentication_token!
			expect(@user.auth_token).to eql "uniquetoken12345"
		end
	end
end


