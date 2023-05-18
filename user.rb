module BuyPro
  def self.productOperation(*row)
    login = row.first[0]
    CSV.open("userLogin.csv", "a") do |csv|
      csv << [login]
    end
    puts "1 Buy Products"
    puts "2 See Your Activity"
    puts "3 Logout"
    choice = gets.chomp.to_i
    if choice == 1
      getProduct
    elsif choice == 2
      seeActivity
    elsif choice == 3
      File.open("userLogin.csv", "w") do |file|
        main
      end
    else
      puts "Invalid Choice"
      productOperation(data[0])
    end
  end

  def self.getProduct
    data = CSV.read("product.csv")
    data.each_with_index do |row, index|
      puts "#{index} #{row[1]} - #{row[3]} - #{row[4]}"
    end
    puts "Enter the index of the product to be purchased:"
    choice = gets.chomp.to_i
    puts "Enter Quantity:"
    qty = gets.chomp.to_i
    price = data[choice][3].to_i * qty
    d = CSV.read('userLogin.csv')
    user = d.first[0]
    status = "ordered"
    product_data = [data[choice][0], data[choice][1], qty, price, data[choice][4], user, status]
    puts product_data.join(',')
    CSV.open("orders.csv", "a") do |csv|
      csv << product_data
      puts "You ordered #{qty} #{data[choice][1]} worths of #{price}"
      puts "Order Placed Successfully. Please wait for the seller's confirmation."
    end
    productOperation(data[0])
  end

  def self.seeActivity
    data = CSV.read("orders.csv")
    login = CSV.read("userLogin.csv")
    found_data = false
    data.each do |row|
      if row[5] == login.first[0]
        puts "#{row.last} #{row[2]} #{row[1]} worths #{row[3]}"
        found_data = true
      end
    end
    puts "Data not exist" unless found_data
    productOperation(data[0])
  end
end
