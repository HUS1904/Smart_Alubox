import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    if viewModel.activeSection != .none {
                        BackHeaderView(viewModel: viewModel)
                            .padding(.top, 70)
                            .padding(.horizontal)

                        Text(viewModel.alubox.name.uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 12)
                            .transition(.opacity)
                    } else {
                        HeaderView(viewModel: viewModel)
                            .padding(.top, 70)
                            .padding(.horizontal)
                    }

                    // Hero image
                    HeroImageView(imageName: viewModel.alubox.imageName)
                        .padding(.top, viewModel.activeSection == .none ? -45 : 10)
                        .animation(.easeOut(duration: 0.5), value: viewModel.activeSection)

                    // Dynamic Section Content
                    Group {
                        switch viewModel.activeSection {
                        case .controls:
                            SolarChargingInfoView()
                                .padding(.top, 50)
                                .transition(.move(edge: .bottom).combined(with: .opacity))

                        case .climate:
                            ClimateView()
                                .padding(.top, 50)
                                .transition(.move(edge: .bottom).combined(with: .opacity))

                        case .none, .location, .inventory, .specifications:
                            EmptyView()
                        }
                    }

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

                        FooterInfoView(viewModel: viewModel)
                            .padding(.top, 60)
                            .padding(.bottom, 50)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .blur(radius: viewModel.isDropdownOpen ? 8 : 0)
            .animation(.easeInOut, value: viewModel.isDropdownOpen)

            if viewModel.isDropdownOpen {
                DropdownOverlayView(viewModel: viewModel)
            }
        }
        .background(Color(red: 0.156, green: 0.156, blue: 0.156))
        .edgesIgnoringSafeArea(.all)
    }
}
