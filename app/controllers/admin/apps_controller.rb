class Admin::AppsController < ApplicationController

  layout "admin"

  helper_method :menus, :current_menu_name, :current_item_name, :current_item_link, :current_breadcrumb

  def menus
    all_menus = YAML.load_file 'config/menus.yml'
    all_menus['admin']
  end

  def items
    menus.map { |menu| menu['items'] }.flatten
  end

  def current_index
    request.fullpath.split('/')[0..2].join('/')
  end

  def current_menu_name
    menu = current_menu || {}
    menu.fetch('name') { '' }
  end

  def current_item_name
    item = current_item || {}
    item.fetch('name') { '' }
  end

  def current_item_link
    item = current_item || {}
    item.fetch('link') { 'javascript:void(0)' }
  end

  def current_breadcrumb
    @current_breadcrumb || {}
  end

  def root_path_on_identify
    path = case current_administrator.identity
           when 'news'
             admin_news_index_path
           when 'advertisement'
             admin_ads_path
           else
             admin_devices_path
           end

    redirect_to path
  end

  private
  def current_menu
    menus.find do |menu|
      links = menu.fetch('items',[]).map { |item| item['link'] }
      if links.present?
        links.include? current_index
      else
        menu['link'] == current_index
      end
    end
  end

  def current_item
    items.find { |item| item['link'] == current_index }
  end

end
