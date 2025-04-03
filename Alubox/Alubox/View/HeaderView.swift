import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Button(action: {
                    viewModel.toggleDropdown()
                }) {
                    HStack(spacing: 4) {
                        Text(viewModel.alubox.name.uppercased())
                            .font(.system(size: 22, weight: .bold))
                            .italic()
                            .foregroundColor(.white)
                        Image(systemName: "chevron.down")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white)
                            .font(.system(size: 15, weight: .bold))
                    }
                }

                HStack(spacing: 4) {
                    Image(systemName: "battery.75percent")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.gray, .white)
                        .font(.system(size: 18, weight: .bold))
                    Text("75%")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
            }

            Spacer() // pushes VStack to the left
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 100)
        
    }
}
