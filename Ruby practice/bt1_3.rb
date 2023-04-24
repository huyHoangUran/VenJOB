class B3
    def b1
        (1..50).map{|x| x.even? ? x**2 : x *2  }
    end

    
    
    def b2
        nums = b1
        numToHash = {}
        (1..50).each { |i| numToHash[i-1] = nums[i]}
         numToHash

    end
end
b3 = B3.new


puts b3.b1
puts b3.b2