# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @alice = users(:alice)
  end

  test 'can login' do
    visit new_user_session_path
    assert_text 'Log in'
    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    assert_text 'Signed in successfully.'
  end
end
