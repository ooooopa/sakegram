class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.order(id: :desc)
    @user = User.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    if params[:back]
        @picture = Picture.new(picture_params)
        if params[:cache][:image] != ""        
          @picture.image.retrieve_from_cache! params[:cache][:image]
        end
    else
        @picture = Picture.new
    end    
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id

    if @picture.save
      ContactMailer.contact_mail(@picture).deliver
      redirect_to  pictures_path      
    else
      render "new"
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    if @picture.update(picture_params)
        redirect_to pictures_path, notice: "編集が成功しました"
    else
        render "edit"
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
      redirect_to pictures_path, notice: "削除が成功しました"   
  end
  
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render "new" if @picture.invalid?
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:image, :description, :image_cache)
    end

end
