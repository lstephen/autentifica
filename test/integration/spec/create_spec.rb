require 'airborne'
require 'securerandom'

describe 'Create User' do

  Airborne.configure do |config|
    config.base_url = ENV['AUTENTIFICA_URL']
  end

  context 'when user created' do
    let (:id) { 'John_Doe' }
    let (:password) { SecureRandom.base64 }

    subject! {
      post '/user', { :id => id, :password => password }
    }

    let! (:location) { headers[:location] }

    it { expect_status 200 }
    it { expect(json_body[:id]).to eq(id) }
    it { expect(location).to eq("#{ENV['AUTENTIFICA_URL']}/user/#{id}") }
  end

  context 'incomplete user supplied' do
    let (:id) { 'Malformed_User' }
    let (:password) { SecureRandom.base64 }

    it 'does not allow no user' do
      post '/user'
      expect_status 400
    end

    it 'does not allow an empty user' do
      post '/user', {}
      expect_status 400
    end

    it 'does not allow a user with no id' do
      post '/user', { :password => password }
      expect_status 400
    end

    it 'does not allow a user with no password' do
      post '/user', { :id => id }
      expect_status 400
    end
  end

end

