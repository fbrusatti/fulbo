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
    user, auth_attr = nil, {}
    case provider
    when "Facebook"
      extra_info = access_token['extra']['raw_info']
      info = access_token['info']
      auth_attr = { :uid => access_token['uid'],
                    :token => access_token['credentials']['token'],
                    :secret => nil,
                    :name => extra_info['name'],
                    :link => extra_info['link'],
                    :email => extra_info['email'],
                    :nickname => info['nickname'],
                    :location => info['location'],
                    :image => info['image'],
                    :dob =>  Date.strptime(extra_info['birthday'],'%m/%d/%Y') }
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
      if auth_attr[:email]
        user = find_for_oauth_by_email(resource, auth_attr)
      elsif auth_attr[:uid] && auth_attr[:name]
        user = find_for_oauth_by_uid(auth_attr[:uid], resource)
        if user.nil?
          user = find_for_oauth_by_name(resource, auth_attr)
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

  def find_for_oauth_by_email(resource=nil, auth_attr)    
    if user = User.find_by_email(auth_attr[:email])
      user
    else
      user = User.new(:email => auth_attr[:email], 
                      :password => Devise.friendly_token[0,20])
      user.save
      profile_attr = auth_attr[:name].split(' ')
      user.profile.update_attributes( :name => profile_attr.first, 
                                      :surname => profile_attr.last, 
                                      :nickname => auth_attr[:nickname],
                                      :locality => auth_attr[:location],
                                      :dob => auth_attr[:dob],
                                      :avatar => auth_attr[:image] )
    end
    return user
  end

  def find_for_oauth_by_name(resource=nil, auth_attr)
    if user = User.find_by_name(auth_attr[:name])
      user
    else
      user = User.new(:name => auth_attr[:name], 
                      :password => Devise.friendly_token[0,20], 
                      :email => auth_attr[:email])
      user.save false
      profile_attr = auth_attr[:name].split(' ')
      user.profile.update_attributes( :name => profile_attr.first, 
                                      :surname => profile_attr.last, 
                                      :nickname => auth_attr[:nickname],
                                      :locality => auth_attr[:location],
                                      :dob => auth_attr[:dob],
                                      :avatar => auth_attr[:image] )
    end
    return user
  end
end
