import Cocoa

//:a) In the assignment for Week 3, part D asked you to write a function that would compute the average of an array of Int. Using that function and the array created in part A, create two overloaded functions of the function average.

func average(inputArray: [Int]?) {
  if let inputArray = inputArray {
    let sum: Int = inputArray.reduce(0, +)
    print("The average of the values in the array is \(inputArray.reduce(0, +)/inputArray.count).")
  } else {
    print("The array is nil. Calculating the average is impossible.")
  }
}

//overloading 1
func average(someLabel inputArray: [Int]?) {
  if let inputArray = inputArray {
    let sum: Int = inputArray.reduce(0, +)
    print("The average of the values in the array is \(inputArray.reduce(0, +)/inputArray.count).")
  } else {
    print("The array is nil. Calculating the average is impossible.")
  }
}

//overloading 2
func average(inputArray: [Int]?) -> Bool {
  if let inputArray = inputArray {
    let sum: Int = inputArray.reduce(0, +)
    print("The average of the values in the array is \(inputArray.reduce(0, +)/inputArray.count).")
    return true
  } else {
    print("The array is nil. Calculating the average is impossible.")
    return false
  }
}

//:b) Create an enum called Animal that has at least five animals. Next, make a function called theSoundMadeBy that has a parameter of type Animal. This function should output the sound that the animal makes. For example, if the Animal passed is a cow, the function should output, “A cow goes moooo.”Hint: Do not use if statements to complete this section. Call the function twice, sending a different Animal each time.

enum Animal {
  case cat
  case dog
  case cow
  case turtle
  case dragon
  case alpaca
}

func theSoundMadeBy(animal: Animal) -> String {
  switch animal {
  case .cow:
    return "A cow goes moooo."
  default:
    return "A \(animal) has a default sound."
  }
}
theSoundMadeBy(animal: Animal.cow)
theSoundMadeBy(animal: Animal.cat)

//:c)This question will have you creating multiple functions that will require you to use closures and collections. First, you will do some setup.
/*
 Create an array of Int called nums with the values of 0 to 100.
 */
let nums = Array(0...100)

/*
 Create an array of Int? called numsWithNil with the following values:
 79, nil, 80, nil, 90, nil, 100, 72
 */
let numsWithNil: [Int?] = [79, nil, 80, nil, 90, nil, 100, 72]

/*
 Create an array of Int called numsBy2 with values starting at 2 through 100, by 2.
 */
//approach 1
let numsBy2 = Array(2...100).filter{$0 % 2 == 0}
////approach 2
//let numsBy2 = Array(2...100).filter{$0.isMultiple(of: 2)}

/*
 Create an array of Int called numsBy2 with values starting at 2 through 100, by 4.
 */
let numsBy4 = numsBy2.filter{$0.isMultiple(of: 4)}

/*
 Create a function called evenNumbersArray that takes a parameter of [Int] (array of Int) and returns [Int]. The array of Int returned should contain all the even numbers in the array passed. Call the function passing the nums array and print the output.
 */

func evenNumbersArray(nums: [Int]) -> [Int]{
  return nums.filter{$0.isMultiple(of: 2)}
}

print(evenNumbersArray(nums: Array(1...100)))

/*
 Create a function called sumOfArray that takes a parameter of [Int?] and returns an Int. The function should return the sum of the array values passed that are not nil. Call the function passing the numsWithNil array, and print out the results.
 */
func sumOfArray(nums: [Int?]) -> Int{
  return nums.compactMap{$0}.reduce(0, +)
}
print(sumOfArray(nums: [1,nil,2,nil,3,nil,4]))

/*
 Create a function called commonElementsSet that takes two parameters of [Int] and returns a Set<Int> (set of Int). The function will return a Set<Int> of the values in both arrays.
 */
/*
 Call the function commonElementsSet passing the arrays numsBy2, numsBy4, and print out the results.
 */
//approach 1: time complexity O(n), space complexity O(n)
func commonElementsSet(_ a: [Int], _ b: [Int]) -> Set<Int>{
  let bSet = Set(b)
  return Set(a.filter{bSet.contains($0)})
}
var a = [1,2,3]
var b = [4,1,0]
print(commonElementsSet(a, b))

////approach 2: time complexity O(nlogn),  space complexity O(logn)
//func commonElementsSet(_ a: inout [Int], _ b: inout [Int]) -> Set<Int>{
//  a.sort()
//  b.sort()
//  var idxA: Int = 0
//  var idxB: Int = 0
//  var commonEle: Set<Int> = []
//  while idxA < a.count && idxB < b.count {
//    if a[idxA] == b[idxB] {
//      commonEle.insert(a[idxA])
//      idxA += 1
//      idxB += 1
//    } else if (a[idxA] < b[idxB]) {
//      idxA += 1
//    } else {
//      idxB += 1
//    }
//  }
//  return commonEle
//}
//var a = [1,2,3]
//var b = [4,1,0]
//print(commonElementsSet(&a,&b))

/*
 Create a struct called Square that has a stored property called sideLength and a computed property called area. Create an instance of Square and print the area.
 */
struct Square {
  var sideLength: Int
  var area: Int {
    sideLength * sideLength
  }
}

let square = Square(sideLength: 10)
print(square.area)


//:Above and Beyond
/*
 Create a protocol called Shape with a calculateArea() -> Double method. Create two structs called Circle and Rectangle that conform to the protocol Shape. Both Circle and Rectangle should have appropriate stored properties for calculating the area.

 Create instances of Circle and Rectangle and print out the area for each.

 Next, extend the protocol Shape to add a new method called calculateVolume() -> Double.

 Finally, create a struct called Sphere that conforms to Shape. Sphere should have appropriate stored properties for calculating area and volume.

 Create an instance of Sphere and print the area and volume.
 */

protocol Shape{
  func calculateArea() -> Double
}
struct Circle: Shape {
  var radius: Double
  func calculateArea() -> Double {
    return 3.14 * pow(radius, 2)
  }
}
print(Circle(radius: 10).calculateArea())

struct Rectangle: Shape {
  var length: Double
  var width: Double
  func calculateArea() -> Double {
    return length * width
  }
}
print(Rectangle(length: 10, width: 10).calculateArea())

//Learning Note: extend a protocol to have a new method
protocol Extended : Shape {
  func calculateVolume() -> Double
}

struct Sphere: Extended {
  var radius: Double
  func calculateVolume() -> Double {
    return (Double(4) / Double(3)) * 3.14 * pow(radius, 3)
  }
  
  func calculateArea() -> Double {
    return Double(4) * 3.14 * pow(radius, 2)
  }
}

print(Sphere(radius: 10).calculateVolume())
print(Sphere(radius: 10).calculateArea())
