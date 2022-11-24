require_relative 'person'

class Student < Person
  def initialize(age, class_room, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @class_room = class_room
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
