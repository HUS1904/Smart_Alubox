import SwiftUI

struct InventoryItem: Identifiable {
    let id = UUID()
    var name: String
    var quantity: Int
}

struct InventoryView: View {
    @State private var items: [InventoryItem] = [
        InventoryItem(name: "Battery", quantity: 1),
        InventoryItem(name: "Cable", quantity: 1)
    ]
    @State private var showAddItemAlert = false
    @State private var newItemName = ""
    @State private var newItemQuantity = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title and add button
            HStack {
                Text("Inventory")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Spacer()

                Button(action: {
                    newItemName = ""
                    newItemQuantity = ""
                    showAddItemAlert = true
                }) {
                    Text("Add")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }.padding(.bottom, 20)

            // List of items
            ForEach(items.indices, id: \.self) { index in
                Divider().background(Color.white.opacity(0.2))
                
                HStack {
                    Text(items[index].name)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))

                    Spacer()

                    HStack(spacing: 8) {
                        Button(action: {
                            if items[index].quantity > 0 {
                                items[index].quantity -= 1
                            }
                        }) {
                            Text("-")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.red)
                                .cornerRadius(8)
                        }

                        Text("\(items[index].quantity)")
                            .foregroundColor(.white)
                            .frame(minWidth: 24)

                        Button(action: {
                            items[index].quantity += 1
                        }) {
                            Text("+")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                }
                
                
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .alert("Add New Item", isPresented: $showAddItemAlert, actions: {
            TextField("Item name", text: $newItemName)
            TextField("Amount", text: $newItemQuantity)
                .keyboardType(.numberPad)

            Button("Add", action: addItem)
            Button("Cancel", role: .cancel) { }
        }, message: {
            Text("Enter a name and amount > 0")
        })
    }

    private func addItem() {
        let trimmedName = newItemName.trimmingCharacters(in: .whitespaces)
        guard let quantity = Int(newItemQuantity), quantity > 0, !trimmedName.isEmpty else { return }

        items.append(InventoryItem(name: trimmedName, quantity: quantity))
    }
}
