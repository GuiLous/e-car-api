services = []
services << Fabricate(:service, name: 'League of Legends')
services << Fabricate(:service, name: 'Counter Strike')
services << Fabricate(:service, name: 'Valorant')


services.each do |service|
  times = rand(1..3)

  times.times do
    user = Fabricate(:user, description: Faker::Lorem.sentence, role: :assistant)
    Fabricate(:user_service, price: rand(100..300), user: user, service: service)
  end
end