DoctorApi::Application.routes.draw do
	namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
		#Api resources
	end
end
