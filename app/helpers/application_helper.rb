module ApplicationHelper
  def flash_term(key)
    case key.to_s
    when 'success' then 'success'
    when 'error' then 'danger'
    else 'warning'
    end
  end
end
