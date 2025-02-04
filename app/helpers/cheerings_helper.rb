# frozen_string_literal: true

module CheeringsHelper
  def show_cheering_count(goal)
    display = goal.cheerings.includes(:user).map do |cheering|
      if cheering.cheering_count > 0
        "#{cheering.user.name}さんが#{cheering.cheering_count}回"
      end
    end

    if display.compact.empty?
      "まだ静かな時間が流れているね。応援で流れを変えてみては？"
    else
      "#{display.compact.join('、')}も応援しているよ！"
    end
  end
end
