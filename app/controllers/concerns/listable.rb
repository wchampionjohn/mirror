module Listable
  extend ::ActiveSupport::Concern

  include Filterable

  def pagination records
    {
      pagination: {
        per_page: per_page,
        current_page: records.current_page,
        total_pages: records.total_pages,
        total_count: records.total_count
      }
    }
  end

  def per_page
    params[:per_page] || 10
  end

  def sorting_name
     params[:sorting_name].present? ? params[:sorting_name] : default_sorting_name
  end

  def default_sorting_name
    'id'
  end

  def sorting_taxis
     params[:sorting_taxis].present? ? params[:sorting_taxis] : default_sorting_taxis
  end

  def default_sorting_taxis
    'DESC'
  end

  def keyword
    params[:q] || {}
  end
end
