class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :update, :destroy]

  # GET /developers
  def index
    @developers = Developer.all
    @developers = @developers.where(name: params[:name]) unless params[:name].blank?
    @developers = @developers.where(age: params[:age]) unless params[:age].blank?
    @developers = @developers.page(params[:page]).per(params[:per_page])

    paginate json: @developers
  end

  # GET /developers/1
  def show
    render json: @developer
  end

  # POST /developers
  def create
    @developer = Developer.new(developer_params)

    if @developer.save
      render json: @developer, status: :created, location: @developer
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /developers/1
  def update
    if @developer.update(developer_params)
      render json: @developer
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /developers/1
  def destroy
    @developer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_developer
      @developer = Developer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def developer_params
      params.require(:developer).permit(:name, :age)
    end
end
