import SwiftUI

struct HeaderView: View {
    let exerciseNames: String
    var body: some View {
        VStack {
           Text(exerciseNames)
                .font(.largeTitle)
            HStack {
                Image(systemName: "1.circle")
                Image(systemName: "2.circle")
                Image(systemName: "3.circle")
                Image(systemName: "4.circle")
            }.font(.title2)
        }
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(exerciseNames: "Squat")
                .previewLayout(.sizeThatFits)
            HeaderView(exerciseNames: "Squat")
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityLarge)
                .previewLayout(.sizeThatFits)
        }
    }
}
