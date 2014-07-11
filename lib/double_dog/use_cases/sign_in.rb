require_relative 'check_this.rb'
require_relative 'check_admin.rb'


module DoubleDog
  class SignIn < CheckThis

    def run(params)
      return failure(:nil_username) if params[:username].nil?
      return failure(:blank_username) if params[:username] == '' # same if-statments
      return failure(:nil_password) if params[:password].nil?
      return failure(:blank_password) if params[:password] == ''

      user = DoubleDog.db.get_user_by_username(params[:username])

      return failure(:no_such_user) if user.nil?
      return failure(:invalid_password) unless user.has_password?(params[:password])

      session_id = DoubleDog.db.create_session(user_id: user.id)
      retrieved_user = DoubleDog.db.get_user_by_session_id(session_id)
    end

  end
end
