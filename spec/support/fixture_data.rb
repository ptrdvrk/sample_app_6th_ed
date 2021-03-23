shared_context 'fixture data' do
  let(:user_michael) do
    User.create name: 'Michael Example',
      email: 'michael@example.com',
      password_digest: User.digest('password'),
      admin: true,
      activated: true,
      activated_at: Time.zone.now
  end

  let(:micropost_orange) do
    Micropost.create content: "I just ate an orange!",
      created_at: 10.minutes.ago,
      user: michael
  end
end
