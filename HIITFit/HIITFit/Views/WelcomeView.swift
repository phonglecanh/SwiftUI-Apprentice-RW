import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            VStack {
                HeaderView(titleText: "Welcome")
                Spacer()
                Button("History") { }
                    .padding(.bottom)
            }
            VStack {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Get fit").font(.largeTitle)
                        Text("with high intensity interval training")
                               .font(.headline)
                    }
                    Image("step-up")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 240.0, height: 240.0)
                        .resizedToFill(width: 240, height: 240)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
                Button(action: {}) {
                    Text("Get stared")
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
        WelcomeView()
    }
}
