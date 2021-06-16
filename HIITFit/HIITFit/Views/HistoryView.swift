import SwiftUI

struct HistoryView: View {
    @Binding var showHistory: Bool
    //let today = Date()
    //let yesterday = Date().addingTimeInterval(-86400)
    let history = HistoryStore()
//    let exercises1 = ["Squat", "Step Up", "Burpee", "Sun Salute"]
//    let exercises2 = ["Squat", "Step Up", "Burpee"]
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            Button(action: { showHistory.toggle() }) {
               Image(systemName: "xmark.circle")
            }.font(.title)
            .padding(.trailing)
            VStack {
                Text( NSLocalizedString("History", comment: "view user activity"))
                    .font(.title)
                    .padding()
                // Exercise history
                Form {
                    ForEach(history.exerciseDays) { day in
                        Section(
                            header:
                                Text(day.date.formatted(as: "MMMM d")).font(.headline)) {
                            ForEach(day.exercises, id: \.self) { exercise in
                                Text(exercise)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(showHistory: .constant(true))
    }
}
