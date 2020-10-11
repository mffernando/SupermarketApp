//
//  CategoryMainView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 08/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

struct CategoryView : View {
    
    //start variables
    @State var edit = false
    @State var show = false
    @State var selected : Category = .init(id: "", name: "", time: "", day: "")
    @State var menuSelected = 1
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            //Color.blue.edgesIgnoringSafeArea(.trailing)
            //top bar
            VStack () {
                VStack(spacing: 5) {
                    HStack {
                        Text("Categoria de Produtos").font(.largeTitle).fontWeight(.heavy)
                        Spacer()
                        Button(action: {
                            self.edit.toggle()
                        }) {
                            Text(self.edit ? "Feito!" : "Editar")
                        }
                    }.padding([.leading, .trailing], 30).padding(.top, -15)
                }.background(Rounded().fill(Color.white))
                
                //categories scroll view
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(ObserverCategory().datas) {
                            i in CategoryCellView(edit: self.edit, category: i).onTapGesture {

                                self.selected = i
                                self.show.toggle()
                            }
                        }
                    }.padding().padding(.top, 5)
                }.padding(.bottom, 85) //control VStack show scroll view
            }.background(Color.blue)
                .sheet(isPresented: $show) {
                SaveCategoryView(show: self.$show, category: self.selected).environmentObject(ObserverCategory())
            }
            //add button
            Button(action: {
                self.selected = Category(id: "", name: "", time: "", day: "")
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

