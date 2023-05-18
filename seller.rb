$LOAD_PATH << '.'
require 'csv'

module Product
  def self.seeProduct
    data = CSV.read("product.csv")
    login = CSV.read("loginData.csv")
    found_data = false
    data.each do |row|
      if row.last == login.first[0]
        puts "#{row[0]}, #{row[1]}, #{row[3]}, #{row[2]}, #{row[4]}"
        found_data = true
      end
    end
    puts "Data not exist" unless found_data
    productOperation(data[0])
  end

  def self.addProduct
    puts "Enter Product Name"
    pname = gets.chomp
    puts "Enter Quantity"
    pqty = gets.chomp.to_i
    puts "Enter Price/Piece"
    price = gets.chomp.to_i
    data = CSV.read('loginData.csv')
    login = data.first[0][0]
    t = Time.now.usec
    pid = "product" + t.to_s
    product_data = [pid, pname, pqty, price, login]
    CSV.open('product.csv', 'a') do |csv|
      csv << product_data
    end
    productOperation(data[0])
  end

  def self.productOperation(*row)
    login = row.first[0]
    CSV.open("loginData.csv", "a") do |csv|
      csv << [login]
    end
    puts "1 List Products"
    puts "2 Add Product"
    puts "3 Update Product"
    puts "4 Delete Product"
    puts "5 View Orders"
    puts "6 Logout"
    choice = gets.chomp.to_i
    if choice == 1
      seeProduct
    elsif choice == 2
      addProduct
    elsif choice == 3
      updateProduct
    elsif choice == 4
      deleteProduct
    elsif choice == 5
      pendingOrders
    elsif choice == 6
      File.open("loginData.csv", "w") do |file|
        main
      end
    else
      puts "Invalid Choice"
    end
  end

  def self.accept
    data = CSV.read("orders.csv")
    login = CSV.read("loginData.csv")
    num = 0
    temp = []

    data.each_with_index do |row, index|
      if row[4] == login.first[0] && row.last == "ordered"
        puts "#{num} #{row.last} #{row[2]} #{row[1]} worths #{row[3]} by #{row[5]}"
        num += 1
        temp.push(row.first)
      end
    end

    puts "Enter the number of the product you want to accept:"
    choice = gets.chomp.to_i

    id = temp[choice]
    product_index = nil

    data.each_with_index do |row, index|
      if row[0] == id
        product_index = index
        break
      end
    end

    if product_index
      status = "confirmed"
      product_data = [data[product_index][0], data[product_index][1], data[product_index][2], data[product_index][3], data[product_index][4], data[product_index][5], status]
      puts "#{product_data}"

      CSV.open("orders.csv", "a") do |csv|
        csv << product_data
      end

      Product.productOperation(login.first[0])
    else
      puts "Invalid Id"
    end
  end

  def self.reject
    data = CSV.read("orders.csv")
    login = CSV.read("loginData.csv")
    num = 0
    temp = []

    data.each_with_index do |row, index|
      if row[4] == login.first[0] && row.last == "ordered"
        puts "#{num} #{row.last} #{row[2]} #{row[1]} worths #{row[3]} by #{row[5]}"
        num += 1
        temp.push(row.first)
      end
    end

    puts "Enter the number of the product you want to reject:"
    choice = gets.chomp.to_i

    id = temp[choice]
    product_index = nil

    data.each_with_index do |row, index|
      if row[0] == id
        product_index = index
        break
      end
    end

    if product_index
      puts "Give a reason:"
      reason = gets.chomp
      status = "rejected because of #{reason}"
      product_data = [data[product_index][0], data[product_index][1], data[product_index][2], data[product_index][3], data[product_index][4], data[product_index][5], status]
      puts "#{product_data}"

      CSV.open("orders.csv", "a") do |csv|
        csv << product_data
      end

      Product.productOperation(login.first[0])
    else
      puts "Invalid Id"
    end
  end

  def self.pendingOrders
    data = CSV.read("orders.csv")
    login = CSV.read("loginData.csv")
    found_data = false

    data.each_with_index do |row, index|
      if row[4] == login.first[0] && row.last == "ordered"
        if row.last != "confirmed" || row.last != "rejected"
          puts "#{row.last} #{row[2]} #{row[1]} worths #{row[3]} by #{row[5]}"
          found_data = true
        end
      end
    end

    if found_data
      puts "1 Accept"
        puts "2 Reject"
        choice = gets.chomp.to_i

        if choice == 1
          accept
        elsif choice == 2
          reject
        else
          puts "Invalid Choice"
          productOperation(data[0])
        end
      else
        puts "No Pending Orders"
      end

      productOperation(data[0])
    end

  def self.updateProduct
    data = CSV.read("product.csv")
    login = CSV.read("loginData.csv")
    num = 0
    temp = []
    data.each do |row|
      if row.last == login.first[0][0]
        puts "#{num} #{row}"
        num += 1
        temp.push(row.first)
      end
    end
    puts "#{temp}"
    puts "Enter the a number where's product want to update:"
    choice = gets.chomp.to_i
    puts "Enter updated Product name:"
    pnm = gets.chomp
    puts "Enter updated Quantity:"
    pqt = gets.chomp.to_i
    puts "Enter updated Price:"
    pr = gets.chomp.to_i

    id = temp[choice]
    product_index = data.index { |row| row[0] == id }
    if product_index
      product_data = [id, pnm, pqt, pr, login.first[0][0]]
      data[product_index] = product_data
      CSV.open("product.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
      Product.productOperation(login.first[0])
    else
      puts "Invalid Id"
    end
  end

  def self.deleteProduct
    data = CSV.read("product.csv")
    login = CSV.read("loginData.csv")
    num = 0
    temp = []
    data.each do |row|
      if row.last == login.first[0]
        puts "#{num} #{row}"
        num += 1
        temp.push(row.first)
      end
    end
    # puts "#{temp}"
    puts "Enter the number of the product you want to delete:"
    choice = gets.chomp.to_i

    id = temp[choice]
    product_index = data.index { |row| row[0] == id }
    if product_index
      data.delete_at(product_index)
      CSV.open("product.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
      Product.productOperation(login.first[0])
    else
      puts "Invalid Id"
    end
  end
end
