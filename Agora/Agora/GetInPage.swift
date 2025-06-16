import SwiftUI
import AVKit

struct GetInPage: View {
    @Environment(\..presentationMode) var presentationMode
    @State var email: String = ""
    @State var password: String = ""
    @State private var isSecured: Bool = true

    @Binding var selectedUniversitySuffix: String

    @State private var isButtonShaking = false
    @State private var showErrorText = false
    @State private var buttonColor = Color.black
    @State private var shakeOffset: CGFloat = 0

    var body: some View {
        ZStack {
            FffullScreenVideoView(videoName: "choosepage", videoType: "mp4")
                .ignoresSafeArea()
            Color.black.opacity(0.15)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Let's Sign You In")
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .padding(.top, 60)

                    Text("Welcome back! \nYou have been missed!")
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                .padding(.horizontal, 30)

                Spacer()

                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .padding(.horizontal, 30)

                    ZStack {
                        HStack {
                            Group {
                                if isSecured {
                                    SecureField("Password", text: $password)
                                        .font(.system(size: 18, weight: .light, design: .serif))

                                } else {
                                    TextField("Password", text: $password)
                                        .font(.system(size: 18, weight: .light, design: .serif))

                                }
                            }
                            .padding(.leading, 15)
                            .autocapitalization(.none)
                            .frame(height: 50)

                            Button(action: {
                                isSecured.toggle()
                            }) {
                                Image(systemName: isSecured ? "eye.slash" : "eye")
                                    .foregroundColor(.black)
                                    .padding(.trailing, 15)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    }

                    Button("Reset password?", action: resetPassword)
                        .font(.callout)
                        .fontWeight(.medium)
                        .tint(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 10)

                Button(action: loginUser) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .frame(width: 300, height: 60)
                        .background(Color.black)
                        .frame(width: 300, height: 60)
                        .cornerRadius(10)
                        .hAlign(.center)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 10)

                Button(action: {
                    if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !email.lowercased().hasSuffix(selectedUniversitySuffix.lowercased()) {
                        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(5, autoreverses: true)) {
                            shakeOffset = -5
                        }
                        buttonColor = .red
                        showErrorText = true

                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                shakeOffset = 0
                                buttonColor = .black
                                showErrorText = false
                            }
                        }

                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.error)
                    } else {
                        buttonColor = .black
                        showErrorText = false
                        onSave()
                    }
                }) {
                    Text("Confirm")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold, design: .serif))
                        .frame(width: 250, height: 70)
                        .background(buttonColor)
                        .cornerRadius(50)
                        .shadow(radius: 5)
                        .offset(x: shakeOffset)
                }
                .padding(.top, 30)
                .frame(maxWidth: .infinity, alignment: .center)

                if showErrorText {
                    Text("Wrong Email Format")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                }

                Spacer()
            }
        }
        .accentColor(.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .resizable()
                .frame(width: 15, height: 28)
                .foregroundStyle(.white)
                .padding()
        })
    }

    func onSave() {
        print("Email confirmed: \(email)")
    }

    func resetPassword() {
        // Add password reset logic
    }

    func loginUser() {
        // Add login logic
    }
}

#Preview {
    GetInPage(selectedUniversitySuffix: .constant("@psu.edu"))
}
