require_relative("../db/sql_runner")
require_relative("films")
require_relative("times")

class Screening
  attr_accessor :film_id, :scheduled_for, :screen
  attr_reader :id

  def initialize(options)
    @film_id = options['film_id']
    @scheduled_for = options['scheduled_for']
    @screen = options['screen']
  end

  def save()
    sql = "INSERT INTO screenings
    (
      film_id,
      scheduled_for,
      screen
    )
    VALUES (
      $1, $2, $3
      ) RETURNING id;"
      values = [@film_id, @scheduled_for, @screen]
      result = SqlRunner.run(sql, "save_screening", values)
      @id = result[0]['id'].to_i
      return result
    end

    def update()
      sql = "UPDATE screenings SET
      (
        film_id,
        scheduled_for,
        screen
        ) = (
          $1, $2, $3
        )
        WHERE id = $4;"
        values = [@film_id, @scheduled_for, @screen, @id]
        result = SqlRunner.run(sql, "update_screening", values)
      end

      def delete()
        sql = "DELETE FROM screenings where id = $1"
        values = [@id]
        result = SqlRunner.run(sql, "delete_screening", values)
      end


      def self.find(id)
        sql = "SELECT * FROM screenings; WHERE id = $1"
        values = [id]
        screenings = SqlRunner.run(sql, "find_screenings", values)
        result = screenings.map {|screening| Screening.new(screening)}
        return result
      end

      def self.delete_all()
        sql = "DELETE FROM screenings;"
        values = []
        result = SqlRunner.run(sql, "delete_all_screenings", values)
      end

      def self.all()
        sql = "SELECT * FROM screenings"
        values = []
        screenings = SqlRunner.run(sql, "find_all_screenings", values)
        return screenings.map { |screening| Screening.new(screening) }
      end

      # def self.show_all_listings()
      #   sql = "SELECT * FROM screenings WHERE film_id = $1"
      #   values = []
      #   tickets = SqlRunner.run(sql, "find_tickets", values)
      #   result = tickets.map {|ticket| Ticket.new(ticket)}
      #   return result
      # end

      # def self.listings()
      #   sql = "SELECT films.*, times.* FROM films, times
      #   INNER JOIN ON screenings"
      #   values = []
      #   tickets = SqlRunner.run(sql, "show_all_listings", values)
      #   return tickets
      # end

      # def self.listings()
      #   sql = "SELECT tickets.*) FROM tickets INNER JOIN screenings ON tickets.screening_id = screenings.id WHERE screening_id = $1;"
      #   values = [@id]
      #   tickets = SqlRunner.run(sql, "find_how_many_tickets_by_screenings", values)
      #   return tickets
      # end

    end
