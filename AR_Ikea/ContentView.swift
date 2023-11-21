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
    ]

    var body: some View {
        NavigationView {
            List(products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRow(product: product)
                }
                .accessibility(label: Text("\(product.name): \(product.description)"))
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
                .accessibility(label: Text(product.name))

            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                    .accessibility(label: Text("Product Name: \(product.name)"))

                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .accessibility(label: Text("Description: \(product.description)"))
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
                .accessibility(label: Text(product.name))

            Text(product.name)
                .font(.title)
                .padding()
                .accessibility(label: Text("Product Name: \(product.name)"))

            Text(product.description)
                .font(.body)
                .foregroundColor(.gray)
                .padding()
                .accessibility(label: Text("Description: \(product.description)"))

            // View in AR Button
            Button("View in AR") {
                isARViewPresented.toggle()
            }
            .padding()
            .sheet(isPresented: $isARViewPresented) {
                ARViewContainer()
            }
            .accessibility(label: Text("View in AR Button"))
            Spacer()
        }
        .navigationTitle(product.name)
    }
}
