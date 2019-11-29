import Cocoa


// MARK: - Control Flow

/**
 Your first task it to write an if statement that checks the value of onGuestList. If it's true, then print a message welcoming the person to the club. Then write another if statement to check if the value of onGuestList is false and print a message nicely turning the person away.
 */

var onGuestList = true
if (onGuestList) {
    print("welcome to the guest list")
} else {
    print("sorry not on the list")
}


/**
We also need to check to ensure none of our guests are under the drinking age. Modify your first if statements so that it checks if the person is both on the guest list and if they're 21 or older.
Then modify your second if statement to check if the person is either not on the guest list or if they're under 21.
*/

var age = 22
if(onGuestList && age >= 21) {
    print("welcome to the guest list")
} else {
    print("sorry not on the list or you're underage")
}


/**
 We know that if someone is on the guest list and is 21 or older, then they'll be admitted into the club. Otherwise, they will be turned away. Knowing this fact, rewrite your code into a single if statement. The else case should be used to turn the clubgoer away.
 */

if(onGuestList && age >= 21) {
    print("welcome to the guest list")
} else {
    print("sorry not on the list or you're underage")
}

/**
 There's one exception to our club's rules. If someone knows the owner, they can get into the party, regardless of their age or whether or not they're invited.

 Add an else if statement to your program to check if knowsTheOwner is true. If so, print a message informing the person to see the owner.
 */

age = 20
var knowsTheOwner = true

if(onGuestList && age >= 21) {
    print("welcome to the guest list")
} else if (knowsTheOwner) {
    print("you are in da club")
} else {
    print("sorry not on the list or you're underage")
}


// refactor the code to use a switch statement
let meal = "dinner"

if meal == "breakfast" {
    print("Good morning!")
} else if meal == "lunch" {
    print("Good afternoon!")
} else if meal == "dinner" {
    print("Good evening!")
} else {
    print("Hello!")
}

switch meal {
    case "breakfast": print("Good morning!")
    case "lunch": print("Good afternoon!")
    case "dinner": print("Good evening!")
    default: print("Yikes - not sure what time it is")
}

 // MARK: - RANGE

for i in -3...(-1) {
    print(i)
}

/** Write a loop that prints each character in a string on a separate line.  */

let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

// your loop to print the characters in lorem goes here

for character in lorem {
    print(character)
}

/**
Practice: While Loops
Now write a while loop that prints the even numbers from 1 to 1000 (inclusive). While you could just do this with a for loop, try using a while loop.

For example, if we were printing even numbers from 1 to 10, we'd get the following output.

2
4
6
8
10
 */

var i = 1
while i <= 1000 {
    if (i % 2 == 0) {
        print(i)
    }
    i+=1
}


/**
 Practice with the Keyword Break
Write a while loop that "continuously flips two coins". The coin flips can be simulated by randomly assigning two Int values to 0 or 1 (ex: 0 is "heads", 1 is "tails"). Use the break keyword to exit the while loop if both coins are equal to tails.
 */

let tails = 1
let heads = 0

var coin1 = tails
var coin2 = heads

while(true) {
    if (coin1 == tails && coin2 == tails) {
        print("TAILS ACHIEVED!!!")
        break
    }
    else {
        coin1 = Int.random(in: 0...1)
        coin2 = Int.random(in: 0...1)
        print("Darn-- no tails")
    }
}

while(true) {
    if (coin1 == coin2) {
        print("EQUALITY ACHIEVED!!!")
        break
    }
    else {
        coin1 = Int.random(in: 0...1)
        coin2 = Int.random(in: 0...1)
        print("Darn-- no equality")
    }
}

/**
 Practice: The Break Keyword
Print the even numbers from 1 to 500 (inclusive). Use a while loop and the break keyword. The code for the loop has been provided for you; but you'll need to modify it to break when appropriate.

Hint: Your knowledge of operators and boolean expressions will come in handy.
 */

var number = 0

while true {
    number += 2
    print(number)
    // ↓ Your code goes here ↓
    if (number == 500) {
        break
    }
}

//var thisIsAString: String = "Cannot change to different type"
//thisIsAString = 0


/**
 Practice: Spam Filter
 As part of the spam filter for a message board app, there's a function called checkLength(). The goal of this function is to prevent posts that are too short (less than 10 characters) and prevent posts that are too long (more than 10,000 characters). Finish implementing the function to return true if a message is within the length restrictions and false if it is too long or too short.
 */

func checkLength(message: String) -> Bool {
    if (message.count < 10 || message.count > 10000) { return false }
    else { return true }
}

print(checkLength(message: "asdfasdfasdfasdfasdfasfasfsadfasdfsdfsad"))
print(checkLength(message: "1234567899"))


/**
 Practice: Case Insensitive Search
 Finish implementing search(). If the second string (s2) occurs anywhere in the first string (s1), return true. Otherwise, return false. The search should be case insensitive. For example, search(s1: "Udacity", s2: "CITY") returns true.
 
 */

 func search(s1: String, s2: String) -> Bool {
     
     return s1.lowercased().contains(s2.lowercased())
 }
 print(search(s1: "apple", s2: "Ap"))

/**
 Practice: Is Palindrome?
 Finish implementing isPalindrome() to return true if the input string is the same forwards and backwards, and false if not. The search should be case sensitive, for example, isPalindrome(input: "taCoCat") would return true whereas isPalindrome(input: "TaCoCAt") would return false.
 */

