Admin.create!(email: 'dev@taller.net.br', password: '123456', password_confirmation: '123456')

assistant_user = Fabricate :user, email: 'assistant@taller.net.br', password: 'Taller@123', role: 1, name: 'Assistant 1'
assistant = Fabricate(:assistant, user: assistant_user, description: 'Subo sua conta até o talo')
consumer = Fabricate :user, email: 'consumer@taller.net.br', password: 'Taller@123', name: 'Consumer 1'
consumer.wallet.add_coins(10000)

# user = Fabricate :user
# user.wallet.add_coins(1000)

services = []
services << Fabricate(:service, name: 'Coach', description: 'Coach professional MIBR')
services << Fabricate(:service, name: 'IGL', description: 'IGL professional LOUD')
services << Fabricate(:service, name: 'IGL', description: 'IGL professional FLUXO')


categories = ['LOL', 'CS', 'Valorant']

assistant_service_titles = ['Coach MIBR', 'IGL LOUD', 'IGL FLUXO']

categories.each_with_index do |category, index|
  service_category = Fabricate(:service_category, name: category, type_category: 0, image_url: 'https://arenaesports.com.br/foto/976x430/cache/wp-content/uploads/2020/05/abrir-todos-os-agentes-no-valorant.jpg')
  Fabricate(:assistant_service, price: rand(100..300), assistant: assistant, service: services[index], service_category: service_category, title: assistant_service_titles[index])
end

# 30.times do
#   Fabricate(:assistant_submission)
# end
