# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe MicropostsController, type: :request do
  include_context 'fixture data'

  path '/microposts' do
    post 'creates a micropost' do
      response 302, 'not logged in' do
        run_test!
      end
    end
  end
end
