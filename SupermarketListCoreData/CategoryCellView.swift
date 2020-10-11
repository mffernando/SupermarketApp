//
//  CategoryCellView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 10/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

//new cell product
struct CategoryCellView : View {
    var edit : Bool
    var category : Category
    @EnvironmentObject var observer : ObserverCategory
    
    var body: some View {
        HStack {
            if edit {
                Button(action: {
                    //delete category by id
                    if self.category.id != "" {
                        self.observer.delete(id: self.category.id)
                    }
                }) {
                    Image(systemName: "minus.circle").font(.title)
                }.foregroundColor(Color.red)
            }
            VStack(alignment: .leading, spacing: 5) {
                //Color.orange
                Text(category.name).lineLimit(1)
            }
            Spacer()
            //VStack(alignment: .leading, spacing: 5) {
                //Text(product.day)
                //Text(product.time)
                //Text(category.quantity)
            //}
        }.padding().background(RoundedRectangle(cornerRadius: 25).fill(Color.white)).animation(.spring())
    }
}
