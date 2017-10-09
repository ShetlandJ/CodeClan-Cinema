require("pry")
require_relative("../models/customers")
require_relative("../models/films")
require_relative("../models/tickets")
require_relative("../models/screenings")
require_relative("../models/times")


Ticket.delete_all()
Screening.delete_all()
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
              'title' => 'Minority Report',
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

                  screening1 = Screening.new({
                    'film_id' => film1.id,
                    'scheduled_for' => 1930,
                    'screen' => 1
                    })

                    screening1.save()

                    screening2 = Screening.new({
                      'film_id' => film2.id,
                      'scheduled_for' => 2030,
                      'screen' => 5
                      })

                      screening2.save()

                      screening3 = Screening.new({
                        'film_id' => film3.id,
                        'scheduled_for' => 1230,
                        'screen' => 3
                        })

                        screening3.save()

                        screening4 = Screening.new({
                          'film_id' => film4.id,
                          'scheduled_for' => 2350,
                          'screen' => 2
                          })

                          screening4.save()

                          screening5 = Screening.new({
                            'film_id' => film4.id,
                            'scheduled_for' => 1900,
                            'screen' => 10
                            })

                          screening5.save()

                          ticket1 = Ticket.new({
                            'customer_id' => customer1.id,
                            'screening_id' => screening1.id
                            })

                            ticket1.save()

                            ticket2 = Ticket.new({
                              'customer_id' => customer2.id,
                              'screening_id' => screening2.id
                              })

                              ticket2.save()

                              ticket3 = Ticket.new({
                                'customer_id' => customer3.id,
                                'screening_id' => screening3.id
                                })

                                ticket3.save()

                                ticket4 = Ticket.new({
                                  'customer_id' => customer2.id,
                                  'screening_id' => screening4.id
                                  })

                                  ticket4.save()

                                  ticket5 = Ticket.new({
                                    'customer_id' => customer1.id,
                                    'screening_id' => screening5.id
                                    })

                                    ticket5.save()




                                  pry.binding
                                  nil
