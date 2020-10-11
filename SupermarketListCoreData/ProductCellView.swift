//
//  ProductCellView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 07/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

//new cell product
struct CellView : View {
    var edit : Bool
    var product : Product
    @EnvironmentObject var observer : ObserverProduct
    
    var body: some View {
        HStack {
            if edit {
                Button(action: {
                    //delete product by id
                    if self.product.id != "" {
                        self.observer.delete(id: self.product.id)
                    }
                }) {
                    Image(systemName: "minus.circle").font(.title)
                }.foregroundColor(Color.red)
            }
            VStack(alignment: .leading, spacing: 5) {
                //Color.orange
                Text(product.name).lineLimit(1)
                Text(product.note).lineLimit(2)

            }
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text(product.category).lineLimit(3)
                Text(product.quantity).lineLimit(4)
            }
        }.padding().background(RoundedRectangle(cornerRadius: 25).fill(Color.white)).animation(.spring())
    }
}
