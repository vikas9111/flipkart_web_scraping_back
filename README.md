# Flipkart Web Scraping Back App

This is the backend application for managing products and categories.

## Setup

### Prerequisites

Make sure you have the following installed:

- Ruby 3.0.0
- Rails 7.1.3.2
- PostgreSQL

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/vikas9111/flipkart_web_scraping_back.git
2. Navigate to the project directory:
   ```bash
   cd flipkart_web_scraping_back
3. Install dependencies:
   ```bash
   bundle install
4. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
5. Seed the database with sample data:
   ```bash
   rails db:seed
# Configuration:
Make sure to configure the database connection in config/database.yml if you want to change.
# Start the Rails server:
  ```bash
  rails s
