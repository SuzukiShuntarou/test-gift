# frozen_string_literal: true

require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  setup do
    @current_user = users(:alice)
    @other_user = users(:bob)
    @another_user = users(:charlie)
    @reward_in_progress = rewards(:alice_reward_in_progress)
    @reward_completed = rewards(:alice_reward_completed)
  end

  test 'should be in progress' do
    assert_predicate @reward_in_progress, :in_progress?
  end

  test 'should not be in progress' do
    assert_not @reward_completed.in_progress?
  end

  test 'should only search in progress rewards' do
    rewards = Reward.search_completed_or_in_progress('inprogress', @current_user)
    assert_includes rewards, @reward_in_progress
    assert_not_includes rewards, @reward_completed
  end

  test 'should only search completed rewards' do
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

  test 'should seach rewards for users belonging to group' do
    reward_with_alice_and_bob = rewards(:alice_bob_reward_in_progress)

    rewards_current_user = Reward.search_completed_or_in_progress('inprogress', @current_user)
    assert_includes rewards_current_user, reward_with_alice_and_bob

    rewards_other_user = Reward.search_completed_or_in_progress('inprogress', @other_user)
    assert_includes rewards_other_user, reward_with_alice_and_bob
  end

  test 'should not seach rewards for users not belonging to group' do
    reward_with_alice_and_bob = rewards(:alice_bob_reward_in_progress)

    rewards_another_user = Reward.search_completed_or_in_progress('inprogress', @another_user)
    assert_not_includes rewards_another_user, reward_with_alice_and_bob
  end

  test 'should be added to in progress group when invited' do
    groups_before_invite = @reward_in_progress.groups
    assert_not_includes groups_before_invite.map(&:user_id), @other_user.id

    @reward_in_progress.invite(@other_user)
    groups_after_invite = @reward_in_progress.groups
    assert_includes groups_after_invite.map(&:user_id), @other_user.id
  end

  test 'should not be added to completed group when invited' do
    @reward_completed.invite(@other_user)
    groups_completed = @reward_completed.groups
    assert_not_includes groups_completed.map(&:user_id), @other_user.id
  end
end
