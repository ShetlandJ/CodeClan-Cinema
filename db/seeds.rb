require("pry")
require_relative("../models/customers")
require_relative("../models/films")
require_relative("../models/tickets")
require_relative("../models/times")


Ticket.delete_all()
Time.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'customer_name' => 'James',
  'funds' => 50
  });
  customer1.save()

  customer2 = Customer.new({
    'customer_name' => 'Brian',
    'funds' => 10
    });
    customer2.save()


    customer3 = Customer.new({
      'customer_name' => 'Steph',
      'funds' => 123
      });

      customer3.save()

      film1 = Film.new({
        'title' => 'The Room',
        'cost' => 10
        })

        film1.save()

        film2 = Film.new({
          'title' => 'Interstellar',
          'cost' => 15,
          })

          film2.save()

          film3 = Film.new({
            'title' => 'It\'s a Wonderful Life',
            'cost' => 5,
            })

            film3.save()

            film4 = Film.new({
              'title' => 'The Room',
              'cost' => 10,
              })

              film4.save()

              film5 = Film.new({
                'title' => 'The Room',
                'cost' => 19,
                })

                film5.save()

                film6 = Film.new({
                  'title' => 'Interstellar',
                  'cost' => 15,
                  })

                  film6.save()

                ticket1 = Ticket.new({
                  'customer_id' => customer1.id,
                  'film_id' => film1.id
                  })

                  ticket1.save()

                  ticket2 = Ticket.new({
                    'customer_id' => customer2.id,
                    'film_id' => film2.id
                    })

                    ticket2.save()

                    ticket3 = Ticket.new({
                      'customer_id' => customer3.id,
                      'film_id' => film3.id
                      })

                      ticket3.save()

                      ticket4 = Ticket.new({
                        'customer_id' => customer1.id,
                        'film_id' => film2.id
                        })

                        ticket4.save()
                        #
                        time1 = Time.new({
                          'scheduled_for' => 1730,
                          'film_id' => film3.id
                          })

                          time1.save()

                          time2 = Time.new({
                            'scheduled_for' => 1830,
                            'film_id' => film4.id
                            })

                            time2.save()

                            time3 = Time.new({
                              'scheduled_for' => 1930,
                              'film_id' => film6.id
                              })

                              time3.save()

                              time4 = Time.new({
                                'scheduled_for' => 2030,
                                'film_id' => film1.id
                                })

                                time4.save()

                                time5 = Time.new({
                                  'scheduled_for' => 2130,
                                  'film_id' => film5.id
                                  })

                                  time5.save()

                                  time6 = Time.new({
                                    'scheduled_for' => 2350,
                                    'film_id' => film1.id
                                    })

                                    time6.save()

                        pry.binding
                        nil
