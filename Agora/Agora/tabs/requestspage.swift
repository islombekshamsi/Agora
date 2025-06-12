import SwiftUI

struct Request: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let category: String
    let budget: String
    let timestamp: Date
    let user: String
}

struct RequestCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

struct requestspage: View {
    @State private var selectedCategory: String = "All"
    @State private var isCreatingRequest = false
    @State private var searchText = ""
    
    let categories = [
        RequestCategory(name: "All", icon: "square.grid.2x2"),
        RequestCategory(name: "Electronics", icon: "iphone"),
        RequestCategory(name: "Fashion", icon: "tshirt"),
        RequestCategory(name: "Home", icon: "house"),
        RequestCategory(name: "Sports", icon: "figure.run"),
        RequestCategory(name: "Books", icon: "book"),
        RequestCategory(name: "Other", icon: "ellipsis")
    ]
    
    let sampleRequests = [
        Request(title: "Looking for iPhone 13 Pro", 
                description: "Must be in good condition, preferably with box and accessories",
                category: "Electronics",
                budget: "$800",
                timestamp: Date(),
                user: "John D."),
        Request(title: "Vintage Denim Jacket", 
                description: "Looking for a Levi's jacket from the 90s, size M",
                category: "Fashion",
                budget: "$150",
                timestamp: Date().addingTimeInterval(-3600),
                user: "Sarah M."),
        Request(title: "Gaming Laptop", 
                description: "Need a gaming laptop for college, budget flexible",
                category: "Electronics",
                budget: "$1200",
                timestamp: Date().addingTimeInterval(-7200),
                user: "Mike R.")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                SexyBackgroundView()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search requests...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Categories ScrollView
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(categories) { category in
                                CategoryButton(
                                    category: category,
                                    isSelected: selectedCategory == category.name,
                                    action: { selectedCategory = category.name }
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    }
                    
                    // Requests List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(sampleRequests) { request in
                                RequestCard(request: request)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Requests")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isCreatingRequest = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $isCreatingRequest) {
                CreateRequestView()
            }
        }
    }
}

struct CategoryButton: View {
    let category: RequestCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: category.icon)
                    .font(.title2)
                Text(category.name)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .blue : .gray)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.blue.opacity(0.1) : Color.white)
            )
        }
    }
}

struct RequestCard: View {
    let request: Request
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(request.title)
                    .font(.headline)
                Spacer()
                Text(request.budget)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .bold()
            }
            
            Text(request.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            HStack {
                Label(request.category, systemImage: "tag")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Label(request.user, systemImage: "person")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct CreateRequestView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var category = "Electronics"
    @State private var budget = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Request Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    Picker("Category", selection: $category) {
                        Text("Electronics").tag("Electronics")
                        Text("Fashion").tag("Fashion")
                        Text("Home").tag("Home")
                        Text("Sports").tag("Sports")
                        Text("Books").tag("Books")
                        Text("Other").tag("Other")
                    }
                    TextField("Budget", text: $budget)
                }
            }
            .navigationTitle("New Request")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        // Handle request creation
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    requestspage()
} 
