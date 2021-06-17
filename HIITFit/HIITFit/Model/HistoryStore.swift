import Foundation

struct ExerciseDay: Identifiable {
  let id = UUID()
  let date: Date
  var exercises: [String] = []
}

class HistoryStore: ObservableObject {
  // swiftlint:disable:next array_constructor
  @Published var exerciseDays: [ExerciseDay] = []

  enum FileError: Error {
    case loadFailure
    case saveFailure
    case urlFailure
  }

  init() {}

  init(withChecking: Bool) throws {
    #if DEBUG
    // createDevData()
    #endif
    do {
      try load()
    } catch {
      throw error
    }
  }

  func getURL() -> URL? {
    guard let documentsURL = FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    return documentsURL.appendingPathComponent("history.plist")
  }

  func load() throws {
    guard let dataURL = getURL() else {
      throw FileError.urlFailure
    }
    guard let data = try? Data(contentsOf: dataURL) else {
      return
    }
    let plistData = try PropertyListSerialization.propertyList(
      from: data,
      options: [],
      format: nil)
    let convertedPlistData = plistData as? [[Any]] ?? []
    exerciseDays = convertedPlistData.map {
      ExerciseDay(
        date: $0[1] as? Date ?? Date(),
        exercises: $0[2] as? [String] ?? [])
    }
  }

  func save() throws {
    guard let dataURL = getURL() else {
      throw FileError.urlFailure
    }
    let plistData = exerciseDays.map {
      [$0.id.uuidString, $0.date, $0.exercises]
    }
    do {
      let data = try PropertyListSerialization.data(
        fromPropertyList: plistData,
        format: .binary,
        options: .zero)
      try data.write(to: dataURL, options: .atomic)
    } catch {
      throw FileError.saveFailure
    }
  }

  func addDoneExercise(_ exerciseName: String) {
    let today = Date()
    if let firstDate = exerciseDays.first?.date,
      today.isSameDay(as: firstDate) {
      exerciseDays[0].exercises.append(exerciseName)
    } else {
      exerciseDays.insert(
        ExerciseDay(date: today, exercises: [exerciseName]),
        at: 0)
    }
    do {
      try save()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}

