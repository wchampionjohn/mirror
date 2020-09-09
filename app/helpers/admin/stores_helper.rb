module Admin::StoresHelper

  def process_bar_width
    case store.achieved_step
    when 0
      '0'
    when 1
      '33'
    when 2
      '66'
    else
      '100'
    end
  end

  def path_of_step(store, num)
    if store.current_step == num
      'javascript:void(0)'
    elsif store.new_record? && num == 2
      'javascript:void(0)'
    else
      edit_admin_store_path(store, step: num)
    end
  end

  def class_of_step(store, num)
    if store.current_step == num
      'm-wizard__step--current'
    elsif !store.new_record?
      'm-wizard__step m-wizard__step--done'
    else
      ''
    end
  end

  def text_of_enable_scrolling_text boolean
    boolean ? '開啟' : '關閉'
  end

  def text_of_resolutions resolutions
    resolutions.map(&:size).join('、')
  end

  def text_of_save store
    if store.new_record?
      '下一步 <i class="la la-arrow-right"></i>'.html_safe
    else
      '儲存'
    end
  end

  def text_of_cancel store
    if store.current_step == 1
      '取消'
    else
      '上一步'.html_safe
    end
  end

  def prev_step_of_store record
    if (record.current_step == 1)
      admin_stores_path
    else
      edit_admin_store_path(current_object, step: current_object.current_step - 1)
    end
  end

end
