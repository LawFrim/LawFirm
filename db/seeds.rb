# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "创建一个 admin 账户，和四个当事人，三个问题。"

User.create([email:"a@lawyer.com", password:"111111", password_confirmation:"111111", is_admin:"true", is_lawyer:"true"])
puts "Admin account created."

create_users= for i in 1..3 do
  User.create([email:"user#{i}@client.com",password:"111111",password_confirmation:"111111", is_admin:"false"])
puts "4 Clients created"
end

User.create([email:"a@client.com",password:"111111",password_confirmation:"111111",is_admin:"false" ])
puts "4 Users' accounts created."
Question.create!([content:"翻墙是违反国家法律法规的么？",area:"刑事",district:"北京",user_id:2])
Question.create!([content:"当吃瓜群众也需要承担税负么？",area:"民事",district:"北京",user_id:2])
Question.create!([content:"租房合同上能写只租给北京人么？",area:"民事",district:"北京",user_id:2])
puts "3 questions created!"

puts "done"
