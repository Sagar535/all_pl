require 'csv'

class PLanguagesController < ApplicationController
  before_action :set_p_language, only: [:show, :edit, :update, :destroy]

  # GET /p_languages
  # GET /p_languages.json
  def index
    @p_languages = PLanguage.all
  end

  def upload
    csv_path = File.join Rails.root, 'db', 'languages.csv'
    PLanguageAddWorker.perform_async(csv_path)
    flash[:notice] = "Uploading data"
    redirect_to p_languages_path
  end

  def destroy_all
    PLanguageRemoveWorker.perform_async 
    flash[:notice] = "Deleting all data"
    redirect_to p_languages_path 
  end

  # GET /p_languages/1
  # GET /p_languages/1.json
  def show
  end

  # GET /p_languages/new
  def new
    @p_language = PLanguage.new
  end

  # GET /p_languages/1/edit
  def edit
  end

  # POST /p_languages
  # POST /p_languages.json
  def create
    @p_language = PLanguage.new(p_language_params)

    respond_to do |format|
      if @p_language.save
        format.html { redirect_to @p_language, notice: 'P language was successfully created.' }
        format.json { render :show, status: :created, location: @p_language }
      else
        format.html { render :new }
        format.json { render json: @p_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /p_languages/1
  # PATCH/PUT /p_languages/1.json
  def update
    respond_to do |format|
      if @p_language.update(p_language_params)
        format.html { redirect_to @p_language, notice: 'P language was successfully updated.' }
        format.json { render :show, status: :ok, location: @p_language }
      else
        format.html { render :edit }
        format.json { render json: @p_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /p_languages/1
  # DELETE /p_languages/1.json
  def destroy
    @p_language.destroy
    respond_to do |format|
      format.html { redirect_to p_languages_url, notice: 'P language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_p_language
      @p_language = PLanguage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def p_language_params
      params.require(:p_language).permit(:name, :wiki_link)
    end
end
