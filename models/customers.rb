require_relative("../db/sql_runner")
require_relative("films")

class Customer
  attr_accessor :customer_name, :funds
  attr_reader :id

  def initialize(options)
    @customer_name = options['customer_name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      customer_name,
      funds
    )
    VALUES (
      $1, $2
      ) RETURNING id;"
      values = [@customer_name, @funds]
      result = SqlRunner.run(sql, "save_customer", values)
      @id = result[0]['id'].to_i
      return result
    end

    def update()
      sql = "UPDATE customers SET
      (
        customer_name,
        funds
        ) = (
          $1, $2
        )
        WHERE id = $3;"
        values = [@customer_name, @funds, @id]
        result = SqlRunner.run(sql, "update_customer", values)
      end

      def delete()
        sql = "DELETE FROM customers where id = $1"
        values = [@id]
        result = SqlRunner.run(sql, "delete_customer", values)
      end


      def self.find(id)
        sql = "SELECT * FROM customers; WHERE id = $1"
        values = [id]
        customers = SqlRunner.run(sql, "find_customers", values)
        result = customers.map {|customer| Customer.new(customer)}
        return result
      end

      def self.delete_all()
        sql = "DELETE FROM customers;"
        values = []
        result = SqlRunner.run(sql, "delete_all_customers", values)
      end

      def self.all()
        sql = "SELECT * FROM customers"
        values = []
        customers = SqlRunner.run(sql, "find_all_customers", values)
        return customers.map { |customer| Customer.new(customer) }
      end

      def films()
        sql = "SELECT films.* FROM films
        INNER JOIN tickets ON
        tickets.film_id = films.id
        WHERE customer_id = $1;"
        values = [@id]
        films = SqlRunner.run(sql, "find_all_films_by_customer", values)
        return films.map { |film| Film.new( film ) }
      end

      def deduct_cash(film)
        @funds -= film.cost()
        update()
      end

      def tickets()
        sql = "SELECT count(tickets.*) FROM tickets
        INNER JOIN customers ON
        tickets.customer_id = customers.id
        WHERE customer_id = $1;"
        values = [@id]
        tickets = SqlRunner.run(sql, "find_how_many_tickets_by_customers", values)
        return tickets[0]['count'].to_i
      end



      # def customer_customers(film)
      #   return film.count()
      # end

    end
