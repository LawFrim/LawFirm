# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "创建两个 admin 账户（默认也是律师），和四个当事人，三个问题。"


User.create([email:"a@lawyer.com", password:"111111", password_confirmation:"111111", is_admin:"true", is_lawyer:"true",district:"北京", area:"刑事"])
User.create([email:"c@lawyer.com", password:"111111", password_confirmation:"111111", is_admin:"true",is_lawyer:"true",district:"上海", area:"经济"])

puts "2 Admin account created."


create_users= for i in 1..3 do
 User.create([email:"user#{i}@client.com",password:"111111",password_confirmation:"111111", is_admin:"false"])
puts "4 Clients created"
end

User.create([email:"a@client.com",password:"111111",password_confirmation:"111111",is_admin:"false" ])
puts "4 Users' accounts created."
Question.create!([content:"翻墙是违反国家法律法规的么？",area:"刑事",district:"北京",user_id:5])
Question.create!([content:"当吃瓜群众也需要承担税负么？",area:"民事",district:"深圳",user_id:5])
Question.create!([content:"租房合同上能写只租给北京人么？",area:"民事",district:"上海",user_id:5])
Question.create!([content:"我能找到真爱么？",area:"民事",district:"北京",user_id:4])
Question.create!([content:"我家房子要被政府拆迁了，我真的能实现财富自由么？",area:"经济",district:"北京",user_id:4])
puts "5 questions created!"

Answer.create!([content:"我觉得你问错人了，你还是申请退钱把。",question_id:1,user_id:1])
Answer.create!([content:"纳税光荣，敛财于民，敛财为国",question_id:2,user_id:1])
Answer.create!([content:"我觉得你说的是租房广告，不是合同。广告上最好也不要写，心理暗地这么想就好了",question_id:3,user_id:1])
Answer.create!([content:"你注定终身孤独。",question_id:4,user_id:1])
Answer.create!([content:"恩，你就要成为土豪了。我们非常荣幸为您提供法律服务",question_id:5,user_id:1])
puts "5 answers created!"

Document.create!([description:"请问这份抢注黄喵的商标注册书合理合法么？",user_id:5])
Document.create!([description:"我岳父给我的婚前协议书能不能稍微修改下，让我离婚后能够平分财产？",user_id:5])
Document.create!([description:"这份遗嘱能确保我的巨额遗产不留给我不孝儿女，而是留给照顾我的保姆么？",user_id:5])
puts "5 documents offer created!"
puts "done!"
