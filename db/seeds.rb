# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Comment.destroy_all
Post.destroy_all
User.destroy_all

# Create users
users = User.create!([
  { username: "reddit_user1", email: "user1@example.com" },
  { username: "code_lover", email: "coder@example.com" },
  { username: "tech_guru", email: "guru@example.com" }
])

# Create posts
posts = Post.create!([
  {
    title: "Awesome Ruby Tutorial",
    url: "https://ruby-doc.org",
    body: "Check out this comprehensive Ruby guide",
    user: users[0]
  },
  {
    title: "Rails Best Practices",
    url: "https://guides.rubyonrails.org",
    body: "Essential patterns for Rails development",
    user: users[1]
  },
  {
    title: "JavaScript Fundamentals",
    url: "https://developer.mozilla.org",
    body: "Master the basics of JavaScript",
    user: users[2]
  }
])

# Create comments
Comment.create!([
  {
    body: "This tutorial really helped me understand Ruby better!",
    user: users[1],
    post: posts[0]
  },
  {
    body: "Great resource, bookmarked for future reference.",
    user: users[2],
    post: posts[0]
  },
  {
    body: "I've been following these practices and my code is much cleaner now.",
    user: users[0],
    post: posts[1]
  }
])

puts "Created #{User.count} users, #{Post.count} posts, and #{Comment.count} comments!"
