import PhotosUI
import Storage
import Supabase
import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var username = ""
    @State var fullName = ""
    @State var bio = ""
    @State var isLoading = false
    @State var imageSelection: PhotosPickerItem?
    @State var avatarImage: AvatarImage?
    @State private var animateContent = false
    @State private var bioCharWiggle = false
    @State private var bioCharWiggleAmount: CGFloat = 0
    @FocusState private var bioFieldFocused: Bool
    @State private var croppingError: String? = nil
    @State private var avatarUIImage: UIImage? = nil
    @State private var avatarZoom: CGFloat = 1.0
    @State private var avatarLastZoom: CGFloat = 1.0
    @State private var avatarOffset: CGSize = .zero
    @State private var avatarLastOffset: CGSize = .zero
    var onProfileComplete: (() -> Void)? = nil
    
    // Design system colors
    let backgroundColor = Color(red: 0.93, green: 0.93, blue: 0.95)
    let textColor = Color(red: 0.20, green: 0.22, blue: 0.25)
    let cardColor = Color.white
    let accentColor = Color.blue
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 20) {
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(textColor)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .clipShape(Circle())
                                        .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
                                }
                                Spacer()
                            }
                            VStack(spacing: 12) {
                                Text("Profile Setup")
                                    .font(.system(size: 32, weight: .bold))
                                    .kerning(-0.5)
                                    .foregroundColor(textColor)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("Complete your profile to continue")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(textColor.opacity(0.7))
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(.horizontal)
                        .opacity(animateContent ? 1.0 : 0.0)
                        .offset(y: animateContent ? 0 : -30)
                       // Spacer().frame(height: 8)
                        // Profile Card
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(spacing: 16) {
                                ZStack {
                                    if let avatarUIImage {
                                        GeometryReader { geo in
                                            Image(uiImage: avatarUIImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 80, height: 80)
                                                .scaleEffect(avatarZoom)
                                                .offset(avatarOffset)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(accentColor.opacity(0.2), lineWidth: 2))
                                                .gesture(
                                                    SimultaneousGesture(
                                                        MagnificationGesture()
                                                            .onChanged { value in
                                                                avatarZoom = avatarLastZoom * value
                                                            }
                                                            .onEnded { _ in
                                                                avatarLastZoom = avatarZoom
                                                            },
                                                        DragGesture()
                                                            .onChanged { value in
                                                                avatarOffset = CGSize(width: avatarLastOffset.width + value.translation.width, height: avatarLastOffset.height + value.translation.height)
                                                            }
                                                            .onEnded { _ in
                                                                avatarLastOffset = avatarOffset
                                                            }
                                                    )
                                                )
                                        }
                                        .frame(width: 80, height: 80)
                                    } else if let avatarImage {
                                        avatarImage.image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(accentColor.opacity(0.2), lineWidth: 2))
                                    } else {
                                        Circle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                            .overlay(Image(systemName: "person.crop.circle.fill").font(.system(size: 36)).foregroundColor(.gray.opacity(0.5)))
                                    }
                                }
                                PhotosPicker(selection: $imageSelection, matching: .images) {
                                    Text("Choose Photo")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(accentColor)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(accentColor.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            if let croppingError = croppingError {
                                Text(croppingError)
                                    .foregroundColor(.red)
                                    .font(.system(size: 14, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 4)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(textColor.opacity(0.8))
                                        .font(.system(size: 16, weight: .medium))
                                    Text("Username")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(textColor)
                                }
                                TextField("Enter your username", text: $username)
                                    .textContentType(.username)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .foregroundColor(textColor)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(12)
                                    .background(cardColor)
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                            }
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "person.text.rectangle")
                                        .foregroundColor(textColor.opacity(0.8))
                                        .font(.system(size: 16, weight: .medium))
                                    Text("Full Name")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(textColor)
                                }
                                TextField("Enter your full name", text: $fullName)
                                    .textInputAutocapitalization(.words)
                                    .textContentType(.name)
                                    .foregroundColor(textColor)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(12)
                                    .background(cardColor)
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                            }
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "link")
                                        .foregroundColor(textColor.opacity(0.8))
                                        .font(.system(size: 16, weight: .medium))
                                    Text("Bio")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(textColor)
                                    Spacer()
                                    Text("\(bio.count)/200")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(bio.count >= 200 ? .red : textColor.opacity(0.8))
                                        .offset(x: bioCharWiggleAmount)
                                        .animation(.interpolatingSpring(stiffness: 400, damping: 5), value: bioCharWiggleAmount)
                                }
                                TextField("Enter your bio (optional)", text: Binding(
                                    get: { bio },
                                    set: { newValue in
                                        if newValue.count <= 200 {
                                            bio = newValue
                                        } else if bio.count < 200 {
                                            // Only trigger on the first attempt to go over
                                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                                            generator.impactOccurred()
                                            withAnimation {
                                                bioCharWiggleAmount = 0
                                            }
                                            withAnimation(.interpolatingSpring(stiffness: 400, damping: 5)) {
                                                bioCharWiggleAmount = 20
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                withAnimation {
                                                    bioCharWiggleAmount = -20
                                                }
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                withAnimation {
                                                    bioCharWiggleAmount = 0
                                                }
                                            }
                                        }
                                        // Do not allow any more typing
                                    }
                                ), axis: .vertical)
                                    .focused($bioFieldFocused)
                                    .textInputAutocapitalization(.never)
                                    .foregroundColor(textColor)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(12)
                                    .frame(minHeight: 100, alignment: .top)
                                    .background(cardColor)
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                                
                                if bioFieldFocused {
                                    HStack {
                                        Spacer()
                                        Button("Done") {
                                            bioFieldFocused = false
                                        }
                                        .font(.system(size: 16, weight: .semibold))
                                        .padding(.top, 4)
                                        .padding(.trailing, 4)
                                    }
                                }
                            }
                        }
                        .padding(20)
                        .background(cardColor)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                        .padding(.horizontal)
                        .animation(.none, value: animateContent)
                        
                        // Update Button
                        Button(action: {
                            updateProfileButtonTapped()
                        }) {
                            HStack(spacing: 12) {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                } else {
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                                Text("Update Profile")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(red: 0.20, green: 0.22, blue: 0.25))
                            )
                            .shadow(color: Color(red: 0.20, green: 0.22, blue: 0.25).opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .disabled(isLoading || username.isEmpty || fullName.isEmpty)
                        .opacity((isLoading || username.isEmpty || fullName.isEmpty) ? 0.6 : 1.0)
                        .padding(.horizontal)
                        .opacity(animateContent ? 1.0 : 0.0)
                        .offset(y: animateContent ? 0 : 30)
                        Spacer()
                    }
                    .padding(.bottom, 0)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    animateContent = true
                }
            }
        }
        .onChange(of: imageSelection) { _, newValue in
            guard let newValue else { return }
            croppingError = nil
            Task {
                print("[DEBUG] PhotosPickerItem selected")
                if let data = try? await newValue.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    print("[DEBUG] Image loaded successfully, showing inline crop")
                    avatarUIImage = uiImage
                    // Reset zoom/pan
                    avatarZoom = 1.0
                    avatarLastZoom = 1.0
                    avatarOffset = .zero
                    avatarLastOffset = .zero
                } else {
                    print("[DEBUG] Failed to load image from PhotosPickerItem")
                    croppingError = "Failed to load image. Please try a different photo."
                }
            }
        }
        .task {
            await getInitialProfile()
        }
        .toolbar(content: {
            ToolbarItem {
                Button("Sign out", role: .destructive) {
                    Task {
                        try? await supabase.auth.signOut()
                    }
                }
            }
        })
    }
    
    func getInitialProfile() async {
        do {
            let currentUser = try await supabase.auth.session.user
            let profile: Profile =
            try await supabase
                .from("profiles")
                .select()
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value
            username = profile.username ?? ""
            fullName = profile.fullName ?? ""
            bio = profile.bio ?? ""
            if let avatarURL = profile.avatarURL, !avatarURL.isEmpty {
                try await downloadImage(path: avatarURL)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func updateProfileButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                let imageURL: String?
                if let avatarUIImage = avatarUIImage {
                    // Crop the visible area as a square and upload
                    let cropped = cropVisibleAvatar(uiImage: avatarUIImage)
                    imageURL = try await uploadImageData(cropped.jpegData(compressionQuality: 0.9))
                } else {
                    imageURL = try await uploadImage()
                }
                let currentUser = try await supabase.auth.session.user
                let updatedProfile = Profile(
                    username: username,
                    fullName: fullName,
                    bio: bio,
                    avatarURL: imageURL
                )
                try await supabase
                    .from("profiles")
                    .update(updatedProfile)
                    .eq("id", value: currentUser.id)
                    .execute()
                try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                await MainActor.run {
                    onProfileComplete?()
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) {
        Task {
            do {
                avatarImage = try await imageSelection.loadTransferable(type: AvatarImage.self)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    private func downloadImage(path: String) async throws {
        let data = try await supabase.storage.from("avatars").download(path: path)
        avatarImage = AvatarImage(data: data)
    }
    
    private func uploadImage() async throws -> String? {
        guard let data = avatarImage?.data else { return nil }
        let filePath = "\(UUID().uuidString).jpeg"
        try await supabase.storage
            .from("avatars")
            .upload(
                filePath,
                data: data,
                options: FileOptions(contentType: "image/jpeg")
            )
        return filePath
    }

    // Crop the visible area of the avatar image as a square
    func cropVisibleAvatar(uiImage: UIImage) -> UIImage {
        let size = CGSize(width: 400, height: 400) // Output size
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            let scale = avatarZoom
            let offset = avatarOffset
            let imgSize = uiImage.size
            let displaySize = CGSize(width: 80, height: 80)
            // Calculate the cropping rect in the image's coordinate space
            let scaleRatio = imgSize.width / displaySize.width
            let cropRect = CGRect(
                x: ((-offset.width + (displaySize.width/2)) - (displaySize.width/2) * scale) * scaleRatio,
                y: ((-offset.height + (displaySize.height/2)) - (displaySize.height/2) * scale) * scaleRatio,
                width: size.width * scaleRatio / scale,
                height: size.height * scaleRatio / scale
            )
            if let cgImage = uiImage.cgImage?.cropping(to: cropRect) {
                UIImage(cgImage: cgImage).draw(in: CGRect(origin: .zero, size: size))
            } else {
                uiImage.draw(in: CGRect(origin: .zero, size: size))
            }
        }
    }

    // Upload image data to Supabase
    func uploadImageData(_ data: Data?) async throws -> String? {
        guard let data else { return nil }
        let filePath = "\(UUID().uuidString).jpeg"
        try await supabase.storage
            .from("avatars")
            .upload(
                filePath,
                data: data,
                options: FileOptions(contentType: "image/jpeg")
            )
        return filePath
    }
}

#Preview {
    ProfileView()
}
