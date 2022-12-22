module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
        success: 'alert-success',
        error: 'alert-danger',
        alert: 'alert-danger',
        warning: 'alert-warning',
        notice: 'alert-success'
    }[flash_type.to_sym]
  end
end
