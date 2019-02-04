module ApplicationHelper
  def date_text(date)
    date.strftime('%Y年%-m月%-d日')
  end
end
