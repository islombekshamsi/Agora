import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isZoomed = false
    
    init() {
        // Hide the default tab bar
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                marketplacepage(isZoomed: $isZoomed)
                    .tag(0)
                
    
                
                postpage()
                    .tag(1)
                
                
                accountpage()
                    .tag(2)
            }
            
            // Custom Floating Tab Bar
            HStack(spacing: 0) {
                ForEach(0..<3) { index in
                    Button(action: {
                        withAnimation(.bouncy(duration: 0.2)) {
                            selectedTab = index
                        }
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: tabIcons[index])
                                .font(.system(size: 24, weight: selectedTab == index ? .regular : .regular))
                                .foregroundColor(selectedTab == index ? .indigo : .secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                ZStack {
                    // Blur background
                    BlurView(style: .systemUltraThinMaterial)
                    
                    // White overlay with opacity
                    Color.white.opacity(0.2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .zIndex(isZoomed ? -1 : 0)
            .opacity(isZoomed ? 0 : 1)
            .animation(.easeInOut(duration: 0.3), value: isZoomed)
        }
    }
    
    private let tabIcons = ["storefront", "plus.app.fill","person.fill"]
}

// Blur View for iOS
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct PageView: View {
    var title: String
    var nextPage: Int
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            
            NavigationLink(destination: PageView(title: "Page \(nextPage + 1)", nextPage: nextPage + 1)) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
