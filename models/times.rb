require_relative("../db/sql_runner")

class Time
  attr_accessor :time, :film_id
  attr_reader :id

  def initialize(options)
    @scheduled_for = options['scheduled_for']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO times
    (
      scheduled_for,
      film_id
    )
    VALUES
    (
      $1, $2
      ) RETURNING id;"
      values = [@scheduled_for, @film_id]
      result = SqlRunner.run(sql, "save_time", values)
      @id = result[0]['id'].to_i
      return result
    end

    def update()
      sql = "UPDATE times SET
      (
        scheduled_for,
        film_id
        ) = (
          $1, $2
        )
        WHERE id = $3;"
        values = [@scheduled_for, @film_id, @id]
        result = SqlRunner.run(sql, "update_time", values)
      end

      def delete()
        sql = "DELETE FROM times where id = $1"
        values = [@id]
        result = SqlRunner.run(sql, "delete_time", values)
      end


      def self.find(id)
        sql = "SELECT * FROM times; WHERE id = $1"
        values = [id]
        times = SqlRunner.run(sql, "find_times", values)
        result = times.map {|time| Time.new(time)}
        return result
      end

      def self.delete_all()
        sql = "DELETE FROM times;"
        values = []
        result = SqlRunner.run(sql, "delete_all_times", values)
      end

      def self.all()
        sql = "SELECT * FROM times"
        values = []
        times = SqlRunner.run(sql, "find_all_times", values)
        return times.map { |time| Time.new(time) }
      end

      # def self.find_customers_times(id)
      #   sql = "SELECT * FROM times WHERE customer_id = $1"
      #   values = [id]
      #   times = SqlRunner.run(sql, "find_times", values)
      #   result = times.map {|time| Time.new(time)}
      #   return result
      # end


    end
