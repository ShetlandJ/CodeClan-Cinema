require_relative("../db/sql_runner")

class Film
  attr_accessor :title, :cost
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @cost = options['cost']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      cost
    )
    VALUES (
      $1, $2
      ) RETURNING id;"
      values = [@title, @cost]
      result = SqlRunner.run(sql, "save_film", values)
      @id = result[0]['id'].to_i
      return result
    end

    def update()
      sql = "UPDATE films SET
      (
        title,
        cost
        ) = (
          $1, $2
        )
        WHERE id = $3;"
        values = [@title, @cost, @id]
        result = SqlRunner.run(sql, "update_film", values)
      end

      def delete()
        sql = "DELETE FROM films where id = $1"
        values = [@id]
        result = SqlRunner.run(sql, "delete_film", values)
      end


      def self.find(id)
        sql = "SELECT * FROM films; WHERE id = $1"
        values = [id]
        films = SqlRunner.run(sql, "find_film", values)
        result = films.map {|film| Film.new(film)}
        return result
      end

      def self.delete_all()
        sql = "DELETE FROM films;"
        values = []
        result = SqlRunner.run(sql, "delete_all_films", values)
      end

      def self.all()
        sql = "SELECT * FROM films"
        values = []
        films = SqlRunner.run(sql, "find_all_films", values)
        return films.map { |film| Film.new(film) }
      end

      def customers()
        sql = "SELECT customers.* FROM customers
        INNER JOIN tickets ON
        tickets.customer_id = customers.id
        WHERE film_id = $1;"
        values = [@id]
        customers = SqlRunner.run(sql, "find_all_customers_by_film", values)
        return customers.map { |customer| Customer.new( customer ) }
      end

      def customer_count()
        customers().count()
      end

      def self.screenings()
        sql = "SELECT f.*, s.*
        FROM films f JOIN screenings s
        ON f.id = s.film_id"
        values = []
        screenings = SqlRunner.run(sql, "return_listings", values)
        return screenings
        # .map { |screening| Screening.new( screening ) }
      end

      def self.screenings_ordered()
        sql = "SELECT f.*, s.*
        FROM films f JOIN screenings s
        ON f.id = s.film_id
        ORDER BY scheduled_for"
        values = []
        screenings = SqlRunner.run(sql, "return_listings", values)
        return screenings
      end

    end
