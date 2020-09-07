class StaticInput < SimpleForm::Inputs::Base
  # This method usually returns input's html like <input ... />
  # but in this case it returns just a value of the attribute.
  def input(wrapper_options)
    content = @builder.object.send(attribute_name)

    if content.is_a? Array

      content.inject([]) do |result, text|
        result << content_tag(:p, text, class:"static")
        result
      end.join

    else

      content_tag(:p, content.to_s, class:"static")

    end
  end
end
