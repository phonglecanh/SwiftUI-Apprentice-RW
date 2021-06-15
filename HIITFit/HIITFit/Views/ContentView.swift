import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
        WelcomeView()
        ForEach(0..<4) { number in
            ExerciseView(index: number)
    }
        Text("Ex 2")
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}