import SwiftUI

struct ContentView: View {
    @State private var history = HistoryStore()
    @SceneStorage("selectedTab") private var selectedTab = 9
    
  var body: some View {
    ZStack {
        GradientBackground()
        TabView(selection: $selectedTab) {
            WelcomeView(history: history, selectedTab: $selectedTab).tag(9)
            ForEach(0 ..< Exercise.exercises.count) { index in
            ExerciseView(history: $history ,selectedTab: $selectedTab, index: index).tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear {
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
