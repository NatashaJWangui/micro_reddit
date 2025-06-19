# Micro-Reddit

A lightweight Reddit clone built with Ruby on Rails, focusing on data modeling, associations, and ActiveRecord fundamentals. This project demonstrates the core functionality of a social platform where users can submit links and comment on them.

## Features

- **User Management**: User registration with username and email validation
- **Link Submission**: Users can submit posts with titles, URLs, and descriptions
- **Commenting System**: Users can comment on posts (single-level commenting)
- **Data Associations**: Proper relationships between users, posts, and comments
- **Validation Layer**: Comprehensive data validation for all models

## Technologies Used

- **Ruby**: 3.4.4
- **Rails**: 8.0.2
- **Database**: SQLite3 (development)
- **ActiveRecord**: For ORM and associations
- **Rails Console**: For testing and data manipulation

## Data Models

### User Model
```ruby
# Attributes
- username: string (3-20 characters, unique, required)
- email: string (valid email format, unique, required)
- created_at: datetime
- updated_at: datetime

# Associations
- has_many :posts
- has_many :comments

# Validations
- Username: presence, uniqueness, length (3-20 chars)
- Email: presence, uniqueness, valid format
```

### Post Model
```ruby
# Attributes
- title: string (5-300 characters, required)
- url: string (valid HTTP/HTTPS URL, required)
- body: text (optional description)
- user_id: integer (foreign key, required)
- created_at: datetime
- updated_at: datetime

# Associations
- belongs_to :user
- has_many :comments

# Validations
- Title: presence, length (5-300 chars)
- URL: presence, valid HTTP/HTTPS format
- User: must exist (foreign key constraint)
```

### Comment Model
```ruby
# Attributes
- body: text (1-10000 characters, required)
- user_id: integer (foreign key, required)
- post_id: integer (foreign key, required)
- created_at: datetime
- updated_at: datetime

# Associations
- belongs_to :user
- belongs_to :post

# Validations
- Body: presence, length (1-10000 chars)
- User: must exist (foreign key constraint)
- Post: must exist (foreign key constraint)
```

## Database Schema

```
Users Table:
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | integer     | NO   | PRI | NULL    | auto_increment |
| username   | varchar     | NO   | UNI | NULL    |                |
| email      | varchar     | NO   | UNI | NULL    |                |
| created_at | datetime    | NO   |     | NULL    |                |
| updated_at | datetime    | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

Posts Table:
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | integer     | NO   | PRI | NULL    | auto_increment |
| title      | varchar     | NO   |     | NULL    |                |
| url        | varchar     | NO   |     | NULL    |                |
| body       | text        | YES  |     | NULL    |                |
| user_id    | integer     | NO   | MUL | NULL    |                |
| created_at | datetime    | NO   |     | NULL    |                |
| updated_at | datetime    | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

Comments Table:
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | integer     | NO   | PRI | NULL    | auto_increment |
| body       | text        | NO   |     | NULL    |                |
| user_id    | integer     | NO   | MUL | NULL    |                |
| post_id    | integer     | NO   | MUL | NULL    |                |
| created_at | datetime    | NO   |     | NULL    |                |
| updated_at | datetime    | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
```

## Installation

### Prerequisites
- Ruby 3.0 or higher
- Rails 7.0 or higher
- SQLite3
- Git

### Setup
1. **Clone the repository**
   ```bash
   git clone https://github.com/NatashaJWangui/micro_reddit.git
   cd micro-reddit
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rails db:migrate
   rails db:seed  # Optional: loads sample data
   ```

4. **Start the Rails console**
   ```bash
   rails console
   ```

## Usage (Rails Console)

Since this project focuses on data modeling rather than web interface, all interaction happens through the Rails console.

### Creating Users
```ruby
# Create a new user
user = User.create(username: "john_doe", email: "john@example.com")

# Validate before saving
user = User.new(username: "jane", email: "jane@example.com")
user.valid?  # Returns true/false
user.save    # Saves if valid
```

### Creating Posts
```ruby
# Create post directly
post = Post.create(
  title: "Awesome Ruby Tutorial",
  url: "https://ruby-doc.org",
  body: "Great resource for learning Ruby",
  user: user
)

# Create post through user association
post = user.posts.create(
  title: "Rails Guide",
  url: "https://guides.rubyonrails.org"
)
```

