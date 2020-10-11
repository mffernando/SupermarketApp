//
//  UserSaveView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 19/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData



struct PerfilView : View {
    @State var showAlert = false
    @State var user : User = .init(id: "", username: "", password: "", time: "", day: "")
    @Binding var name : String
    //@Binding var id : String
    @State var password = ""
    @State var id = ""
    //var user : User
    
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            //Color.blue.edgesIgnoringSafeArea(.trailing)
            //top bar
            VStack (spacing: 15) {
                VStack(spacing: 5) {
                    HStack {
                        Text("Meu \n Perfil").font(.largeTitle).fontWeight(.heavy)
                        Spacer()
                    }.padding([.leading, .trailing], 30).padding(.top, -15)
                }.background(Rounded().fill(Color.white))
                
                //products scroll view
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        Text(
                            "Olá, \(name)! \nAlterar senha?"
                            )
                            .font(.title).fontWeight(.heavy).foregroundColor(Color.white).multilineTextAlignment(.center)
                    }.padding().padding(.top, 5)
                    HStack {
                        Image(systemName: "textbox")
                        SecureField("Digite a nova senha!", text: $password)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white))
                    
                    //change pass button
                    Button(action: {
                        if (self.password != "") {
                        ObserverUser().update(username: self.name, password: self.password)
                        print("meu usuário:", self.name, "- senha nova senha:", self.password)
                        } else {
                            self.showAlert = true
                            print("Senha não pode ser vazio")
                        }
                    }) {
                        Text("Alterar").foregroundColor(Color.white)
                    }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Aviso!"), message: Text("Por gentileza, preencher todos os campos!"), dismissButton: .default(Text("OK")))
                    }.padding()
                    
                }.padding()
            }.background(Color.blue)
            
            //add button
            Button(action: {
                self.showAlert = false
            }) {
                Image(systemName: "heart.fill").renderingMode(.original).padding(18)
            }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Aviso!"), message: Text("Por gentileza, preencher todos os campos!"), dismissButton: .default(Text("OK")))
            }
                .background(Color.yellow)
                .clipShape(Circle())
                .offset(y: -32)
                .shadow(radius: 5)
        }
    }
}
