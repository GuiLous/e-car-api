user = Fabricate :user
user.wallet.add_coins(1000)

services = []
services << Fabricate(:service, name: 'League of Legends')
services << Fabricate(:service, name: 'Counter Strike')
services << Fabricate(:service, name: 'Valorant')

assistant = Fabricate(:assistant)

services.each do |service|
  Fabricate(:assistant_service, price: rand(100..300), assistant: assistant, service: service)
end

categories = ['LOL', 'CS', 'Valorant']

categories.each do |category|
  Fabricate(:service_category, name: category, type_category: 0)
end

10.times do
  Fabricate(:assistant_submission)
end
