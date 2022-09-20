# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'admin@admin',
   password: 'adminadmin'
)

users = User.create!(
  [
    {last_name: '倉井部', first_name: '太郎', last_name_kana: 'クライベ', first_name_kana: 'タロウ', employee_id: '0101', affiliation: 'クラウド部', body: '盛り上げていきましょう！', delete_status: 'false', email: 'a@example.com', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user1.jpg"), filename:"user1.jpg")},
    {last_name: '令和', first_name: '道子', last_name_kana: 'レイワ', first_name_kana: 'ミチコ', employee_id: '4321', affiliation: 'イベント部', body: '2022年度入社です', delete_status: 'false', email: 'b@example.com', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user2.jpg"), filename:"user2.jpg")},
    {last_name: '昭和', first_name: 'ヒロシ', last_name_kana: 'ショウワ', first_name_kana: 'ヒロシ', employee_id: '0222', affiliation: '総務部', body: 'たまに参加します', delete_status: 'true', email: 'c@example.com', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user3.jpg"), filename:"user3.jpg")},
    {last_name: '平成', first_name: '一郎', last_name_kana: 'ヘイセイ', first_name_kana: 'イチロー', employee_id: '0001', affiliation: '総務部', body: 'たまに参加します', delete_status: 'false', email: 'd@example.com', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user3.jpg"), filename:"user3.jpg")}
  ]
)

genres = Genre.create!(
  [
    {name: '飲み会', genre_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/genre1.jpeg"), filename:"genre1.jpeg") },
    {name: 'ゲーム', genre_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/genre2.jpeg"), filename:"genre2.jpeg") },
    {name: 'バスケ', genre_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/genre3.jpeg"), filename:"genre3.jpeg") }
  ]
)

events = Event.create!(
  [
    {name: 'ビアガーデン', body: 'テラス席で解放感を味わいましょう！', date: '2022-09-21', start_at: '19:00:00', end_at: '21:00:00', location: '新宿', cost: '約5、000円', recruit: '2', user_id: users[1].id , genre_id: genres[0].id },
    {name: 'ビアガーデン', body: 'テラス席で解放感を味わいましょう！', date: '2022-09-26', start_at: '19:00:00', end_at: '21:00:00', location: '渋谷', cost: '約5、000円', recruit: '2', user_id: users[0].id , genre_id: genres[0].id },
    {name: 'ビアガーデン', body: 'テラス席で解放感を味わいましょう！', date: '2022-10-21', start_at: '19:00:00', end_at: '21:00:00', location: '六本木', cost: '約5、000円', recruit: '4', user_id: users[0].id , genre_id: genres[0].id },
    {name: 'スプラトゥーン3', body: '初心者ですがまったり楽しみましょう！', date: '2022-09-22', start_at: '19:00:00', end_at: '22:00:00', location: 'オンライン', cost: 'なし', recruit: '4', user_id: users[1].id , genre_id: genres[1].id },
    {name: 'スプラトゥーン3', body: '初心者ですがまったり楽しみましょう！', date: '2022-09-25', start_at: '19:00:00', end_at: '22:00:00', location: 'オンライン', cost: 'なし', recruit: '4', user_id: users[1].id , genre_id: genres[1].id },
    {name: 'バスケ', body: 'ゲーム形式メインです。', date: '2022-09-27', start_at: '13:00:00', end_at: '17:00:00', location: '文京体育センター', cost: '1,000円/人', recruit: '6', user_id: users[3].id , genre_id: genres[2].id },
    {name: 'バスケ', body: 'ゲーム形式メインです。', date: '2022-09-13', start_at: '13:00:00', end_at: '17:00:00', location: '赤羽スタジアム', cost: '1,000円/人', recruit: '10', user_id: users[2].id , genre_id: genres[2].id },
    {name: 'バスケ', body: 'ゲーム形式メインです。', date: '2022-09-30', start_at: '13:00:00', end_at: '17:00:00', location: '渋谷スーパーアリーナ', cost: '1,000円/人', recruit: '10', user_id: users[3].id , genre_id: genres[2].id }
  ]
)

Join.create!(
  [
    {user_id: users[0].id , event_id: events[0].id },
    {user_id: users[0].id , event_id: events[1].id },
    {user_id: users[0].id , event_id: events[2].id },
    {user_id: users[0].id , event_id: events[3].id },
    {user_id: users[0].id , event_id: events[4].id },
    {user_id: users[0].id , event_id: events[5].id },
    {user_id: users[0].id , event_id: events[6].id },
    {user_id: users[0].id , event_id: events[7].id },
    {user_id: users[1].id , event_id: events[0].id },
    {user_id: users[1].id , event_id: events[2].id },
    {user_id: users[1].id , event_id: events[4].id },
    {user_id: users[1].id , event_id: events[5].id },
    {user_id: users[1].id , event_id: events[6].id },
    {user_id: users[1].id , event_id: events[7].id },
    {user_id: users[3].id , event_id: events[2].id }
  ]
)

Comment.create!(
  [
    {comment: '晴れろー！', user_id: users[0].id , event_id: events[0].id },
    {comment: '晴れろー！', user_id: users[0].id , event_id: events[1].id },
    {comment: '晴れろー！', user_id: users[0].id , event_id: events[2].id },
    {comment: '楽しみましょう♪', user_id: users[0].id , event_id: events[3].id },
    {comment: 'いい企画！', user_id: users[0].id , event_id: events[4].id },
    {comment: '久しぶりに動きます', user_id: users[0].id , event_id: events[5].id },
    {comment: '運動不足解消♪', user_id: users[0].id , event_id: events[6].id },
    {comment: '楽しみです♪', user_id: users[0].id , event_id: events[7].id },
    {comment: '晴れろー！！', user_id: users[1].id , event_id: events[0].id },
    {comment: '晴れろー！！', user_id: users[1].id , event_id: events[2].id },
    {comment: '練習練習！', user_id: users[1].id , event_id: events[4].id },
    {comment: '試合したいですね', user_id: users[1].id , event_id: events[5].id },
    {comment: 'NBA見てテンション爆上げ', user_id: users[1].id , event_id: events[6].id },
    {comment: 'アップもしたいです', user_id: users[1].id , event_id: events[7].id },
    {comment: 'NBAAAAAAAA', user_id: users[3].id , event_id: events[7].id }
  ]
)