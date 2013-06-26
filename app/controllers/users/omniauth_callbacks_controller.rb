class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    oauthorize "Facebook"
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

private

  def oauthorize(kind)
    @user = find_for_ouath(kind, env["omniauth.auth"])
    if @user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => kind
      session["devise.#{kind.downcase}_data"] = env["omniauth.auth"]
      sign_in_and_redirect @user, :event => :authentication
    end
  end

  def find_for_ouath(provider, access_token)
    user, auth_attr = nil, {}
    case provider
    when "Facebook"
      extra_info = access_token['extra']['raw_info']
      info = access_token['info']
      auth_attr = { :uid      => access_token['uid'],
                    :token    => access_token['credentials']['token'],
                    :secret   => nil,
                    :name     => extra_info['name'],
                    :link     => extra_info['link'],
                    :email    => extra_info['email'],
                    :nickname => info['nickname'],
                    :location => info['location'],
                    :image    => info['image'],
                    :dob      =>  Date.strptime(extra_info['birthday'],'%m/%d/%Y'),
                    :provider => provider }
    else
      raise 'Provider #{provider} not handled'
    end
    user = find_for_oauth_by_email(auth_attr)
  end

  def find_for_oauth_by_email(auth_attr)    
    if user = User.find_by_email(auth_attr[:email])
      user
    else
      user = User.new(:email => auth_attr[:email], 
                      :password => Devise.friendly_token[0,20])
      user.save
      create_new_user(auth_attr)
    end
    return user
  end

  def create_new_user(auth_attr)
    profile_attr = auth_attr[:name].split(' ')
    user.profile.update_attributes( :name              => profile_attr.first, 
                                    :surname           => profile_attr.last, 
                                    :nickname          => auth_attr[:nickname],
                                    :locality          => auth_attr[:location],
                                    :dob               => auth_attr[:dob],
                                    :remote_avatar_url => auth_attr[:image].split("=")[0] << "=large" )
    user.authorizations.create( :provider => auth_attr[:provider],
                                :uid      => auth_attr[:uid],
                                :token    => auth_attr[:token] )
    user
  end
end
