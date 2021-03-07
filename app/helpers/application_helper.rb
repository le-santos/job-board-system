module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success p-2'
    when 'error'
      'alert-danger p-2'
    when 'alert'
      'alert-warning p-2'
    when 'notice'
      'alert-info p-2'
    else
      flash_type.to_s
    end
  end
end
