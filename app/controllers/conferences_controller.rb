class ConferencesController < ApplicationController
  before_action :set_conference, only: %i[show update destroy organize]

  # GET /conferences
  def index
    @conferences = Conference.all

    render json: @conferences
  end

  # GET /conferences/1
  def show
    render json: @conference
  end

  # POST /conferences
  def create
    @conference = Conference.new(conference_params)

    if @conference.save
      render json: @conference, status: :created, location: @conference
    else
      render json: @conference.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conferences/1
  def update
    if @conference.update(conference_params)
      render json: @conference
    else
      render json: @conference.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conferences/1
  def destroy
    @conference.destroy
  end

  def organize
    uploaded_file = params[:file]

    if uploaded_file.present?
      lectures = process_file(uploaded_file)
      organized_schedule = Organizer::LectureOrganizerBacktrackService.organize(@conference, lectures)
      render json: { schedule: organized_schedule }, status: :ok
    else
      render json: { error: 'Arquivo não fornecido' }, status: :bad_request
    end
  end

  private

  def set_conference
    @conference = Conference.find(params[:id])
  end

  def conference_params
    params.require(:conference).permit(:title, :start_date, :end_date)
  end

  def process_file file
    file_content = file.read.force_encoding('UTF-8')

    lectures = []
    file_content.split("\n").each do |line|
      title, duration = line.match(/(.+) (\d+min|lightning)/).captures
      duration = duration == 'lightning' ? 5 : duration.to_i
      lectures << Lecture.new(title: title, duration: duration)
    end
    lectures
  end
end
