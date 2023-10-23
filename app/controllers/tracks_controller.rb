class TracksController < ApplicationController
  before_action :set_track, only: %i[show update destroy]

  # GET /tracks
  def index
    @tracks = Track.all

    render json: @tracks
  end

  # GET /tracks/1
  def show
    render json: @track
  end

  # POST /tracks
  def create
    @track = Track.new(track_params)

    if @track.save
      render json: @track, status: :created, location: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      render json: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/1
  def destroy
    @track.destroy
  end

  private

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:identifier,
                                  :morning_session_start,
                                  :morning_session_end,
                                  :afternoon_session_start,
                                  :afternoon_session_end,
                                  :networking_event_start,
                                  :conference_id)
  end
end
