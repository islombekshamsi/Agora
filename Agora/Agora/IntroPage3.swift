/*import SwiftUI
import AVKit

struct IntroPage3: View {
    @State var page: Int = 2
    var body: some View {
        ZStack {
            FfullScreenVideoView(videoName: "ctour", videoType: "mp4")
                .ignoresSafeArea()
            Color.black.opacity(0.4)
                           .ignoresSafeArea()
            VStack{
                // App Title
                Text("Agora")
                    .font(.system(size: 72, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .padding(.top, 80)

                Spacer()

                // App Tagline
                Text("Join Agora. Your Campus. \nYour Marketplace.")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)

                // Get Started Button
                NavigationLink(destination: ChoosePage()) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .frame(width: 300, height: 56)
                        .overlay(
                            Text("Join Now")
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.black)
                        )
                }
                .padding(.top, 20)
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(index == page ? Color.white : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FfullScreenVideoView: UIViewControllerRepresentable {
    let videoName: String
    let videoType: String
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false // Hide controls
        
        if let path = Bundle.main.path(forResource: videoName, ofType: videoType) {
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            player.play() // Auto-play
            
            // Loop the video
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem,
                queue: .main
            ) { _ in
                player.seek(to: .zero)
                player.play()
            }

            controller.player = player
            
            // Ensure it scales properly
            controller.videoGravity = .resizeAspectFill
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

#Preview {
    IntroPage3()
}
*/
