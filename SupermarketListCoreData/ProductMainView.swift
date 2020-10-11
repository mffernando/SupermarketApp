//
//  ProductMainView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 07/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

struct ProductView : View {
    
    //start variables
    @State var edit = false
    @State var show = false
    @EnvironmentObject var observer : ObserverProduct
    @State var selected : Product = .init(id: "", name: "", category: "", quantity: "", note: "", time: "", day: "")
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            //Color.blue.edgesIgnoringSafeArea(.trailing)
            //top bar
            VStack () {
                VStack(spacing: 5) {
                    HStack {
                        Text("Meu Supermercado").font(.largeTitle).fontWeight(.heavy)
                        Spacer()
                        Button(action: {
                            self.edit.toggle()
                        }) {
                            Text(self.edit ? "Feito!" : "Editar")
                        }
                    }.padding([.leading, .trailing], 30).padding(.top, -15)
                }.background(Rounded().fill(Color.white))
                
                //products scroll view                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(self.observer.datas) {
                            i in CellView(edit: self.edit, product: i).onTapGesture {
                                self.selected = i
                                self.show.toggle()
                            }
                        }
                    }.padding().padding(.top, 5)
                }.padding(.bottom, 95) //control VStack show scroll view
            }.background(Color.blue)
                .sheet(isPresented: $show) {
                    SaveProductView(show: self.$show, product: self.selected).environmentObject(self.observer)
            }
            //add button
            Button(action: {
                self.selected = Product(id: "", name: "", category: "", quantity: "", note: "", time: "", day: "")
                self.show.toggle()
            }) {
                //button add
                Image(systemName: "plus")
                    .renderingMode(.original).padding(18)
            }.background(Color.yellow)
                .clipShape(Circle())
                .offset(y: -32)
                .shadow(radius: 5)
        }
    }
}
