# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Cadastrando CATEGORIAS ";
categories = ["Animais e acessórios",
              "Esportes",
              "Para a sua casa",
              "Eletrônicos e celulares",
              "Música e hobbies",
              "Bebês e crianças",
              "Moda e beleza",
              "Veículos e barcos",
              "Imóveis",
              "Empregos e negócios"];

categories.each do |cat|
  Category.find_or_create_by(description: cat);
end
puts "Cadastrando CATEGORIAS - OK";

##############################################

puts "Cadastrando Administrador Padrão ";
  Admin.create!(name:'Administrador Padrão', email: 'admin@admin.com', role: 0, password: '123456', password_confirmation: '123456')
puts "Cadastrando Administrador Padrão - OK";

puts "Cadastrando Membro Padrão ";  
  member = Member.new(          
          email: 'member@member.com',           
          password: '123456', 
          password_confirmation: '123456')
        member.build_profile_menber
        member.profile_menber.first_name = Faker::Name.first_name
        member.profile_menber.last_name = Faker::Name.last_name
        member.save!
puts "Cadastrando Membro Padrão - OK";