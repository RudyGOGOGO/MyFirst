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

