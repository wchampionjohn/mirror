# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn btn-brand'
  config.boolean_label_class = nil
  config.item_wrapper_tag = :label

  config.wrappers :steps_form, tag: 'div', class: 'col-lg-6 col-md-9 col-sm-12', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: ''

    b.use :input, class: 'form-control m-input'
    b.use :error, wrap_with: { tag: 'p', class: 'm-form__help m--font-danger' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'm-form__help' }
  end

  config.wrappers :horizontal_radio_buttons, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|

    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-md-6 control-label'

    b.wrapper tag: 'div', class: 'col-md-10' do |ba|
      ba.wrapper tag: 'div', class: 'm-radio-inline' do |bc|
        bc.use :input do |bd|
          bd.wrapper tag: 'span'
        end
      end
      # ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
       #ba.use :hint,  wrap_with: { tag: 'span' }
    end
  end

  config.wrappers :input_group, tag: 'div', class: 'form-group m-form__group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: 'col-xl-3 col-lg-3 col-form-label'

    b.wrapper tag: 'div', class: 'col-xl-8 col-lg-8' do |ba|
      ba.wrapper tag: 'div', class: 'input-group' do |append|
        append.use :input, class: 'form-control'
      end
      ba.use :error, wrap_with: { tag: 'p', class: 'm-form__help m--font-danger' }
      ba.use :hint,  wrap_with: { tag: 'span', class: 'm-form__help' }
    end
  end


  config.wrappers :inline_form, tag: 'div', class: '', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label

    b.use :input, class: 'form-control'
    b.use :hint,  wrap_with: { tag: 'span', class: 'm--font-metal' }
    b.use :error, wrap_with: { tag: 'p', class: 'm-form__help m--font-danger' }
  end

  config.wrappers :modal_form, tag: 'div', class: 'form-group m-form__group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'form-control-label'

    b.use :input, class: 'form-control'
    b.use :hint,  wrap_with: { tag: 'span', class: 'm--font-metal' }
    b.use :error, wrap_with: { tag: 'p', class: 'm-form__help m--font-danger' }
  end

  config.wrappers :static, tag: 'div', class: 'form-group m-form__group row' do |b|

    b.use :html5
    b.use :label, class: 'col-lg-4 col-sm-12'
    b.wrapper tag: 'div', class: 'col-lg-4 col-md-9 col-sm-12' do |ba|
      ba.use :input
    end
  end

  config.wrappers :horizontal_boolean, tag: 'div', class: 'form-group m-form__group row', error_class: 'has-error' do |b|

    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-xl-3 col-lg-3 col-form-label'

    b.wrapper tag: 'div', class: 'col-xl-9 col-lg-9' do |ba|
    ba.wrapper tag: 'div', class: 'checkbox-list' do |bc|
      bc.wrapper tag: 'label', class: 'checkbox-inline' do |bd|
        bd.use :input
        end
      end
    end
  end

  config.wrappers :vertical_boolean, tag: 'div', class: 'form-group m-form__group row', error_class: 'has-error' do |b|

    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-lg-4 col-sm-12'

    b.wrapper tag: 'div', class: 'col-lg-4 col-md-9 col-sm-12', wrapper: :store_input_group do |ba|
    ba.wrapper tag: 'div', class: 'checkbox-list' do |bc|
      bc.wrapper tag: 'label', class: 'checkbox-inline' do |bd|
        bd.use :input
        end
      end
    end
  end

  config.wrappers :vertical_form, tag: 'div', class: 'form-group m-form__group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper tag: 'div', class: 'col-lg-12 col-md-9 col-sm-12' do |ba|
      ba.use :label
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'm-form__help m--font-danger' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'm-form__help' }
    end
  end

  config.wrappers :date_range, tag: 'div', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: { tag: 'span', class: 'm-form__help' }
  end

  config.wrappers :store_form, tag: 'div', class: 'form-group m-form__group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: 'col-xl-3 col-lg-3 col-form-label'

    b.wrapper tag: 'div', class: 'col-xl-9 col-lg-9' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'p', class: 'm-form__help m--font-danger' }
      ba.use :hint,  wrap_with: { tag: 'span', class: 'm-form__help' }
    end
  end
  config.wrappers :store_input_group, tag: 'div', class: 'form-group m-form__group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: 'col-xl-3 col-lg-3 col-form-label'

    b.wrapper tag: 'div', class: 'col-xl-9 col-lg-9' do |ba|
      ba.wrapper tag: 'div', class: 'input-group' do |append|
        append.use :input, class: 'form-control'
      end
      ba.use :error, wrap_with: { tag: 'p', class: 'm-form__help m--font-danger' }
      ba.use :hint,  wrap_with: { tag: 'span', class: 'm-form__help' }
    end
  end

  # Wrappers for forms and inputs using the Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
    check_boxes: :horizontal_checkboxes,
    radio_buttons: :horizontal_radio_buttons,
    file: :horizontal_file_input,
    boolean: :horizontal_boolean,
    static: :static,
  }
end
