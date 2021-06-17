import SwiftUI
import AVKit

struct ExerciseView: View {
    @Binding var history: HistoryStore
    @State private var rating = 0
    @Binding var selectedTab: Int
    @State private var showHistory = false
    @State private var showSuccess = false
    let index: Int
    @State private var timerDone = false
    @State private var showTimer  = false
    
    
    var lastExercise: Bool {
        index + 1  == Exercise.exercises.count
    }
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab, titleText: Exercise.exercises[index].exerciseName)
                    .padding(.bottom)
                if let url = Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: geometry.size.height * 0.45)
                } else {
                    Text("Couldn't find \(Exercise.exercises[index].videoName).mp4")
                }
                HStack(spacing: 150) {
                    Button("Start Exercise") {
                        showTimer.toggle()
                    }
                    Button("Done") {
                        history.addDoneExercise(Exercise.exercises[index].exerciseName)
                        timerDone = true
                        showTimer.toggle()
                        if lastExercise {
                            showSuccess.toggle()
                        } else {
                            selectedTab += 1
                        }
                    }
                    .disabled(!timerDone)
                    .sheet(isPresented: $showSuccess) {
                        SuccessView(selectedTab: $selectedTab)
                    }
                }.font(.title3)
                 .padding()
                if showTimer {
                    TimerView(timerDone: $timerDone)
                }
                Spacer()
                RatingView(rating: $rating).padding()
                Button("History") {
                  showHistory.toggle()
                }
                .sheet(isPresented: $showHistory) {
                    HistoryView(history: history, showHistory: $showHistory)
                }
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(history: .constant(HistoryStore()), selectedTab: .constant(0), index: 0)
    }
}
