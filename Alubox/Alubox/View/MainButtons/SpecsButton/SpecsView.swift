import SwiftUI

struct SpecsView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 4) {
                Text(viewModel.alubox.boxInfo.modelName.uppercased())
                    .font(.system(size: 20, weight: .black))
                    .italic()
                    .foregroundColor(.white)

                Text(viewModel.alubox.boxInfo.version.uppercased())
                    .font(.system(size: 15, weight: .bold))
                    .italic()
                    .foregroundColor(.white)

                Text("Purchased: \(viewModel.formattedDate(viewModel.alubox.boxInfo.purchaseDate))")
                    .padding(.top, 10)

                Text("Warranty Ends: \(viewModel.formattedDate(viewModel.alubox.boxInfo.warrantyEnds))")
            }
            .font(.footnote)
            .foregroundColor(.gray)

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
    }
}
