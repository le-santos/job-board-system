class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_action
  
  def store_action
    return unless request.get? 
    if (request.path != "/candidates/sign_in" &&
        request.path != "/candidates/sign_up" &&
        request.path != "/candidates/password/new" &&
        request.path != "/candidates/password/edit" &&
        request.path != "/candidates/confirmation" &&
        request.path != "/candidates/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:candidate, request.fullpath)
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    company = Company.find(resource.company_id)
		
    if resource_or_scope.is_a?(Employee) && company&.has_empty_profile?
      edit_company_path(resource.company_id)
  	else
			super
		end
	end	

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
