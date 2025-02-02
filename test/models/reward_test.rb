# frozen_string_literal: true

require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  setup do
    @current_user = users(:alice)
    @other_user = users(:bob)
    @reward_in_progress = rewards(:alice_reward_in_progress)
    @reward_completed = rewards(:alice_reward_completed)
  end

  test 'should be in progress' do
    assert_predicate @reward_in_progress, :in_progress?
  end

  test 'should not be in progress' do
    assert_not @reward_completed.in_progress?
  end

  test 'should only search in progress records' do
    rewards = Reward.search_completed_or_in_progress('inprogress', @current_user)
    assert_includes rewards, @reward_in_progress
    assert_not_includes rewards, @reward_completed
  end

  test 'should only search completed records' do
    rewards = Reward.search_completed_or_in_progress('completed', @current_user)
    assert_not_includes rewards, @reward_in_progress
    assert_includes rewards, @reward_completed
  end

  test 'should not search rewards from other user' do
    rewards_in_progress = Reward.search_completed_or_in_progress('inprogress', @other_user)
    assert_not_includes rewards_in_progress, @reward_in_progress
    assert_not_includes rewards_in_progress, @reward_completed

    rewards_completed = Reward.search_completed_or_in_progress('completed', @other_user)
    assert_not_includes rewards_completed, @reward_in_progress
    assert_not_includes rewards_completed, @reward_completed
  end
end
