namespace :dev do
  task fake: :environment do
    User.destroy_all
    User.create(email: "admin@example.com", password: "12345678", role: "admin", nickname: "Default Admin")
    User.create(email: "morrie@example.com", password: "12345678", role: "admin", nickname: "Default Morrie")
    20.times do |i|
      name = FFaker::Name.first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      User.create!(email: "#{name}@example.com",
        password: "12345678",
        nickname: name ,
        intro: FFaker::Tweet.body,
        image: file
      )
    end
    puts "now you have #{User.count} users data"
  end

  task fake: :environment do
    Post.destroy_all
    300.times do |i|
      Post.create!(title: FFaker::Book.title,
        content: FFaker::Book.description,
        image: FFaker::Image.url,
        post_state: ["publish", "draft"].sample,
        user_id: User.all.pluck(:id).sample,
        post_permission: [1,2,3].sample,
        viewed_num: Random.rand(100)
      )
    end
    puts "now you have #{Post.count} posts data"
  end
  
  task fake: :environment do
    PostCategory.destroy_all
    5.times do |i|
      PostCategory.create!(title: "category#{i.to_s}")
    end
    puts "now you have #{PostCategory.count} post_categories data"
  end

  task fake: :environment do
    JoinPost.destroy_all
    1000.times do |i|
      join_post = JoinPost.new(post_id: Post.published.pluck(:id).sample, post_category_id: PostCategory.all.pluck(:id).sample )
      if JoinPost.find_by(post_id: join_post.post_id, post_category_id: join_post.post_category_id)
        next
      else
        join_post.save
      end
    end
    puts "now you have #{JoinPost.count} join_posts data"
  end

  task fake: :environment do
    Reply.destroy_all
    2000.times do |i|
      Reply.create!(content: FFaker::BaconIpsum.sentence,
        post_id: Post.published.pluck(:id).sample,
        user_id: User.all.pluck(:id).sample
        )
    end
    puts "now you have #{Reply.count} replies data"
  end

  task fake: :environment do
    Friendship.destroy_all
    3000.times do |i|
      users = User.all.pluck(:id).sample(2)
      friend_ship = Friendship.new(user_id: users.first,
        friend_id: users.last,
        friend_state: ["friend", "inviting"].sample,
        )
      if friend_ship.is_uniq?
        friend_ship.save
      else
        next
      end
    end
    puts "now you have #{Friendship.count} friend_ship data"
  end

  task fake: :environment do
    CollectionPost.destroy_all
    3000.times do |i|
      user = User.all.pluck(:id).sample
      post = Post.all.pluck(:id).sample
      collection_post = CollectionPost.new(user_id: user,post_id: post)
      if collection_post.is_uniq?
        collection_post.save
      else
        next
      end
    end
    puts "now you have #{CollectionPost.count} collection_post data"
  end

end