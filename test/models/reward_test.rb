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
