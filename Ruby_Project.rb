# slot_booking_system.rb

class SlotBookingSystem
  MAX_SLOTS = 8

  def initialize(filename)
    @filename = filename
    @slots = load_slots
  end

  def load_slots
    return Array.new(MAX_SLOTS, 'available') unless File.exist?(@filename)

    File.readlines(@filename).map(&:chomp)
  end

  def display_slots
    puts "\nToday's Slots:"
    @slots.each_with_index do |status, index|
      puts "#{index + 9}:00 - #{status}"
    end
  end

  def book_slot
    if @slots.count('available') == 0
      puts "Sorry, no slots available for today."
      return
    end

  def display_slots
    print "Enter the hour you want to book (9 to 16): "
    hour = gets.to_i
    slot_index = hour - 9

    if valid_slot_index?(slot_index) && @slots[slot_index] == 'available'
      @slots[slot_index] = 'booked'
      puts "You have successfully booked the #{hour}:00 slot."
      save_slots
    else
      puts "Invalid slot or slot already booked."
    end
  end

  def delete_slot
    display_slots
    print "Enter the hour of the slot you want to cancel (9 to 16): "
    hour = gets.to_i
    slot_index = hour - 9

    if valid_slot_index?(slot_index) && @slots[slot_index] == 'booked'
      @slots[slot_index] = 'available'
      puts "The #{hour}:00 slot has been successfully canceled."
      save_slots
    else
      puts "Invalid slot or slot not booked."
    end
  end

  def save_slots
    File.open(@filename, 'w') do |file|
      @slots.each { |slot| file.puts(slot) }
    end
  end

  private

  def valid_slot_index?(index)
    index >= 0 && index < MAX_SLOTS
  end
end

def main
  system = SlotBookingSystem.new("slots.txt")

  loop do
    puts "\nWelcome to the Hospital Slot Booking System"
    puts "1. Display Slots"
    puts "2. Book a Slot"
    puts "3. Delete a Slot"
    puts "4. Exit"
    print "Choose an option: "
    choice = gets.to_i

    case choice
    when 1
      system.display_slots
    when 2
      system.book_slot
    when 3
      system.delete_slot
    when 4
      puts "Thank you for using the system!"
      break
    else
      puts "Invalid option. Please try again."
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
