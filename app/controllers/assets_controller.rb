class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml

  def index
    @assets = current_user.assets
    respond_with(@assets)
  end

  def show
    respond_with(@asset)
  end

  def new
    @asset = current_user.assets.new
    respond_with(@asset)
  end

  def edit
  end

  def create
    @asset = current_user.assets.new(asset_params)
    @asset.save
    respond_with(@asset)
  end

  def update
    @asset.update(asset_params)
    respond_with(@asset)
  end

  def get
    @asset = current_user.assets.find_by_id(params[:id])
    if @asset
      send_file @asset.uploaded_file.path, :type => @asset.uploaded_file_content_type
    else
      flash[:alert] = "Dont be cheeky"
      redirect_to assets_path
      #format.html { redirect_to assets_path, notice: 'Widget was successfully created.' }
    end
  end

  def destroy
    @asset.destroy
    respond_with(@asset)
  end

  private
    def set_asset
      @asset = current_user.assets.find(params[:id])
    end

    def asset_params
      params.require(:asset).permit(:user_id, :uploaded_file)
    end
end