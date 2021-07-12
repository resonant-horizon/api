class SeasonEmployee < ApplicationRecord
  belongs_to :season
  belongs_to :employee

  validates_presence_of :season_id, :employee_id

end
