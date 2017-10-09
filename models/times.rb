require_relative("../db/sql_runner")

class Time
  attr_accessor :time
  attr_reader :id

  def initialize(options)
    @scheduled_for = options['scheduled_for']
  end

  def save()
    sql = "INSERT INTO times
    (
      scheduled_for
    )
    VALUES
    (
      $1
      ) RETURNING id;"
      values = [@scheduled_for]
      result = SqlRunner.run(sql, "save_time", values)
      @id = result[0]['id'].to_i
      return result
    end

    def update()
      sql = "UPDATE times SET
      (
        scheduled_for
        ) = (
          $1
        )
        WHERE id = $2;"
        values = [@scheduled_for, @id]
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




    end
