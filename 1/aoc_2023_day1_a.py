with open("input.txt") as f:
    acc = 0 
    for line in f:
        first = "0"
        last = "0"
        for char in line:
            if char >= "0" and char <= "9":
                first = char 
                break 
        
        for char in line[::-1]:
            if char >= "0" and char <= "9":
                last = char 
                break

        print(first, last)
        acc += int(first + last)
        print(acc)

            