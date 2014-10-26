require 'rails_helper'

describe Api::V1::UsersController do
  before(:each) { request.headers['Accept'] = "application/vnd.doctor.v1" }

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end

    it { should respond_with 200 }
  end

	describe "POST #create" do
		
		context "when successfully created" do
		
			before(:each) do
				@user_attributes = FactoryGirl.attributes_for :user
				post :create, { user: @user_attributes }, format: :json
			end

			it "creates and return proper value" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eql @user_attributes[:email]
			end

			it { should respond_with 201 }
		end

		context "when is not created" do
			before(:each) do
				@invalid_user_attrs = { password: "12345678", password_confirmation: "12345678"}
				post :create, { user: @invalid_user_attrs }, format: :json
			end

			it "return errors" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end

			it { should respond_with 422 }
		end

	end

	describe "PUT #update" do
		context "when is successfully updated" do
			before(:each) do
				@user = FactoryGirl.create :user
				patch :update, {id: @user.id,
					user: { email: "johny@hotmail.com" }
				}, format: :json
			end

			it "correct JSON" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eql "johny@hotmail.com"
			end

			it { should respond_with 200 }
		end

		context "when user is not updated" do
			before(:each) do
				@user = FactoryGirl.create :user
				patch :update, { id: @user.id,
					user: { email: "skata.co" }, format: :json
				}
			end

			it "should return error key" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end

			it { should respond_with 422 }
		end
	end

	describe "DELETE #destroy" do
		before(:each) do
			@user = FactoryGirl.create :user
			delete :destroy, { id: @user.id }, format: :json
		end

		it { should respond_with 204 }
	end
end
