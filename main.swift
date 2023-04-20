import Foundation

struct Args {
  var upper: Int = 100
  var showResult: Bool = false
}

func showResult(numbers: [Int], args: Args) {
  print(numbers.count)
  if args.showResult {
    print(numbers)
  }
}

func isPrimeNumber(n: Int, primeNumbers: [Int]) -> Bool {
  for primeNumber in primeNumbers {
    if primeNumber * primeNumber > n {
      return true
    }
    if n % primeNumber == 0 {
      return false
    }
  }
  return true
}

func parseArgs(argArr: [String]) -> Args {
  var idx = 0
  var args = Args()

  func isEnd() -> Bool {
    return idx >= argArr.count
  }

  func loadNext() {
    idx += 1
  }

  func ref() -> String {
    return argArr[idx]
  }

  func refAsInt() -> Int {
    return Int(ref())!
  }

  while !isEnd() {
    switch ref() {
    case "-u", "--upper-limit":
      loadNext()
      args.upper = refAsInt()
    case "-s", "--show":
      args.showResult = true
    default:
      break
    }
    loadNext()
  }
  return args
}

func main(argArr: [String]) {
  let startTime = CFAbsoluteTimeGetCurrent()

  var primeNumbers = [2, 3]
  let args = parseArgs(argArr: argArr)
  print("Upper bound: \(args.upper)")

  var n = 5
  while n < args.upper {
    if isPrimeNumber(n: n, primeNumbers: primeNumbers) {
      primeNumbers.append(n)
    }
    n += 2
  }

  showResult(numbers: primeNumbers, args: args)
  
  let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
  print("Time: \(timeElapsed)")
}

let argArr = CommandLine.arguments
main(argArr: Array(argArr.dropFirst()))
