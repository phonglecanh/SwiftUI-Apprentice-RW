import SwiftUI
import AVKit

struct ExerciseView: View {
    @State private var rating = 0
    @Binding var selectedTab: Int
    @State private var showHistory = false
    @State private var showSuccess = false
    let index: Int
    let interval: TimeInterval = 30
    var lastExercise: Bool {
        index + 1  == Exercise.exercises.count
    }
    var body: some View {
        GeometryReader { geometry in
            VStack {
//                HeaderView(titleText: Exercise.exercises[index].exerciseName)
                HeaderView(selectedTab: $selectedTab, titleText: Exercise.exercises[index].exerciseName)
                    .padding(.bottom)
                if let url = Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: geometry.size.height * 0.45)
                } else {
                    Text("Couldn't find \(Exercise.exercises[index].videoName).mp4")
                }
                Text(Date().addingTimeInterval(interval), style: .timer)
                    .font(.system(size: 90))
//                Button(NSLocalizedString(
//                            "Start/Done",
//                            comment: "begin exercise / mark as finished")) { }
//                    .font(.title3)
//                    .padding()
                HStack(spacing: 150) {
                    Button("Start Exercise") { }
//                    Button("Done") {
//                        selectedTab = lastExercise ? 9 : selectedTab + 1
//                    }
                    Button("Done") {
                        if lastExercise {
                            showSuccess.toggle()
                        } else {
                            selectedTab += 1
                        }
                    }
                    .sheet(isPresented: $showSuccess) {
                        SuccessView(selectedTab: $selectedTab)
                    }
                }.font(.title3)
                 .padding()
                RatingView(rating: $rating)
                Spacer()
//                Button( NSLocalizedString("History", comment: "view user activity")) {}
//                    .padding(.bottom)
                Button("History") {
                  showHistory.toggle()
                }
                .sheet(isPresented: $showHistory) {
                  HistoryView(showHistory: $showHistory)
                }
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(3), index: 3)
    }
}
