import SwiftUI

struct FooterInfoView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack(spacing: 4) {
            Text("\(viewModel.alubox.boxInfo.modelName)".uppercased())
                .font(.system(size: 20, weight: .black))
                .italic()
                .foregroundColor(.white)
            Text("\(viewModel.alubox.boxInfo.version)".uppercased())
                .font(.system(size: 15, weight: .bold))
                .italic()
            
            Text("Purchased: \(viewModel.formattedDate(viewModel.alubox.boxInfo.purchaseDate))")
                .padding(.top,10)
            
            Text("Warranty Ends: \(viewModel.formattedDate(viewModel.alubox.boxInfo.warrantyEnds))")
        }
        .font(.footnote)
        .foregroundColor(.gray)
    }
}
