# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "创建两个 admin 账户（默认也是律师），和四个当事人，三个问题。"


User.create([email:"a@lawyer.com",user_name:"孙大律师", password:"111111", password_confirmation:"111111", is_admin:"true", is_lawyer:"true",district:"北京", area:"民事"])
User.create([email:"b@lawyer.com", user_name:"静律师",password:"111111", password_confirmation:"111111", is_admin:"true",is_lawyer:"false",district:"北京", area:"民事"])
User.create([email:"c@lawyer.com",user_name:"梁大锤", password:"111111", password_confirmation:"111111", is_admin:"false",is_lawyer:"true",district:"上海", area:"民事"])
Lawyer.create([user_id: 1])
Lawyer.create([user_id: 3])

puts "3 Admin account created."



 User.create([email:"wendy0821@gmail.com",user_name:"轰轰",password:"111111",password_confirmation:"111111", is_admin:"false",is_lawyer:"true",district:"北京"])
 User.create([email:"eve@client.com",user_name:"Eve",password:"111111",password_confirmation:"111111", is_admin:"false",is_lawyer:"false",district:"北京"])
 User.create([email:"leonychuang@gmail.com",user_name:"歪歪",password:"111111",password_confirmation:"111111", is_admin:"false",is_lawyer:"false",district:"北京"])
 User.create([email:"a@client.com",user_name:"范冰冰",password:"111111",password_confirmation:"111111",is_admin:"false" ])
 User.create([email:"a2@client.com",user_name:"Mike Lee",password:"111111",password_confirmation:"111111",is_admin:"false" ])
puts "5 Users' accounts created."
Question.create!([content:"翻墙是违反国家法律法规的么？",area:"刑事",district:"北京",user_id:7])
Question.create!([content:"当吃瓜群众也需要承担税负么？",area:"民事",district:"深圳",user_id:7])
Question.create!([content:"租房合同上能写只租给北京人么？",area:"民事",district:"北京",user_id:7])
Question.create!([content:"我能找到真爱么？",area:"民事",district:"北京",user_id:7])
Question.create!([content:"我家房子要被政府拆迁了，我真的能实现财富自由么？",area:"经济",district:"北京",user_id:7])
puts "5 questions created!"

 

puts "done!"
