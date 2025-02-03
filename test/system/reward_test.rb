# frozen_string_literal: true

require 'application_system_test_case'

class RewardsTest < ApplicationSystemTestCase
  setup do
    @reward = rewards(:alice_reward_in_progress)
    visit new_user_session_path
    assert_text 'Log in'
    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Log in'
    assert_text 'Signed in successfully.'
  end

  test 'visiting rewards show in progress' do
    goal = goals(:alice_goal_in_progress)
    liking = favorites(:alice_liking_in_progress)
    cheering = cheerings(:alice_cheering_in_progress)

    visit reward_path(@reward)

    within('#reward') do
      assert_text "#{@reward.completiondate}に"
      assert_text "#{@reward.location}で"
      assert_text "#{@reward.content}する"
    end

    within("div##{dom_id(goal)}") do
      assert_text "ユーザ名：#{goal.user.name}"
      assert_text "目標：#{goal.content}"
      assert_text "進捗率：#{goal.progress}%"
    end
    within("div##{dom_id(liking)}") do
      assert_text liking.good_count
    end
    within("div##{dom_id(cheering)}") do
      assert_text cheering.cheering_count
    end
  end

  test 'should create rewards and goal' do
    visit goals_path
    assert_text 'Goals#index'
    click_link_or_button '新規作成'

    within("form[action='/rewards']") do
      fill_in 'reward[completiondate]', with: Date.current.tomorrow
      fill_in 'reward[location]', with: '叙々苑'
      fill_in 'reward[content]', with: '焼肉'
      fill_in 'reward[goals_attributes][0][content]', with: '毎日早寝早起きする'
      fill_in 'reward[goals_attributes][0][progress]', with: 20
      click_link_or_button 'Create Reward'
    end

    assert_text 'ご褒美の登録に成功！'
    assert_text "#{Date.current.tomorrow}に"
    assert_text '叙々苑で'
    assert_text '焼肉する'
    assert_text '目標：毎日早寝早起きする'
    assert_text '進捗率：20%'
  end

  test 'should edit reward in progress' do
    visit reward_path(@reward)

    within('#reward') do
      assert_selector 'a', text: '編集'
      click_link_or_button '編集'
    end
    within('.modal-body') do
      fill_in 'reward_location', with: '草津'
      fill_in 'reward_content', with: '温泉旅行'
      click_link_or_button '保存'
    end

    assert_text '草津で'
    assert_text '温泉旅行する'
  end

  test 'should edit goal in progress' do
    goal = goals(:alice_goal_in_progress)

    visit reward_path(@reward)

    within("div##{dom_id(goal)}") do
      assert_selector 'a', text: '編集'
      click_link_or_button '編集'
    end
    within('.modal-body') do
      fill_in 'goal_content', with: 'ランニングする'
      fill_in 'goal_progress', with: '99'
      click_link_or_button '保存'
    end
    assert_text '目標：ランニングする'
    assert_text '進捗率：99%'
  end

  test 'should delete reward and goal in progress' do
    goal = goals(:alice_goal_in_progress)
    visit reward_path(@reward)
    within('#reward') do
      assert_selector 'button', text: '削除'
      click_link_or_button '削除'
      page.accept_alert
    end

    assert_current_path goals_path
    assert_text 'ご褒美の削除に成功！'
    assert_no_text goal.content
  end

  test 'should increase count when liking and cheering button clicked' do
    liking = favorites(:alice_liking_in_progress)
    cheering = cheerings(:alice_cheering_in_progress)

    visit reward_path(@reward)

    within("div##{dom_id(liking)}") do
      assert_text 10
      click_link_or_button
      assert_text 11
    end
    within("div##{dom_id(cheering)}") do
      assert_text 0
      click_link_or_button
      assert_text 1
    end
  end

  test 'should not display edit, delete, and invite buttons for completed reward' do
    goal = goals(:alice_goal_completed)

    visit goals_path
    assert_text 'Goals#index'
    click_link_or_button '完了'
    assert_selector 'a', text: goal.content
    click_link_or_button goal.content
    assert_text 'Rewards#show'

    within('#reward') do
      assert_no_selector 'a', text: '編集'
      assert_no_selector 'button', text: '削除'
    end

    within("div##{dom_id(goal)}") do
      assert_no_selector 'a', text: '編集'
    end

    assert_no_selector 'button', text: '招待用URLをコピー'
  end
end
