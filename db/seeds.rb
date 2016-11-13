# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "创建两个 admin 账户，和四个当事人，三个问题。"

User.create([email:"a@lawyer.com", password:"111111", password_confirmation:"111111", is_admin:"true"])
User.create([email:"b@lawyer.com", password:"111111", password_confirmation:"111111", is_admin:"true"])
puts "Admin account created."

create_users= for i in 1..3 do
 User.create([email:"user#{i}@client.com",password:"111111",password_confirmation:"111111", is_admin:"false"])
puts "4 Clients created"
end


User.create([email:"a@client.com",password:"111111",password_confirmation:"111111",is_admin:"false" ])
puts "4 Users' accounts created."





Question.create!([content:"翻墙是违反国家法律法规的么？",area:"刑事",district:"北京",user_id:3])
Question.create!([content:"当吃瓜群众也需要承担税负么？",area:"民事",district:"深圳",user_id:3])
Question.create!([content:"租房合同上能写只租给北京人么？",area:"民事",district:"上海",user_id:3])
Question.create!([content:"我能找到真爱么？",area:"民事",district:"北京",user_id:4])
Question.create!([content:"我家房子要被政府拆迁了，我真的能实现财富自由么？",area:"经济",district:"北京",user_id:4])
puts "5 questions created!"

Conversation.create!([question_id:1,lawyer_id:1,client_id:2])
Conversation.create!([question_id:2,lawyer_id:1,client_id:2])
Conversation.create!([question_id:3,lawyer_id:1,client_id:2])
Conversation.create!([question_id:4,lawyer_id:1,client_id:4])
Conversation.create!([question_id:5,lawyer_id:1,client_id:4])
puts "5个对话建立"



Answer.create!([content:"我觉得你问错人了，你还是申请退钱把。",user_id:1,conversation_id:1])
Answer.create!([content:"纳税光荣，敛财于民，敛财为国",user_id:1,conversation_id:2])
Answer.create!([content:"我觉得你说的是租房广告，不是合同。广告上最好也不要写，心理暗地这么想就好了",user_id:1,conversation_id:3])
Answer.create!([content:"放低性别要求还是可能的",user_id:1,conversation_id:4])
Answer.create!([content:"恩，你就要成为土豪了。我们非常荣幸为您提供法律服务",user_id:1,conversation_id:5])
puts "5 answers created!"
puts "done!"
