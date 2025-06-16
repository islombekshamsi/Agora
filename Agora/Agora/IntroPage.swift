import SwiftUI
import AVKit

struct IntroPage: View {
    @State private var currentPage = 0 // Track the current intro page
    
    var body: some View {
        NavigationStack { // Wrap everything in NavigationStack
        ZStack {
            Color.black.ignoresSafeArea() // Ensure background is always black
            
            TabView(selection: $currentPage) {
                // Page 1
                IntroPage1View(currentPage: $currentPage)
                    .tag(0)
                
                // Page 2
                IntroPage2View(currentPage: $currentPage)
                    .tag(1)
                
                // Page 3
                IntroPage3View(currentPage: $currentPage)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default dots
            .ignoresSafeArea()
            .background(Color.black.ignoresSafeArea())
            .animation(.easeInOut(duration: 0.3), value: currentPage) // Smooth swiping animation
            .gesture(
                DragGesture().onEnded { value in
                    if value.translation.width > 0 && currentPage == 0 {
                        currentPage = 0 // Prevent swipe right on first page
                    } else if value.translation.width < 0 && currentPage == 2 {
                        currentPage = 2 // Prevent swipe left on last page
                    }
                }
            )
        }
        }
    }
}

// MARK: - Page 1 View
struct IntroPage1View: View {
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack {
            BackgroundVideoView(videoName: "clstudents", videoType: "mp4")
                .ignoresSafeArea()
            
            // Dark overlay for better contrast
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack {
                // App Title at the Top
                Text("Agora")
                    .font(.system(size: 72, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .padding(.top, 40) // Reduced top padding

                Spacer() // Push content to the bottom

                // App Tagline
                Text("Welcome to Agora!\nFirst ever college marketplace that is not boring!")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)

                // Get Started Button
                Button(action: {
                    // Manually update the current page
                    currentPage = 1
                }) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .frame(width: 300, height: 56)
                        .overlay(
                            Text("Get Started")
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.black)
                        )
                }
                .padding(.top, 20)

                // Interactive Dot Indicator
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.white : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 20) // Space between button and dots
                .padding(.bottom, 80) // Space at the bottom

                            }
        }
    }
}

// MARK: - Page 2 View
struct IntroPage2View: View {
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack {
            BackgroundVideoView(videoName: "clstudents1", videoType: "mp4")
                .ignoresSafeArea()
            
            // Dark overlay for better contrast
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                // App Title at the Top
                Text("Agora")
                    .font(.system(size: 72, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .padding(.top, 40) // Reduced top padding

                Spacer() // Push content to the bottom

                // App Tagline
                Text("College exclusive marketplace where you can buy and sell anything you need!")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                
                // Get Started Button
                Button(action: {
                    // Manually update the current page
                    currentPage = 2
                }) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .frame(width: 300, height: 56)
                        .overlay(
                            Text("Get Started")
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.black)
                        )
                }
                .padding(.top, 20)

                // Page Indicator Dots
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.white : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 20) // Space between button and dots
                .padding(.bottom, 80) // Space at the bottom
            }
        }
    }
}

// MARK: - Page 3 View
struct IntroPage3View: View {
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack {
            BackgroundVideoView(videoName: "ctour", videoType: "mp4")
                .ignoresSafeArea()
            
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                // App Title at the Top
                Text("Agora")
                    .font(.system(size: 72, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .padding(.top, 40) // Reduced top padding

                Spacer() // Push content to the bottom

                // App Tagline
                Text("Join Agora. Your Campus. \nYour Marketplace.")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)

                // Join Now Button
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

                // Page Indicator Dots
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.white : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 20) // Space between button and dots
                .padding(.bottom, 80) // Space at the bottom
            }
        }
    }
}

// MARK: - BackgroundVideoView
struct BackgroundVideoView: UIViewControllerRepresentable {
    let videoName: String
    let videoType: String

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let playerLayer = AVPlayerLayer()

        if let path = Bundle.main.path(forResource: videoName, ofType: videoType) {
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            player.isMuted = true
            player.play()
            player.actionAtItemEnd = .none // Ensures looping behavior

            // Loop the video
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem,
                queue: .main
            ) { _ in
                player.seek(to: .zero)
                player.play()
            }

            playerLayer.player = player
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.frame = controller.view.bounds
            controller.view.layer.addSublayer(playerLayer)
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - Preview
#Preview {
    IntroPage()
}
