import SwiftUI


struct ProductCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let itemCount: Int
    let isTrending: Bool
    let gradient: [Color]
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let image: String
}

struct ProductCard: View {
    
    
    let product: Product
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Product Image (Top Rounded Corners)
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
               .clipped()
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .onTapGesture {
                    onTap()
                }

            // Info Section
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text(product.price)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .bold()
                    Spacer()
                    Group {
                        Image(systemName: "message")
                        Image(systemName: "cart")
                    }
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color.white
                    .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                    .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 8)
            )
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

struct ZoomedProductView: View {
    let product: Product
    let onDismiss: () -> Void
    let randomText: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut nisl fermentum, sollicitudin nibh sit amet, luctus risus.  "
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        onDismiss()
                    }
                }
            
            VStack(spacing: 10) {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .transition(.scale)
                
                HStack() {
                    Text(product.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .hAlign(.leading)
                    
                    Text(product.price)
                        .font(.title)
                        .brightness(100)
                        .foregroundColor(.blue)
                        .bold()
                        .hAlign(.trailing)
                }
                .padding(.top, 20)
                .padding(.horizontal, 30)
                Text(randomText)
                    .font(.callout)
                    .foregroundColor(.white)
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 40)
                    .padding(.top, 40)
                
                HStack{
                    HStack(spacing: 20) {
                        Button(action: {}){
                            Image(systemName: "message")
                        }
                        Button(action: {}){
                            Image(systemName: "cart")
                        }
                    }
                    .font(.title)
                    .foregroundStyle(.white)
                    Spacer(minLength: 50)
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 80, height: 40)
                            .foregroundColor(.blue)
                            .overlay(
                                Text("Buy")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.white)
                            )
                    }
                }
                .padding(.top, 70)
                .padding(.horizontal, 40)
            }
            .vAlign(.top)
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        }
    }
}

struct marketplacepage: View {
    @State private var searchText = ""
    @State private var selectedCategory: ProductCategory?
    @State private var isLoading = false
    @State private var selectedProduct: Product?
    
    @State private var categories: [ProductCategory] = [
        ProductCategory(name: "Electronics", icon: "headphones", itemCount: 156, isTrending: true, gradient: [
            Color(red: 0.18, green: 0.29, blue: 0.72),
            Color(red: 0.29, green: 0.52, blue: 0.99),
            Color(red: 0.64, green: 0.82, blue: 1.0)
        ]),
        ProductCategory(name: "Bikes & Scooters", icon: "bicycle", itemCount: 89, isTrending: false, gradient: [
            Color(red: 0.2, green: 0.7, blue: 0.3),
            Color(red: 0.3, green: 0.8, blue: 0.4),
            Color(red: 0.4, green: 0.9, blue: 0.5)
        ]),
        ProductCategory(name: "Furniture", icon: "chair", itemCount: 203, isTrending: true, gradient: [
            Color(red: 0.8, green: 0.4, blue: 0.2),
            Color(red: 0.9, green: 0.5, blue: 0.3),
            Color(red: 1.0, green: 0.6, blue: 0.4)
        ]),
        ProductCategory(name: "Textbooks", icon: "book", itemCount: 312, isTrending: true, gradient: [
            Color(red: 0.5, green: 0.2, blue: 0.7),
            Color(red: 0.6, green: 0.3, blue: 0.8),
            Color(red: 0.7, green: 0.4, blue: 0.9)
        ]),
        ProductCategory(name: "Clothing & Shoes", icon: "tshirt", itemCount: 267, isTrending: true, gradient: [
            Color(red: 0.7, green: 0.2, blue: 0.5),
            Color(red: 0.8, green: 0.3, blue: 0.6),
            Color(red: 0.9, green: 0.4, blue: 0.7)
        ]),
        ProductCategory(name: "Requests", icon: "figure.wave", itemCount: 267, isTrending: false, gradient: [
            Color(red: 0.3, green: 0.2, blue: 0.8),
            Color(red: 0.2, green: 0.3, blue: 0.7),
            Color(red: 0.25, green: 0.4, blue: 0.7)
        ]),
        ProductCategory(name: "Lost and Found", icon: "questionmark.circle", itemCount: 267, isTrending: false, gradient: [
            Color(red: 0.7, green: 0.3, blue: 0.3),
            Color(red: 0.8, green: 0.3, blue: 0.3),
            Color(red: 0.7, green: 0.3, blue: 0.2)
        ]),
        ProductCategory(name: "Housing", icon: "house", itemCount: 267, isTrending: false, gradient: [
            Color(red: 0.2, green: 0.3, blue: 0.8),
            Color(red: 0.3, green: 0.3, blue: 0.9),
            Color(red: 0.1, green: 0.3, blue: 0.7)
        ])
    ]
    
