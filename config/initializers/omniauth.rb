Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '462524327155629', '76e58370644e6937edce0b10338e6019',
           :scope => 'email,user_birthday,read_stream', :display => 'popup'

  #OmniAuth.config.on_failure = Proc.new do |env| new_path = "/auth/failure"
  #  [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
  #end
end