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
    NETWORKING_EVENT_START_DEFAULT = 16 * 60 # 16:00 PM
    class << self
      # Organizes the given lectures into a conference schedule over multiple tracks.
      def organize conference, lectures
        return 'No lectures to organize' if lectures.empty?

        @best_schedule = {
          lectures: [],
          networking_event_start: nil
        }
        current_schedule = []
        @last_lecture = nil

        conference.tracks.each do |track|
          # Initializes variables to track the best solution found so far
          @current_track = track
          @best_track = []
          @best_fitness = Float::INFINITY # Assumes a lower fitness value is better
          backtrack([],
                    lectures,
                    @current_track.morning_session_start,
                    @current_track.afternoon_session_start,
                    fitness_penalty(@best_track))
          current_schedule, lectures = fill_schedule(@best_track, lectures)
          @best_schedule[:lectures] << current_schedule
        end

        set_networking_event_start_time

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
        if morning_time + next_lecture.duration <= @current_track.morning_session_end
          current_schedule << [:morning, morning_time, next_lecture]
          backtrack(current_schedule,
                    remaining_lectures,
                    morning_time + next_lecture.duration,
                    afternoon_time,
                    fitness_penalty(current_schedule))
          current_schedule.pop # Undoes the choice
        end

        # Tries to allocate in the afternoon session
        if afternoon_time + next_lecture.duration <= @current_track.afternoon_session_end
          current_schedule << [:afternoon, afternoon_time, next_lecture]
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
        remaining_morning_time = morning_time_length
        remaining_afternoon_time = afternoon_time_length

        schedule.each do |session, _time, lecture|
          if session == :morning
            remaining_morning_time -= lecture.duration
          else # session == :afternoon
            remaining_afternoon_time -= lecture.duration
          end
        end

        remaining_morning_time + remaining_afternoon_time
      end

      # Memoize the calculation of the time for each fitness_penalty to reduce the time of operations
      def morning_time_length
        @morning_time_length ||= @current_track.morning_session_end - @current_track.morning_session_start
      end

      def afternoon_time_length
        @afternoon_time_length ||= @current_track.afternoon_session_end - @current_track.afternoon_session_start
      end

      # Sorts the current schedule and remove all lectures from the remaining lectures
      def fill_schedule current_schedule, lectures
        arr = []

        current_schedule.each do |session, time, lecture|
          arr << Lecture.create(title: lecture.title,
                                duration: lecture.duration,
                                session: session,
                                starting_time: time,
                                track: @current_track)
          lectures.delete(lecture)
        end

        arr = arr.sort_by(&:starting_time)

        @last_lecture = arr.last

        arr = ActiveModelSerializers::SerializableResource.new(
          arr,
          each_serializer: LectureSerializer::SimpleLectureSerializer
        )

        return arr, lectures
      end

      def set_networking_event_start_time
        networking_event_time = @last_lecture.starting_time + @last_lecture.duration

        networking_event_time = NETWORKING_EVENT_START_DEFAULT if networking_event_time < NETWORKING_EVENT_START_DEFAULT

        @best_schedule[:networking_event_start] = networking_event_time
      end
    end
  end
end
