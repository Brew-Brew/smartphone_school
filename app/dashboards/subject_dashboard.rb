require "administrate/base_dashboard"

class SubjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    quizzes: Field::HasMany,
    scores: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    lecture: Field::String,
    score: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :quizzes,
    :scores,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :quizzes,
    :scores,
    :id,
    :name,
    :lecture,
    :score,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :quizzes,
    :scores,
    :name,
    :lecture,
    :score,
  ].freeze

  # Overwrite this method to customize how subjects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(subject)
  #   "Subject ##{subject.id}"
  # end
end
