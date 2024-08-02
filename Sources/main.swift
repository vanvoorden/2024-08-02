import Foundation
import SwiftData

//  https://forums.developer.apple.com/forums/thread/734540

//  https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package

@Model final public class Item {
  var timestamp: Date
  
  public init(timestamp: Date = .now) {
    self.timestamp = timestamp
  }
}

func testDelete() throws {
  let schema = Schema([Item.self])
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try ModelContainer(
    for: schema,
    configurations: configuration
  )
  let modelContext = ModelContext(container)
  modelContext.insert(Item())
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 1)
  try modelContext.delete(model: Item.self)
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 0)
}

func testDeleteAndSave() throws {
  let schema = Schema([Item.self])
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try ModelContainer(
    for: schema,
    configurations: configuration
  )
  let modelContext = ModelContext(container)
  modelContext.insert(Item())
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 1)
  try modelContext.delete(model: Item.self)
  try modelContext.save()
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 0)
}

func testDeleteWithIteration() throws {
  let schema = Schema([Item.self])
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try ModelContainer(
    for: schema,
    configurations: configuration
  )
  let modelContext = ModelContext(container)
  modelContext.insert(Item())
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 1)
  for model in try modelContext.fetch(FetchDescriptor<Item>()) {
    modelContext.delete(model)
  }
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 0)
}

func testDeleteWithIterationAndSave() throws {
  let schema = Schema([Item.self])
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try ModelContainer(
    for: schema,
    configurations: configuration
  )
  let modelContext = ModelContext(container)
  modelContext.insert(Item())
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 1)
  for model in try modelContext.fetch(FetchDescriptor<Item>()) {
    modelContext.delete(model)
  }
  try modelContext.save()
  print(try modelContext.fetchCount(FetchDescriptor<Item>()) == 0)
}

func main() throws {
  try testDelete()
  try testDeleteAndSave()
  try testDeleteWithIteration()
  try testDeleteWithIterationAndSave()
}

try main()
//  true
//  false
//  true
//  false
//  true
//  true
//  true
//  true
