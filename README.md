# Inv-Mng-System

Inventory management system with various functionality from managing product inventory, auditing expense history, tracking sales, chart and card based report etc. Built with **Laravel 12**, **Vue 3**, **MySQL**, **Tailwindcss**

## Description

This system provides a centralized dashboard, Authentication system using laravel Passport, Tracking expense, inventory and sales data.

- **One-to-One Inventory Mapping:** Automated stock record creation upon product entry.
- **Financial Tracking:** Comprehensive logs for both Sales (revenue) and Expenses (investment).
- **Analytics:** Interactive charts for stock movement, inventory distribution, and sales trends.
- **Audit Trail:** Detailed stock history tracking for every 'added' or 'sold' event.

## Requirements

- **PHP:** 8.2 or higher
- **Composer:** Latest version
- **Node.js & npm:** v22.x or higher
- **Database:** MySQL 8.0+

## How to Start

Follow these steps to get your development environment up and running (Backend).

### 1. Clone the Repository

```bash
git clone https://github.com/FrozenDeath111/inv-mng-system.git
cd inv-mng-system
```

### 2. Setup environment

```bash
composer install
cp .env.example .env
php artisan key:generate
php artisan passport:keys
```

set the DB configure in .env file.

```bash
php artisan migrate
php artisan serve
```

Follow these steps to get your development environment up and running (Frontend).
!!!Incase login does not work, there is another path **<backend url>/oauth/token** for token but that require **php artisan passport:client --password** clinet_id and client_secret

```bash
cd frontend
cp .env.example .env
yarn install
yarn dev
```

The application will be accessible at http://localhost:8000(backend) and http://localhost:4000(frontend).

### 3. Workflow

docs folder contains basic working design. frontend might not have every functionality (Filter in product etc) but major and most minor requirements are met to handle inventory management system.

### 4. Finally

Some credentials is open which should not be open for production but to run development environment it is fine.
