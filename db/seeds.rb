# frozen_string_literal: true

100.times do |n|
  name  = Gimei.kanji
  email = "example-#{n + 1}@example.com"
  password = 'password'
  user = User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password)

  user_id = user.id
  5.times do |c|
    title = "タイトル-#{c + 1}"
    room = Room.create!(user_id: user_id,
                        title: title)

    room_id = room.id.to_s
    content = [{ "name": "タイトル#{c + 1}", "left": false,
                 "children": [{ "name": 'テスト1', "left": false, "children": [{ "name": 'テスト1-1', "left": false }, { "name": 'テスト1-2', "left": false }, { "name": 'テスト1-3', "left": false }] }, { "name": 'テスト2', "left": false, "children": [{ "name": 'テスト2-1', "left": false }, { "name": 'テスト2-2', "left": false }, { "name": 'テスト2-3', "left": false }] }, { "name": 'テスト3', "left": false, "children": [{ "name": 'テスト3-1', "left": false }, { "name": 'テスト3-2', "left": false }, { "name": 'テスト3-3', "left": false }] }, { "name": 'テスト4', "left": false, "children": [{ "name": 'テスト4-1', "left": false }, { "name": 'テスト4-2', "left": false }, { "name": 'テスト4-3', "left": false }] }, { "name": 'テスト5', "left": false, "children": [{ "name": 'テスト5-1', "left": false }, { "name": 'テスト5-2', "left": false }, { "name": 'テスト5-3', "left": false }] }, { "name": 'テスト6', "left": true, "children": [{ "name": 'テスト6-1', "left": true }, { "name": 'テスト6-2', "left": true }, { "name": 'テスト6-3', "left": true }] }, { "name": 'テスト7', "left": true, "children": [{ "name": 'テスト7-1', "left": true }, { "name": 'テスト7-2', "left": true }, { "name": 'テスト7-3', "left": true }] }, { "name": 'テスト8', "left": true, "children": [{ "name": 'テスト8-1', "left": true }, { "name": 'テスト8-2', "left": true }, { "name": 'テスト8-3', "left": true }] }, { "name": 'テスト9', "left": true, "children": [{ "name": 'テスト9-1', "left": true }, { "name": 'テスト9-2', "left": true }, { "name": 'テスト9-3', "left": true }] }, { "name": 'テスト10', "left": true, "children": [{ "name": 'テスト10-1', "left": true }, { "name": 'テスト10-2', "left": true }, { "name": 'テスト10-3', "left": true }] }] }]
    Content.create!(room_id: room_id,
                    content: content)
    next unless c == 1

    title = "#{name}の投稿"
    post = Post.create!(title: title,
                        room_id: room_id,
                        user_id: user_id,
                        kind: Faker::Number.number(digits: 1) + 1)
    3.times do |pc|
      case pc
      when 0
        kind = 'title'
        title = '自己紹介'
        order_num = 1
      when 1
        title = ''
        kind = 'sub_title'
        sub_title = "#{name}と申します。"
        order_num = 2
      when 2
        sub_title = ''
        kind = 'text'
        text = "初めまして、#{name}と申します。これから、よろしくお願い致します。"
        order_num = 3
      end
      PostContent.create!(post_id: post.id,
                          kind: kind,
                          title: title,
                          sub_title: sub_title,
                          text: text,
                          order_num: order_num)
    end
  end
end

100.times do |n|
  user_id = n + 1
  follower_id = Faker::Number.number(digits: 2)

  Follow.create!(user_id: user_id,
                 follower_id: follower_id)

  post_id = Faker::Number.number(digits: 2)
  Like.create!(user_id: user_id,
               post_id: post_id)

  Message.create!(user_id: user_id,
                  post_id: post_id,
                  message: 'いい記事ですね！参考にさせてもらいます。')

  10.times do |c|
    name = "テスト#{c}"
    now = Time.current
    date = Faker::Date.between(from: now.beginning_of_month, to: now.end_of_month)
    if c > 1 && c < 5
      color = 'blue'
    elsif c > 5 && c < 8
      color = 'green'
    elsif c < 8
      color = 'orange'
    elsif c > 1
      color = 'grey'
    end
    Calendar.create!(user_id: user_id,
                     name: name,
                     color: color,
                     start: date,
                     end: date)
  end
end
