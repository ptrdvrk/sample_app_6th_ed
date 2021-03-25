# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe MicropostsController, type: :request do
  include_context 'fixture data'

  path '/microposts' do
    get 'lists current user microposts' do
      response 200, 'ok' do
        include_context 'logged_in', 'michael'
        run_test!
      end

      response 401, 'unauthorized' do
        run_test!
      end
    end
  
    post 'creates a micropost' do
      response 302, 'not logged in' do
        run_test!
      end
    end
  end

  <<~LOGOUT
  path '/logout' do
    delete 'logout' do
      response 302, 'logged out' do
        run_test!
      end
    end
  end
  LOGOUT
end
