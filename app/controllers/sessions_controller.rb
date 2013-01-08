class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token

  def create
    respond_to do |format|
      format.html { super }
      format.json {
        resource = warden.authenticate!(:scope => resource_name, :recall => :failure)
        return sign_in_and_redirect(resource_name, resource)
      }
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {:success => 1, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
  end

  def failure
    return render:json => {:success => 0, :errors => ["Login failed."]}
  end
end