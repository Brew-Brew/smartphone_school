require "administrate/base_dashboard"

class ScoreDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    subject: Field::BelongsTo,
    id: Field::Number,
    total_score: Field::Number,
    quiz_score: Field::Number,
    practice_score: Field::Number,
    user_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :subject,
    :id,
    :total_score,
    :quiz_score,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :subject,
    :id,
    :total_score,
    :quiz_score,
    :practice_score,
    :user_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :subject,
    :total_score,
    :quiz_score,
    :practice_score,
    :user_id,
  ].freeze

  # Overwrite this method to customize how scores are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(score)
  #   "Score ##{score.id}"
  # end
end
