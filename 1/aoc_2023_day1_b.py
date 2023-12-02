
numbers = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
]
    
with open("input.txt") as f:
    acc = 0 
    for line in f:
        first = "0"
        last = "0"
        for i, char in enumerate(line):
            found = False 
            if char >= "0" and char <= "9":
                first = char 
                break 
            for num, word in enumerate(numbers):
                if line[i:i+len(word)] == word:
                    first = str(num)
                    found = True 
                    break
            if found:
                break
        
        for i, char in enumerate(line[::-1]):
            found = False 
            if char >= "0" and char <= "9":
                last = char 
                break
            for num, word in enumerate(numbers):
                ii = len(line) - 1 - i
                if line[ii:ii+len(word)] == word:
                    last = str(num)
                    found = True
                    break

            if found:
                break

        # print(first, last)
        acc += int(first + last)
    print("acc",acc)

            