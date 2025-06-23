import SwiftUI

struct UniPickView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 0.93, green: 0.93, blue: 0.95)               .edgesIgnoringSafeArea(.all)
                
            VStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.secondary.opacity(0.8))
                        .clipShape(Circle())
                }
                .hAlign(.leading)
                .padding()
                Text("Select Your Place")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color(red: 0.10, green: 0.12, blue: 0.15))
            }
            .vAlign(.top)
        }
        .navigationTitle("Helo")
        .accentColor(Color(red: 0.10, green: 0.12, blue: 0.15))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    UniPickView()
}
