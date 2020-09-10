class Admin::Stores::IntroductionsController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:create, :destroy]

  def index
    store = Store.find params[:store_id]
    introductions = store.introductions

    serialized_introductions = Store::IntrodutionSerializer.new(introductions).serializable_hash
    serialized_introductions[:data].map! { |hash| hash[:attributes] }

    render json: serialized_introductions.to_json, status: :ok
  end

  def create
    store = Store.find params[:store_id]

    introduction = Store::Introduction.new(
      store: Store.find(params[:store_id]),
      attachment: params[:file],
      menu_type: params[:type]
    )


    if introduction.save
      serialized_introduction = Store::IntrodutionSerializer.new(introduction).serializable_hash
      render json: serialized_introduction[:data][:attributes].to_json, status: :ok
    else
      render json: { errors: introduction.errors.full_messages.last }, status: :unprocessable_entity
    end
  end

  def destroy
    store = Store.find params[:store_id]
    introduction = store.introductions.find params[:id]
    introduction.destroy!

    render json: {}, status: :ok
  end
end
