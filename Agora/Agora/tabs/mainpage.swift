import SwiftUI

struct mainpage: View {
    var body: some View {
        ZStack {
            // ✨ Sexy Background
            SexyBackgroundView()
                .ignoresSafeArea()

            // 🔘 Main App Tabs
            TabView {
                marketplacepage()
                    .tabItem {
                        Image(systemName: "storefront")
                    }

                postpage()
                    .tabItem {
                        Image(systemName: "message")
                    }

                addpage()
                    .tabItem {
                        Image(systemName: "plus")
                    }

                cartpage()
                    .tabItem {
                        Image(systemName: "cart")
                    }

                accountpage()
                    .tabItem {
                        Image(systemName: "person.circle")
                    }

            }
            
            
            
        }
    }
}

struct addpage: View {
    var body: some View {
        Text("Add Page")
    }
}

struct HarvardBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.75, green: 0.25, blue: 0.25), // Softer Crimson
                Color(red: 0.95, green: 0.85, blue: 0.8)   // Creamy Beige
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .overlay(
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.1),
                    Color.clear
                ]),
                center: .center,
                startRadius: 100,
                endRadius: 600
            )
        )
    }
}

#Preview {
    mainpage()
}


extension View{
    // MARK: Disabling with opacity
    func disableWithOpacity(_ condition: Bool)-> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
    func hAlign(_ alignment: Alignment)-> some View{
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)-> some View{
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func border(_ width: CGFloat, _ color: Color)-> some View{
        self
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background{
            RoundedRectangle(cornerRadius: 5, style: . continuous)
                .stroke(color, lineWidth: width)
        }
    }
    
    func fillView(_ color: Color)-> some View{
        self
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background{
            RoundedRectangle(cornerRadius: 5, style: . continuous)
                .fill(color)
        }
    }
}
