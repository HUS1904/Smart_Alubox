import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            // Fullscreen map mode
            if viewModel.activeSection == .location {
                LocationView(viewModel: viewModel)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(0)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        if viewModel.activeSection == .none {
                            HeaderView(viewModel: viewModel)
                                .padding(.top, 70)
                                .padding(.horizontal)
                        } else {
                            BackHeaderView(viewModel: viewModel)
                                .padding(.top, 70)
                                .padding(.horizontal)

                            if viewModel.activeSection != .location {
                                Text(viewModel.alubox.name.uppercased())
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.vertical, 12)
                                    .transition(.opacity)
                            }
                        }

                        // Hero image
                        if viewModel.activeSection != .location {
                            HeroImageView(imageName: viewModel.alubox.imageName)
                                .padding(.top, viewModel.activeSection == .none ? -45 : 10)
                                .animation(.easeOut(duration: 0.5), value: viewModel.activeSection)
                        }

                        // Dynamic Section Content
                        Group {
                            switch viewModel.activeSection {
                            case .controls:
                                AnyView(
                                    SolarChargingInfoView()
                                        .padding(.top, 50)
                                        .transition(.move(edge: .bottom).combined(with: .opacity))
                                )

                            case .climate:
                                AnyView(
                                    ClimateView()
                                        .padding(.top, 50)
                                        .transition(.move(edge: .bottom).combined(with: .opacity))
                                )
                                
                            case .inventory:
                                    AnyView(
                                        InventoryView() // 👈 create this file next
                                            .padding(.top, 50)
                                            .transition(.move(edge: .bottom).combined(with: .opacity))
                                    )
                                
                            case .specifications:
                                AnyView(
                                    SpecsView(viewModel: viewModel)
                                        .padding(.top, 50)
                                        .transition(.move(edge: .bottom).combined(with: .opacity))
                                )

                            default:
                                AnyView(EmptyView())
                            }
                        }

                        // Quick Actions only for main and controls
                        if viewModel.activeSection == .none || viewModel.activeSection == .controls {
                            QuickActionsRowView(viewModel: viewModel)
                                .frame(maxHeight: .infinity, alignment: viewModel.activeSection == .none ? .top : .bottom)
                                .padding(.top, viewModel.activeSection == .none ? 80 : 25)
                                .animation(.easeOut(duration: 0.5), value: viewModel.activeSection)
                        }

                        // Only show on main page
                        if viewModel.activeSection == .none {
                            SectionButtonsView(viewModel: viewModel)
                                .padding(.top, 30)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .blur(radius: viewModel.isDropdownOpen ? 8 : 0)
                .animation(.easeInOut, value: viewModel.isDropdownOpen)
                .zIndex(0)
            }

            // Back button on top of LocationView
            // Back button on top of LocationView
            if viewModel.activeSection == .location {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.5)) {
                                viewModel.resetView()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black)
                                .cornerRadius(10) // Rounded square
                        }
                        .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.top, 60)

                    Spacer()
                }
                .zIndex(1)
            }


            // Dropdown
            if viewModel.isDropdownOpen {
                DropdownOverlayView(viewModel: viewModel)
                    .zIndex(2)
            }
        }
        .background(Color(red: 0.156, green: 0.156, blue: 0.156))
        .edgesIgnoringSafeArea(.all)
    }
}
