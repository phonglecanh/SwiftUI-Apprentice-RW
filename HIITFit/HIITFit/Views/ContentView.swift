import SwiftUI

struct ContentView: View {
    @State private var history = HistoryStore()
    @State private var selectedTab = 9
    
  var body: some View {
    TabView(selection: $selectedTab) {
        WelcomeView(history: history, selectedTab: $selectedTab).tag(9)
        ForEach(0 ..< Exercise.exercises.count) { index in
        ExerciseView(history: $history ,selectedTab: $selectedTab, index: index).tag(index)
        }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
