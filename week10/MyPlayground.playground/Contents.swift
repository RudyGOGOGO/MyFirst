import Foundation

extension String: Error { }

struct CatFactResp: Codable {
  let fact: String
  let length: Int
}

struct CatFactsIter: AsyncIteratorProtocol {
  private let decoder = JSONDecoder()
  private let url = URL(string: "https://catfact.ninja/fact")!
  private var leftNum: Int
  init(total: Int) {
    self.leftNum = total
  }
  mutating func next() async throws -> CatFactResp? {
    guard leftNum > 0 else {
      return nil
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error: " + response.description
    }
    let factResp = try decoder.decode(CatFactResp.self, from: data)
    leftNum -= 1
    return factResp
  }
}

struct CatFactsSeq: AsyncSequence {
  typealias Element = CatFactResp
  typealias AsyncIterator = CatFactsIter
  let total: Int
  init(total: Int) {
    self.total = total
  }
  func makeAsyncIterator() -> CatFactsIter {
    return CatFactsIter(total: total)
  }
}

func getCatFacts(num: Int) async throws -> [String] {
  var facts: [String] = []
  var iter = CatFactsIter(total: num)
  while let fact = try await iter.next() {
    facts.append(fact.fact)
  }
  return facts
}

Task {
  let facts: [String] = try await getCatFacts(num: 20)
  print(facts)
}

