require 'pry'

$AUDI_1_SEATS = %w[A1 A2 A3 A4 A5 A6 A7 A8 A9
                   B1 B2 B3 B4 B5 B6 
                   C2 C3 C4 C5 C6 C7] # Audi 1 seating arrangements

$AUDI_2_SEATS = %w[A1 A2 A3 A4 A5 A6 A7
                   B2 B3 B4 B5 B6
                   C1 C2 C3 C4 C5 C6 C7] # Audi 2 seating arrangements  
                
$AUDI_3_SEATS = %w[A1 A2 A3 A4 A5 A6 A7
                   B1 B2 B3 B4 B5 B6 B7 B8
                   C1 C2 C3 C4 C5 C6 C7 C8 C9] # Audi 3 seating arrangements             
$TOTAL_SALES = [] # Array for updating sales

ROWS = {"A"=> 'PLATINUM', "B"=> 'GOLD', "C"=> 'SILVER'} # Rows
PLATINUM, GOLD, SILVER = 320, 280, 240 # Rates for Seats
SERVICE_TAX, SWACH_BHARATH_CESS, KRISHI_KALYAN_CESS = 0.14, 0.005, 0.005 # Tax rates


class BookMovie
    
    # initialize program
    def initialize
      print_welcome_message
    end

    # Book tickets 
    def book_tickets_for_user
      book_tickets
    end

    # To find the sales price of selected seats
    def find_total_sale_price_of_seats(seat_numbers)
      @seats_price = 0
      @seats_price = seat_numbers.map{|seat| seat_price(seat)}.reduce(:+)
    end 

    private

    #To find show number and seat numbers
    def book_tickets
      ask_for_show_number
      if show_number_valid? 
        ask_for_seat_numbers 
        book_seats_if_available
      else
        print_show_number_error
      end  
    end

    # To print welcome message for starting bookings
    def print_welcome_message
      puts "Welcome to Movie Bookings"
      puts "------------------------"
    end

    # Take input from console
    def receive_input
      STDIN.gets.strip
    end

    # Get show number as an input
    def ask_for_show_number
      puts "Enter Show no:"
      @show_no = receive_input.to_i
    end  

    # Get seat numbers as an input
    def ask_for_seat_numbers
      puts "Enter Seats"
      @seat_numbers = receive_input.split(', ')
    end 

    # To check if show number is valid
    def show_number_valid?
      (1..3).include? @show_no 
    end  

    # Print error if show number is not valid
    def print_show_number_error
      puts "Shows are available only for Audis: 1, 2, 3. Please enter a valid show number"
      book_tickets
    end 

    # To book seats if seats available
    def book_seats_if_available
      check_for_unavailable_seats
      if @unavailable_seats.empty?
        book_selected_seats 
      else  
        print_seats_unavailable
        book_tickets
      end  
    end  

    # To find unavailable seats
    def check_for_unavailable_seats
      @unavailable_seats = (@seat_numbers - eval("$AUDI_#{@show_no}_SEATS")).join(', ')
    end   

    # To print unavailable seats
    def print_seats_unavailable
      puts "#{@unavailable_seats} Not available, Please select different seats "
    end  

    # To book selected seats
    def book_selected_seats
      find_total_sale_price_of_seats(@seat_numbers)
      find_other_taxes
      update_total_sales_array
      update_audi_seats
      print_sales_receipt
      give_next_options_to_continue
    end  
    
    # To calculate rate of a seat
    def seat_price(seat)
      eval(ROWS[seat[0]])
    end  

    # To calculate other taxes for tickets
    def find_other_taxes
      @service_tax = @seats_price * SERVICE_TAX
      @swach_bharath_cess = @seats_price * SWACH_BHARATH_CESS
      @krishi_kalyan_cess = @seats_price * KRISHI_KALYAN_CESS
    end  

    # To update sales array on each sale
    def update_total_sales_array
      $TOTAL_SALES << [@seats_price, @service_tax, @swach_bharath_cess, @krishi_kalyan_cess]
    end  

    # To update Audi seats each time after the sales 
    def update_audi_seats
      @seat_numbers.each do |seat_number|
        eval("$AUDI_#{@show_no}_SEATS").delete_at(eval("$AUDI_#{@show_no}_SEATS").index(seat_number))
      end
    end  

    # To print the sales receipt for each sale
    def print_sales_receipt
      puts "Successfully Booked - Show #{@show_no}"
      puts "Subtotal: Rs. #{@seats_price}"
      puts "Service Tax @14%: RS. #{@service_tax}"
      puts "Swachh Bharat Cess @0.5%: RS. #{@swach_bharath_cess}"
      puts "Krishi Kalyan Cess @0.5%: RS. #{@krishi_kalyan_cess}"
      puts "Total: Rs. #{$TOTAL_SALES.last.sum}"
    end  

    # can either book another ticket/ print total revenue / exit
    def give_next_options_to_continue
      puts "\n\n"
      puts "------------------------------------Please select any of the following options-------------------------------------------"
      puts "1: Book another ticket"
      puts "2: Print total revenue with taxes"
      puts "3: Exit"
      @selected_option = receive_input.to_i
      execute_on_basis_of_selected_option
    end  

    # Execute the program based on the value selected
    def execute_on_basis_of_selected_option
      case @selected_option
      when 1
        book_tickets
      when 2
        print_total_revenue_of_sales 
        give_next_options_to_continue
      end
    end  

    # To print the total revenue of sales
    def print_total_revenue_of_sales
      sales_total = $TOTAL_SALES.transpose.map {|e| e.inject(:+)}
      puts "Total Sales:" 
      puts "   Revenue: Rs. #{sales_total[0]}"
      puts "   Service Tax: Rs. #{sales_total[1]}"
      puts "   Swachh Bharat Cess: Rs. #{sales_total[2]}"
      puts "   Krishi Kalyan Cess: Rs. #{sales_total[3]}"
    end  
  
end  #end of MovieShow class
