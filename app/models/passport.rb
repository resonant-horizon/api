class Passport < ApplicationRecord
  belongs_to :employee

  validates_presence_of :employee_id,
                        :passport_number,
                        :surname,
                        :given_names,
                        :nationality,
                        :birth_place,
                        :birthdate,
                        :expiration_date,
                        :issue_date,
                        :passport_sex

  enum passport_sex: {
    male: 0,
    female: 1,
    other: 2
  }, _prefix: true
end
