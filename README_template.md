# Rails CRUD API Template

## Overview

This is a minimal Ruby on Rails API template used to:
* practice CRUD operations, 
* RESTful API design, 
* data transformations, and 
* debugging workflows.

It is intentionally lightweight to support fast iteration and practice.

---

## Tech Stack

* Ruby
* Ruby on Rails (API-only mode)
* PostgreSQL (already 'rails db:create + rails db:migrate')
* RSpec (testing)
* RuboCop (linting)
* SimpleCov (test coverage)

---

## Purpose

This template is used to practice core backend engineering patterns:

* CRUD API development (create, read, update, delete)
* RESTful routing and controller design
* Data filtering and transformation logic
* Writing and debugging tests
* Simulating real-world backend tasks

---

## Setup

```bash id="q8m1xv"
bundle install
rails db:create
rails db:migrate
rails server
```

---

## Testing

```bash id="t4k9lz"
bundle exec rspec
```

---

## Linting

```bash id="w2p7qa"
bundle exec rubocop
```

---

## Example Endpoints (practice targets)

* POST /users
* GET /users/:id
* PATCH /users/:id
* DELETE /users/:id
* GET /users?status=active (filtering)

---

## Notes

This project is intentionally minimal. 
Features addition incrementally to focus on understanding core backend patterns rather than framework complexity.
