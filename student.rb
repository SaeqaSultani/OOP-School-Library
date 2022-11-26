require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, class_room, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @class_room = class_room
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def add_classroom(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
