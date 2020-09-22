class Admin::AuditingAdsController < Admin::AppsController
  include Crudable
  include AdHelpers

  before_action only: [:index] do
    @index_title = '待審廣告'
    @index_sub_title = 'Auditing Ads'
  end

  def model_class_name
    'Ad'
  end

  def serializer_class_name
    'AuditingAdSerializer'
  end

  def index_tools
    []
  end

  private

  def current_collection
    default_scope
      .where(status: :pending)
  end

  def filter_columns
    ['name']
  end

end
