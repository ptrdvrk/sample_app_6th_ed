shared_context 'logged_in' do |user_id|
  before do
    include Rack::Test::Methods

    user = send("user_#{user_id}")
    post '/login', params: { session: { email: user.email, password: 'password' } }
    request.session[:user_id] = user.id
  end
end
