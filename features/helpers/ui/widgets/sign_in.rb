module Ui
  module Widgets
    class SignIn
      include Capybara::DSL

      def sign_in_as(role)
        login_as(@current_user, :scope => :user)
      end
    end
  end
end

