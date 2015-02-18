require 'airborne'
require 'securerandom'

describe 'POST /user' do

  Airborne.configure do |config|
    config.base_url = ENV['AUTENTIFICA_URL']
  end

  let (:id) { 'John_Doe' }
  let (:password) { SecureRandom.base64 }

  subject! {
    post '/user', user
  }

  context 'valid request' do
    let (:user) { { :id => id, :password => password } }

    let! (:location) { headers[:location] }

    it { expect_status 200 }
    it { expect(json_body[:id]).to eq(id) }
    it { expect(location).to eq("#{ENV['AUTENTIFICA_URL']}/user/#{id}") }
  end

  context 'no user' do
    let (:user) { nil }
    it { expect_status 400 }
  end

  context 'empty user' do
    let (:user) { {} }
    it { expect_status 422 }
  end

  context 'no id' do
    let (:user) { { :password => password } }
    it { expect_status 422 }
  end

  context 'no password' do
    let (:user) { { :id => id } }
    it { expect_status 422 }
  end

end

