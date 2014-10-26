require 'api_constraints'

DoctorApi::Application.routes.draw do
  devise_for :users
	namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
		scope module: :v1,
			constraints: ApiConstraints.new(version: 1, default: true) do
		
			#Api resources
		end
	end
end
