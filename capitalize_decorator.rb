require_relative 'base-decorator'

class CalitalizeDecorator < BaseDecorator
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    super.capitalize
  end
end
