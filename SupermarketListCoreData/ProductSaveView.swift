//
//  ProductSaveView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 07/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

//save product details view
struct SaveProductView : View {
    @State var name = ""
    @State var category = ""
    @State var quantity = ""
    @State var note = ""
    @Binding var show : Bool
    @EnvironmentObject var observer : ObserverProduct
    var product : Product

    var body: some View {
        
        ZStack () {
            VStack (spacing: 15) {
                //}
                HStack {
                    Image(systemName: "textbox")
                    TextField("Produto: ", text: $name)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue))
                                                                
                HStack {
                    Image(systemName: "tray")
                    TextField("Categoria: ", text: $category)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue))
                
                HStack {
                    Image(systemName: "textformat.123")
                    TextField("Quantidade: ", text: $quantity)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue))
                
                HStack {
                    Image(systemName: "pencil")
                    TextField("Observação: ", text: $note)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue))
                
                //update or add product
                Button(action: {
                    if self.product.id != "" {
                        self.observer.update(id: self.product.id, name: self.name, category: self.category, quantity: self.quantity, note: self.note)
                    } else {
                        self.observer.add(name: self.name, category: self.category, quantity: self.quantity, note: self.note, date: Date())
                    }
                    self.show.toggle()
                }) {
                    Text("Salvar")
                }.padding()
                
            }
            .padding()
            .onAppear {
                //edit tab
                self.name = self.product.name
                self.category = self.product.category
                self.quantity = self.product.quantity
                self.note = self.product.note
            }
        }
    }
}





