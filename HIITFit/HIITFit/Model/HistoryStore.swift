import Foundation

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}

class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    
    enum FileError: Error {
        case loadFailure
        case saveFailure
        case urlFailure
    }
    
    init() {}
    init(withChecking: Bool) throws {
        #if DEBUG
//        createDevData()
        print("Initializing HistoryStore")
        #endif
        func load() throws {
            throw FileError.loadFailure
        }
        do {
            try load()
        } catch {
            throw error
        }
    }
    
    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        if let firstDate = exerciseDays.first?.date, today.isSameDay(as: firstDate) {
            print("Adding \(exerciseName)")
            exerciseDays[0].exercises.append(exerciseName)
        } else {
            exerciseDays.insert(ExerciseDay(date: today, exercises: [exerciseName]), at: 0)
        }
        print("History: ", exerciseDays)
    }
}

