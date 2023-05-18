require "csv"

module Seller
  def self.seeSellerData
    data = CSV.read("sellerdata.csv")
    data.each_with_index do |row, index|
      puts "#{index + 1} #{row}"
    end
    Choice.if2
  end

  def self.addSellerData
    loop do
      puts "Enter Seller's Details"
      puts "Enter Seller's Email"
      uemail = gets.chomp
      data = CSV.read("sellerdata.csv")
      if data.any? { |row| row[4] == uemail }
        puts "Email already exists"
        next
      end

      puts "Enter Seller's Name"
      uname = gets.chomp
      puts "Enter Password"
      upwd = gets.chomp
      puts "Enter Seller's Address"
      uadr = gets.chomp
      t = Time.now.usec

      id = "seller_" + t.to_s
      user_data = [id, uname, upwd, uadr, uemail]

      CSV.open('sellerdata.csv', 'a') do |csv|
        csv << user_data
      end

      puts "Account created successfully"
      break
    end
    Choice.if2
  end

  def self.deleteSellerData
    data = CSV.read("sellerdata.csv")
    data.each_with_index do |row, index|
      puts "#{index} #{row[0]} #{row[1]} #{row.last}"
    end
    puts "Enter the index of the row to be deleted"
    choice = gets.chomp.to_i
    if (0...data.length).include?(choice)
      data.delete_at(choice)
      CSV.open("sellerdata.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
      puts "Data has been deleted successfully."
    else
      puts "Invalid index. Please try again."
    end
    Choice.if2
  end

  def self.updateSellerData
    data = CSV.read("sellerdata.csv")
    idx = data.length - 1
    data.each_with_index do |row, index|
      puts "#{index} #{row[0]} #{row[1]} #{row.last}"
    end
    puts "Enter the index of the row to be updated:"
    @choice = gets.chomp.to_i
    if @choice <= idx
      puts "Enter updated name:"
      nm = gets.chomp
      puts "Enter updated password:"
      ps = gets.chomp
      puts "Enter updated location:"
      lc = gets.chomp
      puts "Enter updated email:"
      em = gets.chomp
      id = data[choice][0]
      seller_data = [id, nm, ps, lc, em]
      data[@choice] = seller_data
      CSV.open("sellerdata.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
      Choice.if2
    else
      puts "Invalid Choice"
      Choice.if2
    end
  end

  def self.list_product
    data = CSV.read("product.csv")
    data.each_with_index do |row, index|
      puts "#{index + 1} #{row}"
    end
    Choice.if2
  end

  def self.delete_product
    data = CSV.read("product.csv")
    data.each_with_index do |row, index|
      puts "#{index} #{row[0]} #{row[1]} #{row.last}"
    end
    puts "Enter the index of the row to be deleted"
    choice = gets.chomp.to_i
    if (0...data.length).include?(choice)
      data.delete_at(choice)
      CSV.open("product.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
      puts "Data has been deleted successfully."
    else
      puts "Invalid index. Please try again."
    end
    Choice.if2
  end

  def self.update_product
    data = CSV.read("product.csv")
    idx = data.length - 1
    data.each_with_index do |row, index|
      puts "#{index} #{row[1]} - #{row[2]} - #{row[3]} - #{row[4]}"
    end
    puts "Enter the index of the row to be updated:"
    choice = gets.chomp.to_i
    if choice <= idx
      puts "Enter updated name:"
      name = gets.chomp
      puts "Enter updated price:"
      price = gets.chomp.to_i
      puts "Enter updated quantity:"
      quantity = gets.chomp.to_i
      puts "Enter updated seller id:"
      seller_id = gets.chomp.to_s
      product_data = [data[choice][0], name, price, quantity, seller_id]
      data[choice] = product_data
      CSV.open("product.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
      Choice.if2
    else
      puts "Invalid Choice"
      Choice.if2
    end
  end
end

module User
  def self.seeUserData
    data = CSV.read("userdata.csv")
    data.each_with_index do |row, index|
      puts "#{index} #{row}"
    end
    Choice.if1
  end

  def self.deleteUserData
    data = CSV.read("userdata.csv")
    data.each_with_index do |row, index|
      puts "#{index} #{row[0]} #{row[1]} #{row.last}"
    end
    puts "Enter the index of the row to be deleted"
    choice = gets.chomp.to_i
    if (0...data.length).include?(choice)
      data.delete_at(choice)
      CSV.open("userdata.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
      puts "Data has been deleted successfully."
    else
      puts "Invalid index. Please try again."
    end
    Choice.if1
  end

  def self.addUserData
    loop do
      puts "Enter User's Details"
      puts "Enter User's Email"
      uemail = gets.chomp
      data = CSV.read("userdata.csv")
      if data.any? { |row| row[4] == uemail }
        puts "Email already exists"
        next
      end

      puts "Enter User's Name"
      uname = gets.chomp
      puts "Enter Password"
      upwd = gets.chomp
      puts "Enter Your Address"
      uadr = gets.chomp
      t = Time.now.usec

      id = "user_" + t.to_s
      user_data = [id, uname, upwd, uadr, uemail]

      CSV.open('userdata.csv', 'a') do |csv|
        csv << user_data
      end

      puts "Account created successfully"
      break # exit the loop
    end
    Choice.if1
  end

  def self.updateUserData()
    data = CSV.read("userdata.csv")
    data.each_with_index do |row, index|
      puts "#{index} #{row[0]} #{row[1]} #{row.last}"
    end
    puts "Enter the index of the row to be updated:"
    choice = gets.chomp.to_i
    puts "Enter updated name:"
    nm = gets.chomp
    puts "Enter updated password:"
    ps = gets.chomp
    puts "Enter updated location:"
    lc = gets.chomp
    puts "Enter updated email:"
    em = gets.chomp
    id = data[choice][0]
    user_data = [id, nm, ps, lc, em]
    data[choice] = user_data
    CSV.open("userdata.csv", "w") do |csv|
      data.each do |row|
        csv << row
      end
    end
    Choice.if1
  end
end

module Choice
  def self.if1
    puts "1 See user Detail"
    puts "2 Add user Detail"
    puts "3 Delete user Detail"
    puts "4 Update user Detail"
    puts "0 Main menu"
    choice = gets.chomp.to_i
    if choice == 1
      User.seeUserData
    elsif choice == 2
      User.addUserData
    elsif choice == 3
      User.deleteUserData
    elsif choice == 4
      User.updateUserData()
    elsif choice == 0
      main
    else
      puts "Invalid choice"
      Choice.if1
    end
  end

  def self.if2
    puts "1 See seller data"
    puts "2 Add seller data"
    puts "3 Delete seller data"
    puts "4 Update seller data"
    puts "5 List Products"
    puts "6 Delete Product"
    puts "7 Update product data"
    puts "0 Main menu"
    choice = gets.chomp.to_i
    if choice == 1
      Seller.seeSellerData
    elsif choice == 2
      Seller.addSellerData
    elsif choice == 3
      Seller.deleteSellerData
    elsif choice == 4
      Seller.updateSellerData()
    elsif choice == 5
      Seller.list_product()
    elsif choice == 6
      Seller.delete_product()
    elsif choice == 7
      Seller.update_product()
    elsif choice == 0
      main
    else
      puts "Invalid choice"
      Choice.if2
    end
  end
end

