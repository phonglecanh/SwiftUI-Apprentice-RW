import SwiftUI

struct WelcomeView: View {
    let history: HistoryStore
    @State private var showHistory = false
    @Binding var selectedTab: Int
    var body: some View {
        ZStack {
            VStack {
//                HeaderView(titleText: NSLocalizedString("Welcome", comment: "greeting"))
                HeaderView(selectedTab: $selectedTab, titleText: "Welcome")
                Spacer()
//                Button(NSLocalizedString("History", comment: "view user activity")) { }
                Button("History") {
                    showHistory.toggle()
                }
                .sheet(isPresented: $showHistory) {
                    HistoryView(history: history, showHistory: $showHistory)
                }
                    .padding(.bottom)
            }
            VStack {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(NSLocalizedString("Get Fit", comment: "invitation to exercise")).font(.largeTitle)
                        Text("with high intensity interval training")
                               .font(.headline)
                    }
                    Image("step-up")
                        .resizedToFill(width: 240, height: 240)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
                Button(action: {selectedTab = 0}) {
                    Text(NSLocalizedString("Get Started", comment: "invitation"))
                    Image(systemName: "arrow.right.circle")
                }
                .font(.title2)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2))
                
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(history: HistoryStore(), selectedTab: .constant(0))
    }
}
