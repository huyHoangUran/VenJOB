class B3
    def b1
        nums = []
        (1..50).each do |i|
            nums[i-1] = i
        end

        nums.each do |s|
            if (nums[s-1]%2==0)
                nums[s-1] = s*s
            else
                nums[s-1] = s*2

            end

        end
        return nums
    end

    def b2
        nums = b1
        numToHash = {}
        (1..50).each do |i|
            numToHash[i] = nums[i-1]
        end
        return numToHash

    end
    
end
b3 = B3.new
puts b3.b1
puts b3.b2

