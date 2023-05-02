# Ruby Store Application

A modern Ruby on Rails e-commerce store application built with Rails, featuring product management and user authentication.

## Feature

- **Product Management**: Browse, create, edit, and delete products
- **User Authentication**: Secure user registration and login system
- **Session Management**: Track user sessions with IP and user agent
- **Password Reset**: Email-based password recovery
- **Responsive Design**: Mobile-friendly interface
- **Real-time Updates**: Powered by Hotwire (Turbo + Stimulus)

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd store
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Setup the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed  # Optional: Load sample data
   ```

4. **Start the development server**
   ```bash
   rails server
   # Or use the development script for better experience
   ./bin/dev
   ```

5. **Visit the application**
   ```
   http://localhost:3000
   ```

## Development

### Running Tests
```bash
rails test
```

### Code Quality
```bash
bundle exec rubocop  # Run linting
```

### Console
```bash
rails console  # Interactive Ruby console
```

### Database Console
```bash
rails dbconsole  # Direct database access
```

## Models

### Product
- **Attributes**: `name` (string)
- **Validations**: Name presence required

### User
- **Attributes**: `email_address`, `password_digest`
- **Features**: Email normalization, secure password
- **Associations**: Has many sessions

### Session
- **Attributes**: `user_id`, `ip_address`, `user_agent`
- **Purpose**: Track user login sessions

## API Endpoints

- `GET /` - Product listing (root)
- `GET /products` - All products
- `GET /products/:id` - Show product
- `POST /products` - Create product (auth required)
- `PATCH /products/:id` - Update product (auth required)
- `DELETE /products/:id` - Delete product (auth required)
- `GET /session/new` - Login page
- `POST /session` - Create session (login)
- `DELETE /session` - Destroy session (logout)
- `GET /passwords/new` - Password reset request
- `POST /passwords` - Send reset email
- `GET /passwords/:token/edit` - Reset password form
- `PATCH /passwords/:token` - Update password

## Deployment

### Docker

Build and run with Docker:
```bash
docker build -t store .
docker run -p 3000:80 store
```

### Kamal Deployment

1. **Configure deployment**
   - Update `config/deploy.yml` with your server details
   - Set up your domain and SSL certificates

2. **Set environment variables**
   ```bash
   kamal env push RAILS_MASTER_KEY=<your-master-key>
   ```

3. **Initial setup**
   ```bash
   kamal setup
   ```

4. **Deploy**
   ```bash
   kamal deploy
   ```

5. **Useful Kamal commands**
   ```bash
   kamal console    # Rails console on production
   kamal logs       # View application logs
   kamal shell      # SSH into container
   kamal restart    # Restart application
   ```

## Environment Variables

- `RAILS_MASTER_KEY` - Required for production (from `config/master.key`)
- `DATABASE_URL` - Database connection (optional, defaults to SQLite)
- `RAILS_ENV` - Environment (development, test, production)

## Security

- CSRF protection enabled
- Secure password handling with bcrypt
- HTTP-only signed cookies for sessions
- Brakeman security scanning available
- Environment-based secrets management

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
