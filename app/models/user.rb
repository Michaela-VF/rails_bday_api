class User < ApplicationRecord
  validates :name, presence: true
  validates :dob, presence: true

  # User#birthday?
  # returns a Boolean for whether today is their birthday
  def birthday?(today = Date.current)
    this_year_birthday(today) == today
  end

  # User#age
  # returns an integer representing the user’s age in years
  def age(today = Date.current)
    age_in_years = today.year - dob.year

    age_in_years -= 1 if today < this_year_birthday(today)

    age_in_years
  end

  # User#next_birthday
  # returns the date of the user’s next birthday
  def next_birthday(today = Date.today)
    birthday_this_year =  this_year_birthday(today) # this is to avoid computing it every time in the ternary below

    birthday_this_year < today ? birthday_this_year.next_year : birthday_this_year
  end

  private

  def this_year_birthday(today = Date.current)
    # dependant on product specifics, culture, legislation etc.
    if feb_29_birthday? && !today.leap?
      return Date.new(today.year, 2, 28)
    end

    Date.new(today.year, dob.month, dob.day)
  end

  def feb_29_birthday?
    dob.month == 2 && dob.day == 29
  end
end

# TODO:
# 1. keep injecting today for (deterministic) testing purposes!
# 2. once tests pass etc you can remove it to give the model a "production look"
