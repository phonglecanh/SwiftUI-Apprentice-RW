import SwiftUI

struct WelcomeView: View {
    let history: HistoryStore
    @State private var showHistory = false
    @Binding var selectedTab: Int
    
    var body: some View {
      GeometryReader { geometry in
        VStack {
          HeaderView(
            selectedTab: $selectedTab,
            titleText: "Welcome")
          Spacer()
          // container view
            ContainerView {
            VStack {
            WelcomeView.images
            WelcomeView.welcomeText
            getStartedButton
            Spacer()
            historyButton
        .sheet(isPresented: $showHistory) {
            HistoryView(history: history, showHistory: $showHistory)
                }
            }
        }.frame(height: geometry.size.height * 0.8)
      }
    }
}
    
    var getStartedButton: some View {
      RaisedButton(buttonText: "Get Started") {
        selectedTab = 0
      }
    .padding()
    }
    
    var historyButton: some View {
      Button(
        action: {
          showHistory = true
        }, label: {
          Text("History")
            .fontWeight(.bold)
            .padding([.leading, .trailing], 5)
        })
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle())
    }
}
    

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(history: HistoryStore(), selectedTab: .constant(0))
    }
}
