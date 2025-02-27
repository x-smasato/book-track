# Book Track Development Guide

## Common Commands
- **Run server**: `bin/dev` (uses Foreman with Procfile.dev)
- **Run tests**: `bundle exec rspec`
- **Run specific test**: `bundle exec rspec spec/path/to/file_spec.rb:LINE_NUMBER`
- **Run rubocop**: `bin/rubocop` (uses Rails Omakase style)
- **Run slim-lint**: `bin/slim-lint`
- **Security scan**: `bin/brakeman`
- **Build CSS**: `bin/rails tailwindcss:watch`

## Code Style Guidelines
- **Framework**: Ruby on Rails with Ruby 3.4.1, Slim templates, Tailwind CSS
- **Linting**: Follow rubocop-rails-omakase style guide for Ruby
- **Testing**: RSpec with FactoryBot for test data and Shoulda Matchers for validations
- **Error handling**: Use Rails validations for model data, rescue error blocks in controllers
- **Naming**: Follow Rails conventions (models: singular, controllers: plural)
- **Models**: Use explicit validation rules, define CONSTANTS in uppercase, document complex validations
- **Documentation**: Comment non-obvious code and validation rules
- **Database**: Add indexes for frequently queried columns, define explicit foreign key relationships
- **Commits**: Descriptive and concise commit messages in present tense

## Architecture Notes
- ActiveAdmin is used for backend administration
- Devise handles user authentication
- Application uses multi-language support with i18n (en/ja locales)