module Organizer
  # The LectureOrganizerBacktrackService class is designed to organize a set of lectures into
  # a conference schedule with multiple tracks. Each track has a morning and an afternoon session,
  # and there's a defined start and end time for each session. The goal is to find an optimal
  # schedule that minimizes the unused time in each session.
  #
  # Example Usage:
  #   schedule = LectureOrganizerBacktrackService.organize(lectures)
  #
  class LectureOrganizerBacktrackService
    MORNING_SESSION_START   = 9 * 60   # 9:00 AM
    MORNING_SESSION_END     = 12 * 60  # 12:00 PM
    AFTERNOON_SESSION_START = 13 * 60  # 13:00 PM
    AFTERNOON_SESSION_END   = 17 * 60  # 17:00 PM
    NETWORKING_EVENT_START  = 16 * 60  # 16:00 PM
    MORNING_SESSION_LENGTH   = MORNING_SESSION_END - MORNING_SESSION_START
    AFTERNOON_SESSION_LENGTH = AFTERNOON_SESSION_END - AFTERNOON_SESSION_START
    LUNCH_TIME = "12:00 Almoço\n".freeze
    TRACK_COUNT = 2

    class << self
      # Organizes the given lectures into a conference schedule over multiple tracks.
      def organize(lectures)
        return 'No lectures to organize' if lectures.empty?

        @best_schedule = ''
        track_char_code = 65 # A
        current_schedule = []

        TRACK_COUNT.times do
          # Initializes variables to track the best solution found so far
          @best_track = []
          @best_fitness = Float::INFINITY # Assumes a lower fitness value is better
          backtrack([], lectures, MORNING_SESSION_START, AFTERNOON_SESSION_START, fitness_penalty(@best_track))
          current_schedule, lectures = format_schedule(track_char_code, @best_track, lectures)
          @best_schedule += current_schedule
          track_char_code += 1
        end

        if lectures.empty?
          @best_schedule
        else
          'Not all lectures could be allocated within the tracks'
        end
      end

      private

      # Recursive backtracking method to explore all possible schedules and find the best one.
      def backtrack current_schedule, remaining_lectures, morning_time, afternoon_time, current_fitness
        if current_fitness < @best_fitness
          @best_track = current_schedule.dup
          @best_fitness = current_fitness
        end

        return if remaining_lectures.empty?

        next_lecture = remaining_lectures.pop

        # Tries to allocate in the morning session first
        if morning_time + next_lecture.duration <= MORNING_SESSION_END
          current_schedule.push([:morning, morning_time, next_lecture])
          backtrack(current_schedule,
                    remaining_lectures,
                    morning_time + next_lecture.duration,
                    afternoon_time,
                    fitness_penalty(current_schedule))
          current_schedule.pop # Undoes the choice
        end

        # Tries to allocate in the afternoon session
        if afternoon_time + next_lecture.duration <= AFTERNOON_SESSION_END
          current_schedule.push([:afternoon, afternoon_time, next_lecture])
          backtrack(current_schedule,
                    remaining_lectures,
                    morning_time,
                    afternoon_time + next_lecture.duration,
                    fitness_penalty(current_schedule))
          current_schedule.pop # Undoes the choice
        end

        remaining_lectures.push(next_lecture)
      end

      # Calculates the fitness penalty of the current schedule based on the unused session time.
      def fitness_penalty schedule
        remaining_morning_time   = MORNING_SESSION_LENGTH
        remaining_afternoon_time = AFTERNOON_SESSION_LENGTH

        schedule.each do |session, _time, lecture|
          if session == :morning
            remaining_morning_time -= lecture.duration
          else # session == :afternoon
            remaining_afternoon_time -= lecture.duration
          end
        end

        remaining_morning_time + remaining_afternoon_time
      end

      #
      # The formatting methods are separated to ease the maintenance of the code.
      # If there is a need to make any changes in formatting, this can be done
      # in an isolated manner in each function, without affecting the rest of the code.
      #

      # Formats the schedule for a specific track.
      def format_schedule track_char_code, track, lectures
        organized_track = "Track #{track_char_code.chr}:\n"

        # Sorting by time -> [[:session, time, lecture]]
        track = track.sort_by { |sub_array| sub_array[1] }

        # Split the array into two with a condition
        morning_session, afternoon_session = track.partition { |e| e[0] == :morning }

        morning_session.each do |_, time, lecture|
          organized_track += format_lecture(time, lecture)
          lectures.delete(lecture)
        end

        organized_track += LUNCH_TIME

        afternoon_session.each do |_, time, lecture|
          organized_track += format_lecture(time, lecture)
          lectures.delete(lecture)
        end

        organized_track += format_networking_event(afternoon_session.last)

        return organized_track, lectures
      end

      # Formats a single lecture entry for the schedule.
      def format_lecture minutes, lecture
        "#{format_time(minutes)} #{lecture.title} #{lecture.duration}min\n"
      end

      # Converts minutes to the HH:MM format.
      def format_time minutes
        hours = minutes / 60
        minutes %= 60
        format('%02d:%02d', hours, minutes)
      end

      # Formats the networking event entry for the schedule, ensuring that it starts at or after the
      # defined NETWORKING_EVENT_START time.
      def format_networking_event afternoon_closing
        final_time = afternoon_closing[1]
        lecture = afternoon_closing[2]

        networking_event_start = final_time + lecture.duration

        networking_event_start = NETWORKING_EVENT_START if networking_event_start < NETWORKING_EVENT_START

        "#{format_time(networking_event_start)} Evento de Networking\n"
      end
    end
  end
end
