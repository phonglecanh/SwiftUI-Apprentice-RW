import SwiftUI

@main
struct HIITFitApp: App {
    @State private var showAlert = false
    @StateObject private var historyStore: HistoryStore
    init() {
        let historyStore: HistoryStore
        do {
            historyStore = try HistoryStore(withChecking: true)
        } catch {
           
            print("Could not load history store data")
            historyStore = HistoryStore()
            // showAlert = true
        }
        _historyStore = StateObject(wrappedValue: historyStore)
    }
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(historyStore)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("History"), message: Text(
                    """
 Unfortunately we can’t load your past history.
      Email support:
        support@xyz.com
"""))
        }
    }
  }
}
