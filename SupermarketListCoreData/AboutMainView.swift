//
//  AboutMainView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 18/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

struct AboutView : View {
    @State var showAlert = false
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            //Color.blue.edgesIgnoringSafeArea(.trailing)
            //top bar
            VStack () {
                VStack(spacing: 5) {
                    HStack {
                        Text("Sobre o \n Aplicativo").font(.largeTitle).fontWeight(.heavy)
                        Spacer()
                    }.padding([.leading, .trailing], 30).padding(.top, -15)
                }.background(Rounded().fill(Color.white))
                
                //products scroll view
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        Text(
                            "Desenvolvimento de Aplicativos em IOS \n\n App Development \n\n PUCPR - 2020"
                            )
                            .font(.title).fontWeight(.heavy).foregroundColor(Color.white).multilineTextAlignment(.center)
                    }.padding().padding(.top, 5)
                }
            }.background(Color.blue)
            //add button
            Button(action: {
                self.showAlert = true
            }) {
                Image(systemName: "heart.fill").renderingMode(.original).padding(18)
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Obrigado!"), message: Text("Por testar meu App para IOS."), dismissButton: .default(Text("OK")))
            }
                .background(Color.yellow)
                .clipShape(Circle())
                .offset(y: -32)
                .shadow(radius: 5)
        }
    }
}
