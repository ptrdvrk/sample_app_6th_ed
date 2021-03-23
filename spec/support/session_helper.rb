shared_context 'logged_in' do |user_id|
  before do
    user = send("user_#{user_id}")
    byebug 
    request.session[:user_id] = user.id
  end
end
