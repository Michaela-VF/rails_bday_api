# About
User model takes a `name` and `date of birth`.

## Task: implement three methods in user model:

1. `User#birthday?` - returns a Boolean for whether today is their birthday
2. `User#age` - returns an integer representing the user’s age in years
3. `User#next_birthday` - returns the date of the user’s next birthday

# MVF: IDEATION PLANNING (BRAINSTORMING - STEPS)
1. OK - Use CRUD api rails template - OK
2. 0K - create model and manually test as you go in irb and write comments/short assumptions as you go (e.g pseudocode) - OK
3. OK - !!! DANGER ZONE 29/2, 2000. - OK
4. OK - Migrate - null
5. OK - Validate 
6. OK - Leave assumptions, explanations
7. OK - TEST manually edge cases
8. OK - Add controller
    8. 1.  OK - expose domain methods

9. OK - Add routes
    9. 1.  OK - Add CRUD routes 
    9. 2.  OK - custom routes to expose domain methods
10. ... - maybe add service?-TBC
---

# MANUAL TESTING:
# 1.1 Create a user id:1
curl -X POST http://127.0.0.1:3000/users -H "Content-Type: application/json" -d '{"user": {"name": "Mickie Mouse", "dob": "1928-11-08" }}'

# 1.2 Create a user id:2
curl -X POST http://127.0.0.1:3000/users \
  -H "Content-Type: application/json" \
  -d '{"user":{"name":"Sophia","dob":"2000-05-10"}}'

# 1.3 Create a user id:3
curl -X POST http://127.0.0.1:3000/users -H "Content-Type: application/json" -d '{"user": {"name": "Mickie Fake", "dob": "1894-06-06" }}'

# 1.4. Future BOD user
curl -X POST http://127.0.0.1:3000/users \
  -H "Content-Type: application/json" \
  -d '{"user":{"name":"Future Baby","dob":"2050-01-01"}}'
  # -> in the curl terminal-> "errors": ["Dob must be less than or equal to 2026-06-06"]
  # -> in the server terminal-> HTTP: 422 Unprocessable Entity
  
# 1.5 Blank dob
curl -X POST http://127.0.0.1:3000/users \
-H "Content-Type: application/json" \
-d '{"user":{"name":"No DOB","dob":""}}'
# -> "errors": ["Dob can't be blank"]


# 2. BIRTHDAY:
curl "http://127.0.0.1:3000/users/3/birthday?date=2026-06-06"
# -> true 

curl "http://127.0.0.1:3000/users//birthday?date=2025-05-10"
# -> {"error":"User not found"} 

curl "http://127.0.0.1:3000/users/1/birthday?date=2025-05-09"
# -> false

curl "http://127.0.0.1:3000/users/1/birthday?date=2025-05-11"
# -> false

# 3.  AGE:
curl "http://127.0.0.1:3000/users/2/age?date=2025-06-01"
# -> 25

curl "http://127.0.0.1:3000/users/2/age?date=2025-05-10"
# -> 25

curl "http://127.0.0.1:3000/users/2/age?date=2025-04-01"
# -> 24

curl "http://127.0.0.1:3000/users/2/age?date=2025-05-09"
# -> 24

curl "http://127.0.0.1:3000/users/2/age?date=2025-05-10"
# -> 25

curl "http://127.0.0.1:3000/users/2/age"
# CURL: {"status":500,"error":"Internal Server Error","exception":"#\u003cTypeError: no implicit conversion of nil into String\u003e",.....}
# SERVER: Completed 500 Internal Server Error in 2ms (ActiveRecord: 0.5ms (1 query, 0 cached) | GC: 0.0ms)
# TypeError (no implicit conversion of nil into String):
# app/controllers/users_controller.rb:41:in `parse'
# app/controllers/users_controller.rb:41:in `age'

curl "http://127.0.0.1:3000/users/1/age?date=banana"
# SERVER: as above...status 500 "error": "invalid date"

curl "http://127.0.0.1:3000/users/999999/age?date=2025-05-10"
# SERVER: as above... status 404..."error": "user not found"

# 4. NEXT BDAY
curl "http://127.0.0.1:3000/users/2/next_birthday?date=2025-04-01"
# -> 2025-05-10

curl "http://127.0.0.1:3000/users/2/next_birthday?date=2025-06-01"
# -> 2026-05-10

curl "http://127.0.0.1:3000/users/2/next_birthday?date=2025-05-10"
# -> 2025-05-10 (bcoz '<' today not '=' !!!)

# !!! DANGER ZONE: !!!
# Create a user id:4
curl -X POST http://127.0.0.1:3000/users \
  -H "Content-Type: application/json" \
  -d '{"user":{"name":"Sophia Leaps","dob":"2000-02-29"}}'

curl "http://127.0.0.1:3000/users/4/birthday?date=2025-02-28"
# -> true !!!


curl "http://127.0.0.1:3000/users/4/birthday?date=2025-03-01"
# -> false!!!

curl "http://127.0.0.1:3000/users/4/next_birthday?date=2025-02-28"
# -> 2025-02-28  (bcoz '<' today not '=' !!!)

---

# PROBLEM SHOOTING:
## DB ERRORS DUE TO TEMPLATE etc.:
1. check-visualise in th eterminal:
rails db:migrate:status
    rails dbconsole
    \dt
    or:
    SELECT tablename
    FROM pg_tables
    WHERE schemaname = 'public';

## FIX:
1. delete all db:
    rails db:drop
    rails db:create
    rails db:migrate
2. Open the `config/database.yml` and change the name of the db into `rails_bday_api` everywhere in the `yml`.