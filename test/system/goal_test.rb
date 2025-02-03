# frozen_string_literal: true

require 'application_system_test_case'

class GoalsTest < ApplicationSystemTestCase
  # def visit_reward_in_progress_path(reward)
  #   visit rewards_path
  #   assert_text 'Rewards#index'
  #   click_link_or_button '実施中'
  #   assert_selector 'a', text: "#{reward.location}で#{reward.content}する"
  #   click_link_or_button "#{reward.location}で#{reward.content}する"
  #   assert_text 'Rewards#show'
  # end

  # test 'visiting goals index in progress and completed' do
  #   visit rewards_path
  #   assert_text 'Rewards#index'

  #   assert_text '実施中'
  #   assert_text '叙々苑で食事する'

  #   click_link_or_button '完了'
  #   assert_text '草津で温泉旅行する'
  # end
end
