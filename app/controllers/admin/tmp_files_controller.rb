class Admin::TmpFilesController < ApplicationController
  def create
    object = TmpFile.find_or_create_by code: params[:code], column: params[:file_type]

    if object.update_attributes(
        file: params[:file],
        size: File.size(params[:file].path),
        column: params[:file_type],
        md5: Digest::MD5.hexdigest(params[:file].read)
    )
      json_object = object.info
      req_status = :ok
    else
      json_object = { errors: object.errors.full_messages.last }
      req_status = :unprocessable_entity
    end

    render json: json_object, status: req_status
  end
end
