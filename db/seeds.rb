# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(
# 	nickname:'nino',
# 	email: 'ninoko1995@yahoo.co.jp',
# 	password: 'ninoninomiyamiya1995',
# 	introduction: '管理者アカウントです',
# 	spoiler_prevention: false
# 	)



Reading.create(
    user_id: 1
    book_id: 3
    reading_status: 1
    readed_status: false
	)

Reading.create(
    user_id: 1
    book_id: 4
    reading_status: 1
    readed_status: false
	)