func isPalindrome(input: String) -> Bool {
    return String(input.reversed()) == input
}

print(isPalindrome(input: "cat"))
print(isPalindrome(input: "toot"))



/**
 Practice: Remove First N Elements
 Finish implementing the function remove(input: String, first: Int, last: Int), where first is the number of characters to be removed from the beginning of the string, and last is the number of characters to be removed from the end of the string. Return a new string with all the characters removed.

 Hint 1: It's possible that the function will be called with 0 for first, last, or both.

 Hint 2: if the sum of first and last are greater than the number of characters in string, then we'd remove more characters than are present in the string and the program will crash. If this is the case, return an empty string.
 */


func remove(input: String, first: Int, last: Int) -> String {
    // we require a variable to manipulate strings
    var newString = input
    
    if (first + last > input.count) {
       return ""
    }
    
    newString.removeFirst(first)
    newString.removeLast(last)
    // modify newString and return the result
    return newString
    
}
print("testing...")
print(remove(input: "a", first: 1, last: 1))
print(remove(input: "apple", first: 1, last: 1))
print(remove(input: "apple", first: 2, last: 2))


/**
 Practice: Remove Array Elements
 Finish implementing removeElements(array: [Int], n: Int) to return a new array with the first n elements removed. For example, calling removeElements(array: [1, 2, 3, 4], n: 2) would return [3, 4] because the first element 1, and the second element 2 would be removed.
 */

func removeElements(array: [Int], n: Int) -> [Int] {
    // You may need to modify newArray
    var newArray = array
    newArray.removeFirst(n)
    return newArray
}

print(removeElements(array: [1, 2, 3, 4], n: 2))

/**
 Practice: Number Frequency
 Finish implementing the function frequency(numbers: [Int]) -> [Int: Int] that returns a dictionary containing the frequency of each number in the array. The dictionary's keys will be the Int values in the numbers array. The dictionary's values will be the number of times that number occurs in the numbers array. For example

 If the numbers array were the following:

 let input = [1, 3, 1, 1, 2, 7, 3, 5, 8, 5, 4, 9]
 Then the calling frequency(numbers: input) would return a dictionary like the following.
 [
     1: 3,
     2: 1,
     3: 2,
     4: 1,
     5: 2,
     7: 1,
     8: 1,
     9: 1
 ]
 */

func frequency(numbers: [Int]) -> [Int: Int] {
    // create a dictionary that uses key: number, value: frequency
    // iterate through the array
    // if value exists in dictionary -> increment the number
    // else continue
    // return the dictionary
    var frequency = [Int: Int]()

    for n in numbers {
        if let value = frequency[n] {
            frequency.updateValue(value+1, forKey: n)
        } else {
            frequency[n] = 1
        }
    }
    return frequency
}

let input = [1, 3, 1, 1, 2, 7, 3, 5, 8, 5, 4, 9]
print(frequency(numbers: input))


var presidentialPetsDict = ["Barack Obama":"Bo", "Bill Clinton":"Socks",
"George Bush":"Miss Beazley", "Ronald Reagan":"Lucky"]

presidentialPetsDict["George W. Bush"] = presidentialPetsDict["George Bush"]
presidentialPetsDict["George Bush"] = nil
presidentialPetsDict

/**
 Practice: Count Distinct Items
 Using your knowledge of different collection types, implement the function countDistinct(numbers: [Int]) to return the number of distinct elements in the array. For example

 countDistinct(numbers: [20, 10, 10, 30, 20])
 would return 3, because 10, 20, and 30 are the distinct elements.
 */

func countDistinct(numbers: [Int]) -> Int {
   var distinct = Set<Int>()
 
   for i in numbers {
       distinct.insert(i)
   }
   return distinct.count
}

print(countDistinct(numbers: [20, 10, 10, 30, 20]))


var a = [1,2,3,4]
var b = a

b.removeFirst()
print(a)
print(b)


class Numbers {
    var value = 0
}

var originalArray = [Numbers(), Numbers()]
var copiedArray = originalArray

originalArray[0].value = 1
// originalArray = [1,0]
// copiedArray = [1,0]

originalArray[0] = Numbers()

// originalArray = [0,0]
// copiedArray = [1,0]

class IntegerReference {
    var value = 10
}
var firstIntegers = [IntegerReference(), IntegerReference()]
var secondIntegers = firstIntegers

// Modifications to an instance are visible from either array
firstIntegers[0].value = 100
print(secondIntegers[0].value)
// Prints "100"

// Replacements, additions, and removals are still visible
// only in the modified array
firstIntegers[0] = IntegerReference()
print(firstIntegers[0].value)
// Prints "10"
print(secondIntegers[0].value)
// Prints "100"


class Shape {
    var height: Double = 0
    var width: Double = 0

    init(height: Double, width: Double) {
        self.height = height
        self.width = width
    }

    public func calculateArea() -> Double {
        return height * width
    }
}

class Triangle: Shape {
    var base: Double = 0

    init(height: Double, width: Double, base: Double) {
        super.init(height: height, width: width)
        self.base = base
    }

    override public func calculateArea() -> Double {
        return (height * base) / 2
    }
}




var triangle: Shape
triangle = Triangle(height: 1.0, width: 2.0, base: 4)

print(triangle.calculateArea())
