import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            if viewModel.activeSection == .location {
                LocationView(viewModel: viewModel)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(0)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
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

                        HeroImageView(imageName: viewModel.alubox.imageName)
                            .padding(.top, viewModel.activeSection == .none ? -45 : 10)
                            .animation(.easeOut(duration: 0.5), value: viewModel.activeSection)

                        Group {
                            switch viewModel.activeSection {
                            case .controls:
                                AnyView(SolarChargingInfoView().padding(.top, 50))
                            case .climate:
                                AnyView(ClimateView().padding(.top, 50))
                            case .inventory:
                                AnyView(InventoryView().padding(.top, 50))
                            case .specifications:
                                AnyView(SpecsView(viewModel: viewModel).padding(.top, 50))
                            default:
                                AnyView(EmptyView())
                            }
                        }

                        if viewModel.activeSection == .none || viewModel.activeSection == .controls {
                            QuickActionsRowView(viewModel: viewModel)
                                .frame(maxHeight: .infinity, alignment: viewModel.activeSection == .none ? .top : .bottom)
                                .padding(.top, viewModel.activeSection == .none ? 80 : 25)
                                .animation(.easeOut(duration: 0.5), value: viewModel.activeSection)
                        }

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

            if viewModel.activeSection == .location {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                viewModel.resetView()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.top, 60)

                    Spacer()
                }
                .zIndex(1)
            }

            if viewModel.isDropdownOpen {
                DropdownOverlayView(viewModel: viewModel)
                    .zIndex(2)
            }
        }
        .background(Color(red: 0.156, green: 0.156, blue: 0.156))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.bluetoothManager.ensureScanning()
        }
    }
}
