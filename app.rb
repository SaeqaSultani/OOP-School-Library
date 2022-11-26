require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'classroom'
require_relative 'person'

class App
  attr_accessor :books, :rentals, :people

  def initialize
    @books = []
    @rentals = []
    @people = []
  end

  def select_section(section)
    case section
    when '1'
      books_list
    when '2'
      people_list
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      rentals_list
    else
      puts 'Please select a valid section!'
    end
  end

  def books_list
    @books.each do |book|
      book.instance_variables.each do |var|
        string = ''
        value = book.instance_variable_get(var)
        var = var.to_s.delete('@')
        var = var.capitalize
        string += "#{var}:#{value} " unless var.include?('Rentals')
        puts string
      end
    end
  end

  def people_list
    @people.each do |person|
      person.instance_variables.each do |var|
        string = ''
        value = person.instance_variable_get(var)
        var = var.to_s.delete('@')
        var = var.capitalize
        string += "#{var}:#{value} " unless var.include?('Rentals') or var.include?('Classroom')
        puts string
      end
    end
  end

  def create_person
    puts 'Do you want to create a student(1) or a teacher(2)?'
    choise = gets.chomp

    case choise
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Your input is wrong!'
    end
  end

  def create_student
    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Has parent permission? [Y/N]'
    parent_permission = gets.chomp.upcase == 'Y'
    student = Student.new(age, name, parent_permission)
    @people.push(student)
    puts 'You added student successfully'
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Specialization:'
    specialization = gets.chomp
    teacher = Teacher.new(age, name, specialization)
    @people.push(teacher)
    puts 'You added teacher successfully'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully'
  end

  def books_with_index
    @books.each_with_index do |book, index|
      string = "#{index}: "
      book.instance_variables.each do |var|
        val = book.instance_variable_get(var)
        var = var.to_s.delete('@')
        string += "#{var}:#{val} " unless var.include?('rentals') or var.include?('classroom')
      end
      puts string
    end
  end

  def people_with_index
    @people.each_with_index do |person, index|
      string = "#{index}: "
      person.instance_variables.each do |var|
        val = person.instance_variable_get(var)
        var = var.to_s.delete('@')
        string += "#{var}:#{val} " unless var.include?('rentals') or var.include?('classroom')
      end
      puts string
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    books_with_index
    selected_book = gets.chomp.to_i
    puts 'Select a person from the following list by number (not ID)'
    people_with_index
    selected_person = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    book = @books[selected_book]
    person = @people[selected_person]
    rental = Rental.new(date, book, person)
    @rentals.push(rental)
    puts 'Rental created successfully'
  end

  def rentals_list
    print 'To see person rentals enter the person ID: '
    id = gets.chomp.to_i
    puts 'Rented Books:'
    @rentals.each do |rental|
      person = rental.instance_variable_get(:@person)
      person_id = person.instance_variable_get(:@id)

      next unless person_id == id

      book = rental.instance_variable_get(:@book)
      title = book.instance_variable_get(:@title)
      author = book.instance_variable_get(:@author)
      puts "Date: #{rental.date} Book: #{title} by Author: #{author} "
    end
  end
end
