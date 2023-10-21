class LectureOrganizerService
  MORNING_SESSION_START   = 9 * 60   # 9:00 AM
  MORNING_SESSION_END     = 12 * 60  # 12:00 PM
  AFTERNOON_SESSION_START = 13 * 60  # 13:00 PM
  AFTERNOON_SESSION_END   = 17 * 60  # 17:00PM
  LUNCH_TIME = "12:00 Almoço\n"
  NETWORKING_EVENT = '17:00 Evento de Networking'

  class << self
    def organize lectures
      return 'No lectures to organize' if lectures.empty?

      # Arranging lectures in ascending order of duration to facilitate allocation with push and pop
      @remaining_lectures = lectures.sort_by(&:duration)

      first_track  = fill_track('A')
      second_track = fill_track('B')

      if @remaining_lectures.empty?
        format_schedule(first_track, second_track)
      else
        'Not all lectures could be allocated within the tracks'
      end
    end

    private

    def fill_track track
      morning_sessions, afternoon_sessions = '', ''
      morning_time, afternoon_time = MORNING_SESSION_START, AFTERNOON_SESSION_START

      # First fill in the morning session and then fill in the afternoon session, if the lecture
      # can't be allocated, we put it back on the stack and break the loop.
      until @remaining_lectures.empty?
        lecture = @remaining_lectures.pop

        if morning_time + lecture.duration <= MORNING_SESSION_END
          morning_sessions += format_lecture(morning_time, lecture)
          morning_time += lecture.duration
        elsif afternoon_time + lecture.duration <= AFTERNOON_SESSION_END
          afternoon_sessions += format_lecture(afternoon_time, lecture)
          afternoon_time += lecture.duration
        else
          @remaining_lectures.push(lecture)
          break
        end
      end

      # We concatenate the complete track string adding the lunch time and the networking event time.
      format_track(track, morning_sessions, afternoon_sessions)
    end

    # The formatting methods are separated to ease the maintenance of the code.
    # If there is a need to make any changes in formatting, this can be done
    # in an isolated manner in each function, without affecting the rest of the code.

    def format_schedule first_track, second_track
      first_track + "\n" + second_track
    end

    def format_track track, morning_sessions, afternoon_sessions
      "Track #{track}:\n" + morning_sessions + LUNCH_TIME + afternoon_sessions + NETWORKING_EVENT
    end

    def format_lecture minutes, lecture
      "#{format_time(minutes)} #{lecture.title} #{lecture.duration}min\n"
    end

    def format_time minutes
      hours = minutes / 60
      minutes %= 60
      format('%02d:%02d', hours, minutes)
    end
  end
end
