module Admin::AdsHelper
  def advertiser_created_ckbox f
    content = "<i class=\"flaticon-users\"></i> 代理商"
    content << "  <label>"
    content << '<input type="checkbox" id="is-create-advertiser" name="ad[is_create_advertiser]" />'
    content << "  新增</label>"
    content.html_safe
  end
end