### Creating Comments
```ruby
# Create comment directly
comment = Comment.create(
  body: "Great post! Very helpful.",
  user: commenting_user,
  post: post
)

# Create comment through associations
comment = user.comments.create(body: "Nice article!", post: post)
comment = post.comments.create(body: "Thanks for sharing!", user: user)
```

### Querying Data
```ruby
# Find user's posts
User.find_by(username: "john_doe").posts

# Find post's comments
Post.first.comments

# Find comment's author and post
comment = Comment.first
comment.user     # Returns the user who wrote the comment
comment.post     # Returns the post being commented on

# Complex queries
User.joins(:posts).where(posts: { title: "Ruby Tutorial" })
Post.includes(:comments, :user).where(users: { username: "john_doe" })
```

## Sample Data

The project includes seed data with:
- 3 sample users
- 3 sample posts
- 3 sample comments

Load sample data with:
```bash
rails db:seed
```

## Testing

### Manual Testing Checklist
- [ ] Can create valid users
- [ ] Cannot create users with invalid data
- [ ] Can create posts associated with users
- [ ] Cannot create posts without required fields
- [ ] Can create comments on posts
- [ ] All associations work bidirectionally
- [ ] Validations prevent invalid data

### Console Testing Examples
```ruby
# Test user validations
invalid_user = User.new
invalid_user.valid?  # Should be false
invalid_user.errors.full_messages  # Shows validation errors

# Test associations
user = User.first
user.posts.count    # Number of posts by user
user.comments.count # Number of comments by user

post = Post.first
post.user.username  # Author of the post
post.comments.map(&:body)  # All comment bodies for the post
```

## Project Structure

```
micro-reddit/
├── app/
│   └── models/
│       ├── user.rb          # User model with validations
│       ├── post.rb          # Post model with validations
│       └── comment.rb       # Comment model with validations
├── db/
│   ├── migrate/             # Database migrations
│   │   ├── create_users.rb
│   │   ├── create_posts.rb
│   │   └── create_comments.rb
│   └── seeds.rb             # Sample data
├── config/
│   └── routes.rb            # (Basic Rails routes)
└── README.md
```

## Key Learning Concepts

### ActiveRecord Associations
- **has_many**: One-to-many relationships (User has many Posts)
- **belongs_to**: Foreign key relationships (Post belongs to User)
- **Association methods**: Building records through associations

### Data Validations
- **Presence**: Required fields
- **Uniqueness**: No duplicate values
- **Length**: String/text length constraints
- **Format**: Email and URL format validation
- **Custom validation messages**

### Rails Console Skills
- Model creation and validation testing
- Association navigation
- Database querying with ActiveRecord
- Debugging with error messages

### Database Design
- Primary and foreign keys
- Referential integrity
- Normalization principles
- Migration management

## Common Issues & Troubleshooting

### Validation Errors
```ruby
# Check what validations failed
model.valid?
model.errors.full_messages
```

### Association Issues
```ruby
# Ensure foreign keys are set correctly
post.user_id  # Should have a value
comment.user_id && comment.post_id  # Both should exist
```

### Console Problems
```ruby
# Reload models after changes
reload!

# Exit and restart console if reload doesn't work
exit
rails console
```

### Database Issues
```ruby
# Reset database if needed
rails db:drop db:create db:migrate db:seed
```

## Future Enhancements

Potential features to add:
- User authentication and sessions
- Nested comments (comments on comments)
- Post voting/ranking system
- User profiles and avatars
- Post categories/subreddits
- Search functionality
- Web interface with controllers and views

## Contributing

1. Fork the project
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Resources

- [Rails Guides - Active Record Associations](https://guides.rubyonrails.org/association_basics.html)
- [Rails Guides - Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html)
- [Rails API Documentation](https://api.rubyonrails.org/)
- [The Odin Project](https://www.theodinproject.com/)

## License

This project is for educational purposes.

## Acknowledgments

- The Odin Project for the excellent curriculum and project structure
- Ruby on Rails community for comprehensive documentation
- All contributors to the Rails framework

---

**Project completed as part of The Odin Project - Ruby on Rails Course**

