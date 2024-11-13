user = Fabricate :user
user.wallet.add_coins(1000)

services = []
services << Fabricate(:service, name: 'League of Legends')
services << Fabricate(:service, name: 'Counter Strike')
services << Fabricate(:service, name: 'Valorant')

services.each do |service|
  assistant = Fabricate(:assistant)
  Fabricate(:assistant_service, price: rand(100..300), assistant: assistant, service: service)
end