class GymClassesController < ApplicationController

  # GET /gym_classes
  def index
    @gym_classes = GymClass.all
  end

  # GET /gym_classes/1
  def show
  end

  # GET /gym_classes/new
  def new
    @gym_class = GymClass.new
  end

  # GET /gym_classes/1/edit
  def edit
  end

  # POST /gym_classes
  def create
  end

  # PATCH/PUT /gym_classes/1 
  def update
  end

  # DELETE /gym_classes/1
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym_class
      @gym_class = GymClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gym_class_params
      params.fetch(:gym_class, {})
    end
end
