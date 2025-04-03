import SwiftUI

struct DropdownOverlayView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        ZStack {
            // 1. Blurred background
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.toggleDropdown()
                }

            VStack(spacing: 0) {
                Spacer().frame(height: 100)

                // 2. Dark background for dropdown container
                VStack(spacing: 20) {
                    // Title
                    Text("ALUBOX")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    // 3. Current Alubox card
                    Button(action: {
                        viewModel.toggleDropdown() // just closes dropdown
                    }) {
                        HStack {
                            Image(viewModel.alubox.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 60)
                                .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(viewModel.alubox.name.uppercased())
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)

                                Text("Battery: 75%")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }

                    Divider().background(Color.white.opacity(0.2))
                        .padding(.horizontal)

                    // 4. Add new box button
                    Button(action: {
                        // future functionality
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))

                            Text("Add Box")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)

                            Spacer()
                        }
                        .padding()
                        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 20)
                .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                .cornerRadius(20)
                .padding(.horizontal, 16)

                Spacer()
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: viewModel.isDropdownOpen)
    }
}
