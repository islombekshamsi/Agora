import SwiftUI

struct WelcomePage: View {
    var body: some View {
        NavigationStack{
            ZStack{
                /*Image("welcome_photo")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)*/
               //Color(red: 0.93, green: 0.93, blue: 0.95)
                Color(red: 0.20, green: 0.22, blue: 0.25) .edgesIgnoringSafeArea(.all) // #1A1E26
                VStack(alignment: .center){
                    Text("AGORA")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .kerning(15)
                        .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.95)) // #1A1E26)
                        .padding()
                        .padding(.leading, 15)
                    
                    Text("First ever college marketplace.")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.95))
                        .padding(.top, 230)
                        .hAlign(.leading)
                        .padding(.horizontal, 15)
                    Text("Connect. Buy. Sell.")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.95))
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                        .hAlign(.leading)
                    
                    NavigationLink {
                        UniPickView()
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.8), lineWidth: 1) // Use stroke for borders
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.secondary.opacity(0.8))
                            )
                            .frame(width: 350, height: 60)
                            .overlay(
                                Text("Get Started")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.top, 150)
                    Text("By signing up for Agora, you agree to our Terms of Service and Privacy Policy.")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.95))
                        .padding(.horizontal, 15)
                        .multilineTextAlignment(.center)
                        .padding(.top, 35)
                }
                .vAlign(.top)
            }
        }
    }
}

#Preview {
    WelcomePage()
}
