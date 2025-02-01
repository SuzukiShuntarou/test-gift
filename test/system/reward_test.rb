# frozen_string_literal: true

require 'application_system_test_case'

class RewardsTest < ApplicationSystemTestCase
  setup do
    visit new_user_session_path
    assert_text 'Log in'
    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    assert_text 'Signed in successfully.'
  end

  test 'visiting rewards index in progress and completed' do
    visit rewards_path
    assert_text 'Rewards#index'

    assert_text '実施中'
    assert_text '叙々苑で食事する'

    click_on '完了'
    assert_text '草津で温泉旅行する'
  end
end
