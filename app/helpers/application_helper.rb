module ApplicationHelper
  def date_text(date)
    date.strftime('%Y年%-m月%-d日')
  end

  def new_action?
    controller.action_name == 'new'
  end

  def defalt_date(date)
    date.present? ? date : Time.now.strftime('%Y-%m-%d')
  end
end
