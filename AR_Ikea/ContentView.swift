//
//  IkeaInterface.swift
//  ARTIkea
//
//  Created by Giovanni Bifulco on 16/11/23.
//

// ContentView.swift
import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
}

struct ContentView: View {
    let products: [Product] = [
        Product(name: "Chair", description: "A comfortable chair for your home.", imageName: "chair"),
        Product(name: "Table", description: "A stylish table for your dining room.", imageName: "table"),
        Product(name: "Sofa", description: "A cozy sofa for your living space.", imageName: "sofa")
        // Add more products as needed
    ]

    var body: some View {
        NavigationView {
            List(products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRow(product: product)
                }
            }
            .navigationTitle("IKEA")
        }
    }
}

struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack {
            Image(product.imageName)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ProductDetailView: View {
    let product: Product
    @State private var isARViewPresented: Bool = false

    var body: some View {
        VStack {
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text(product.name)
                .font(.title)
                .padding()
            Text(product.description)
                .font(.body)
                .foregroundColor(.gray)
                .padding()

            // View in AR Button
            Button("View in AR") {
                isARViewPresented.toggle()
            }
            .padding()
            .sheet(isPresented: $isARViewPresented) {
                ARViewContainer()
            }

            Spacer()
        }
        .navigationTitle(product.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
