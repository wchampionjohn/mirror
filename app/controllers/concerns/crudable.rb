# reference https://5xruby.tw/posts/meta-rails-restful-controller
module Crudable
  extend ActiveSupport::Concern

  include Listable

  included do
    helper_method :model_class_name, :object_new_path, :index_tools, :index_title, :index_sub_title
    helper_method :current_collection, :current_object

    before_action only: [:new, :create] do
      @form_title ||= "新增#{humanlize_model_name}"
      @current_breadcrumb = { 'name' => @form_title, 'link' => "/admin/#{resources_name}/new" }
      @form_sub_title ||= "New #{model_class_name}"
    end

    before_action only: [:edit, :update] do
      @form_title ||= "編輯#{humanlize_model_name}"
      @current_breadcrumb = { 'name' => @form_title, 'link' => "/admin/#{resources_name}/#{current_object.id}/edit" }
      @form_sub_title ||= "Edit #{model_class_name}"
    end
  end

  def index
    respond_to do |format|
      format.html do
        render index_template
      end

      format.json do
        render json: collection_json(current_collection, serializer_class, serializer_options),
          status: :ok
      end
    end
  end

  def new
    render new_template
  end

  def create
    if current_object.attributes = object_params and current_object.save
      redirect_to action_after_create, :flash => {:success => '已完成新增'}
    else
      flash[:alert] = '新增時發生以下錯誤，請修正後再重新嘗試'
      render new_template
    end

  end

  def update
    update_method = if model_class.try(:devise_modules?) && object_params[:password].blank?
                      'update_without_password'
                    else
                      'update'
                    end

    if current_object.send(update_method, object_params)
      redirect_to action_after_update, :flash => {:success => '已完成修改'}
    else
      flash[:alert] = '修改時發生以下錯誤，請修正後再重新嘗試'
      render edit_template
    end
  end

  def edit
    render edit_template
  end

  def destroy
    model_class.where(id: params[:ids] || params[:id]).destroy_all
    redirect_to action_after_destroy, :flash => {:success => 'deleted successfully'}
  end

protected

  def model_class_name #may need to re-define in your controller
    self.class.to_s.demodulize.gsub('Controller', '').singularize
  end

  def model_class #may need to re-define in your controller
    model_class_name.constantize
  end

  def serializer_class_name
    "#{model_class_name}Serializer"
  end

  def serializer_class #may need to re-define in your controller
    serializer_class_name.constantize
  end

  def permitted_attributes
    #must re-define in your controller
  end

  def param_key
    if model_class_name.include? ('::')
      model_class_name.titleize.gsub('/', '')
    else
      model_class_name
    end.underscore.to_sym
  end

  def object_params
    params.require(param_key).permit(*permitted_attributes)
  end

  def action_after_create
    url_for(action: :index)
  end

  def action_after_update
    url_for(action: :index)
  end

  def default_scope
    q = {}
    q.merge! ( { filter_key => keyword } ) if keyword.present?
    q.merge! formated_selector_params if selectors.present?

    model_class
      .page(params[:page])
      .per(per_page)
      .order("#{sorting_name} #{sorting_taxis}")
      .ransack(q)
      .result
  end

  def object_new_path
    path = "new_#{controller_path.split('/').map(&:singularize).join('_')}_path"
    send path
  end

  def object_edit_path
    path = "edit_#{controller_path.split('/').map(&:singularize).join('_')}_path"
    send(path, current_object)
  end

  def current_object
    @current_object ||= if params[:id]
                          default_scope.find(params[:id])
                        else
                          model_class.new
                        end
  end

  def object_index_path

  end

  def index_tools
    @index_tools ||= default_tools
  end

  def index_title
    humanlize_model_name
  end

  def humanlize_model_name
    model_class.model_name.human
  end

  def index_sub_title
    model_class.to_s.titleize
  end

  def resources_name
    model_class.model_name.to_s.downcase.pluralize
  end

  def default_tools
    [
      { path: object_new_path, icon: 'la la-plus-circle',  content: "新增#{humanlize_model_name}",   btn_class: ' btn-success' },
    ]
  end

  def serializer_options
    {}
  end

  def index_template
    'shared/index'
  end

  def current_collection
    @current_collection ||= default_scope.page(params[:page])
  end

  alias action_after_destroy action_after_create

  def new_template
    'shared/form'
  end

  def edit_template
    'shared/form'
  end

  def new_form_title
    @new_form_title || "新增#{humanlize_model_name}"
  end
end
