class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    oauthorize "Facebook"
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

private

  def oauthorize(kind)
    @user = find_for_ouath(kind, env["omniauth.auth"], current_user)
    if @user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => kind
      session["devise.#{kind.downcase}_data"] = env["omniauth.auth"]
      sign_in_and_redirect @user, :event => :authentication
    end
  end

  def find_for_ouath(provider, access_token, resource=nil)
    user, email, name, uid, auth_attr = nil, nil, nil, {}
    case provider
    when "Facebook"
      uid = access_token['uid']
      email = access_token['extra']['raw_info']['email']
      auth_attr = { :uid => uid,
                    :token => access_token['credentials']['token'],
                    :secret => nil,
                    :name => access_token['extra']['raw_info']['name'],
                    :link => access_token['extra']['raw_info']['link'],
                    :nickname => access_token['info']['nickname'],
                    :location => access_token['info']['location'],
                    :dob =>  Date.strptime(access_token['extra']['raw_info']['birthday'],'%m/%d/%Y'),
                    :image => access_token['info']['image'] }
    when "Twitter"
      uid = access_token['extra']['user_hash']['id']
      name = access_token['user_info']['name']
      auth_attr = { :uid => uid, 
                    :token => access_token['credentials']['token'], 
                    :secret => access_token['credentials']['secret'], 
                    :name => name, 
                    :link => "http://twitter.com/#{name}" }
    else
      raise 'Provider #{provider} not handled'
    end
    if resource.nil?
      if email
        user = find_for_oauth_by_email(email, resource, auth_attr)
      elsif uid && name
        user = find_for_oauth_by_uid(uid, resource)
        if user.nil?
          user = find_for_oauth_by_name(name, resource)
        end
      end
    else
      user = resource
    end

    auth = user.authorizations.find_by_provider(provider)
    if auth.nil?
      auth = user.authorizations.build(:provider => provider)
      user.authorizations << auth
    end
    # auth.update_attributes auth_attr
    return user
  end

  def find_for_oauth_by_uid(uid, resource=nil)
    user = nil
    if auth = Authorization.find_by_uid(uid.to_s)
      user = auth.user
    end
    return user
  end

  def find_for_oauth_by_email(email, resource=nil, auth_attr)
    if user = User.find_by_email(email)
      user
    else
      user = User.new(:email => email, 
                      :password => Devise.friendly_token[0,20])
      user.save
      profile_attr = auth_attr[:name].split(' ')
      user.profile.update_attributes( :name => profile_attr[0], 
                                      :surname => profile_attr[1], 
                                      :nickname => auth_attr[:nickname],
                                      :locality => auth_attr[:location],
                                      :dob => auth_attr[:dob],
                                      :avatar => auth_attr[:image] )
    end
    return user
  end

  def find_for_oauth_by_name(name, resource=nil, auth_attr)
    if user = User.find_by_name(name)
      user
    else
      user = User.new(:name => name, 
                      :password => Devise.friendly_token[0,20], 
                      :email => "#{UUIDTools::UUID.random_create}@host")
      user.save false
      profile_attr = auth_attr[:name].split(' ')
      user.profile.update_attributes( :name => profile_attr[0], 
                                      :surname => profile_attr[1], 
                                      :nickname => auth_attr[:nickname],
                                      :locality => auth_attr[:location],
                                      :dob => auth_attr[:dob],
                                      :avatar => auth_attr[:image] )
    end
    return user
  end
end
