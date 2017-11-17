
namespace :dev do

  desc "Setup de desenvolvimento"
  task setup: :environment do
    images_path = Rails.root.join('public', 'system')
    puts "Iniciando setup desenvolvimento ";
      puts "Apagando banco de dados #{%x(rake db:drop)}"
      puts "Apagando imagens da pasta public/system #{%x(rm -rf #{images_path})} " 
      puts "Criando banco de dados #{%x(rake db:create)}"
      puts %x(rake db:migrate)
      puts %x(rake db:seed)
      puts %x(rake dev:generate_admins)
      puts %x(rake dev:generate_members)
      puts %x(rake dev:generate_ads)      
    puts "Setup desenvolvimento - OK";
  end

  desc "Cria admins fake"
  task generate_admins: :environment do
    puts "Cadastrando Administradores Fake ";
      10.times do
        Admin.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email, 
          role: [0,1].sample,
          password: '123456', 
          password_confirmation: '123456')
      end
    puts "Cadastrando Administradores Fake - OK";
  end

  desc "Cria members fake"
  task generate_members: :environment do
    puts "Cadastrando Membros Fake ";
      100.times do
        Member.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,           
          password: '123456', 
          password_confirmation: '123456')
      end
    puts "Cadastrando Membros Fake - OK";
  end
  
  desc "Cria anúncios fake"
  task generate_ads: :environment do
    puts "Cadastrando Anúncios Fake ";
      
      5.times do
        Ad.create!(
          title: Faker::Lorem.sentence([2,3,4].sample),
          description_short: LeroleroGenerator.paragraph(1),
          description_md: markdown_fake,
          category: Category.all.sample,
          member: Member.first,
          price: "#{Random.rand(500)},#{Random.rand(99)}",
          picture: File.new("#{Rails.root}/public/templates/pictures/#{Random.rand(12)}.jpg", 'r'),
          finish_date: Date.today + Random.rand(90))
      end
    
      100.times do
        Ad.create!(
          title: Faker::Lorem.sentence([2,3,4].sample),
          description_short: LeroleroGenerator.paragraph(1),
          description_md: markdown_fake,
          category: Category.all.sample,
          member: Member.all.sample,
          price: "#{Random.rand(500)},#{Random.rand(99)}",
          picture: File.new("#{Rails.root}/public/templates/pictures/#{Random.rand(12)}.jpg", 'r'),
          finish_date: Date.today + Random.rand(90))
      end
    puts "Cadastrando Anúncios Fake - OK";
  end
  
  def markdown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end

  
end