    let products = [
        Product(name: "MacBook Pro 14\"", price: "$1,299", image: "minilogo"),
        Product(name: "iPhone 15 Pro", price: "$999", image: "minilogo"),
        Product(name: "AirPods Pro", price: "$249", image: "minilogo"),
        Product(name: "iPad Pro", price: "$799", image: "minilogo"),
        Product(name: "Apple Watch", price: "$399", image: "minilogo"),
        Product(name: "Mac Studio", price: "$1,999", image: "minilogo"),
        Product(name: "Studio Display", price: "$1,599", image: "minilogo"),
        Product(name: "Mac mini", price: "$599", image: "minilogo")
    ]

    var body: some View {
        ZStack {
            SexyBackgroundView()
                .ignoresSafeArea(.all)
                .blur(radius: 0)

            ScrollView {
                VStack(spacing: 10) {
                    // Top Header
                    HStack {
                        Text("Agora")
                            .font(.system(size: 45, weight: .semibold, design: .default))
                            .foregroundStyle(.black)
                            .hAlign(.leading)
                            .padding()
                        Image(systemName: "bell")
                            .padding()
                            .font(.system(size: 25, weight: .regular))
                            .accessibilityLabel("Notifications")
                        Image(systemName: "message")
                            .padding()
                            .font(.system(size: 25, weight: .regular))
                            .accessibilityLabel("Messages")
                    }

                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .accessibilityHidden(true)

                        TextField("Search the Agora", text: $searchText)
                            .foregroundColor(.primary)
                            .accessibilityLabel("Search products and categories")
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6))
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Popular Categories Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Popular Categories")
                            .font(.system(size: 35, weight: .semibold, design: .default))
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                            .padding(.top)
                            .padding(.bottom, 8)
                     
                            // Categories Grid/List
                            GeometryReader { geometry in
                                let isWideScreen = geometry.size.width > 600
                                
                                if isWideScreen {
                                    // Grid Layout for wider screens
                                    LazyVGrid(columns: [
                                        GridItem(.adaptive(minimum: 180, maximum: 200), spacing: 16)
                                    ], spacing: 16) {
                                        ForEach(categories) { category in
                                            CategoryCard(
                                                category: category,
                                                gradient: category.gradient,
                                                isSelected: selectedCategory?.id == category.id
                                            )
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                } else {
                                    // Horizontal Scroll for narrow screens
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 16) {
                                            ForEach(categories) { category in
                                                CategoryCard(
                                                    category: category,
                                                    gradient: category.gradient,
                                                    isSelected: selectedCategory?.id == category.id
                                                )
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                    }
                                }
                            }
                            .frame(height: 140)
                        }
                    
                    .padding(.top, 10)
                    
                    // Products Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Featured Products")
                            .font(.system(size: 35, weight: .bold, design: .default))
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        // 2-column grid layout
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(products) { product in
                                ProductCard(product: product) {
                                    withAnimation(.easeInOut) {
                                        selectedProduct = product
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 20)
                }
            }
            
            // Zoomed Product Overlay
            if let product = selectedProduct {
                ZoomedProductView(product: product) {
                    withAnimation(.easeInOut) {
                        selectedProduct = nil
                    }
                }
            }
        }
        .onAppear {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isLoading = false
            }
        }
    }
}

struct CategoryCard: View {
    let category: ProductCategory
    let gradient: [Color]
    let isSelected: Bool
    @State private var isPressed = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background Gradient Card
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 180, height: 120)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 6)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
                )

            // Content
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    // Icon
                    Image(systemName: category.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Trending Badge
                    if category.isTrending {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                            .font(.system(size: 14))
                    }
                }
                
                // Category Name
                Text(category.name)
                    .foregroundColor(.white)
                    .font(.headline)
                
                // Item Count
                Text("\(category.itemCount) items")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.subheadline)
            }
            .padding(.leading, 16)
            .padding(.top, 16)
            .padding(.trailing, 16)
        }
        .onTapGesture {
            isPressed = true
            // Add haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            // Reset after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(category.name) category with \(category.itemCount) items")
        .accessibilityHint(category.isTrending ? "Trending category. Double tap to select." : "Double tap to select.")
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    marketplacepage()
}
