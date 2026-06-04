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
7. ... - TEST manually all edge cases
8. OK - Add controller
9. OK - Add routes
10. OK - maybe add service?-TBC
---

# MANUAL TESTING:
# 1. Create a user:
curl -X POST http://127.0.0.1:3000/users -H "Content-Type: application/json" -d '{"user": {"name": "Mickie Mouse", "dob": "1928-11-08" }}'

# 2. Create a user.....:





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