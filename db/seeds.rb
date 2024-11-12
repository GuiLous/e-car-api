services = []
services << Fabricate(:service, name: 'League of Legends')
services << Fabricate(:service, name: 'Counter Strike')
services << Fabricate(:service, name: 'Valorant')

services.each do |service|
  times = rand(1..3)

  times.times do
    assistant = Fabricate(:assistant)
    Fabricate(:assistant_service, price: rand(100..300), assistant: assistant, service: service)
  end
end