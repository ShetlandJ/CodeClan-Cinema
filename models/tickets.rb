require_relative("../db/sql_runner")

class Ticket
  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(options)
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES (
      $1, $2
      ) RETURNING id;"
      values = [@customer_id, @film_id]
      result = SqlRunner.run(sql, "save_ticket", values)
      @id = result[0]['id'].to_i
      return result
    end

    def update()
      sql = "UPDATE tickets SET
      (
        customer_id,
        film_id
        ) = (
          $1, $2
        )
        WHERE id = $3;"
        values = [@customer_id, @film_id, @id]
        result = SqlRunner.run(sql, "update_ticket", values)
      end

      def delete()
        sql = "DELETE FROM tickets where id = $1"
        values = [@id]
        result = SqlRunner.run(sql, "delete_ticket", values)
      end


      def self.find(id)
        sql = "SELECT * FROM tickets; WHERE id = $1"
        values = [id]
        tickets = SqlRunner.run(sql, "find_tickets", values)
        result = tickets.map {|ticket| Ticket.new(ticket)}
        return result
      end

      def self.delete_all()
        sql = "DELETE FROM tickets;"
        values = []
        result = SqlRunner.run(sql, "delete_all_tickets", values)
      end

      def self.all()
        sql = "SELECT * FROM tickets"
        values = []
        tickets = SqlRunner.run(sql, "find_all_tickets", values)
        return tickets.map { |ticket| Ticket.new(ticket) }
      end

      def self.find_customers_tickets(id)
        sql = "SELECT * FROM tickets WHERE customer_id = $1"
        values = [id]
        tickets = SqlRunner.run(sql, "find_tickets", values)
        result = tickets.map {|ticket| Ticket.new(ticket)}
        return result
      end


    end
