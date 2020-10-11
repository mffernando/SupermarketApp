//
//  LoginView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 19/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

struct Login : View {
    @State var signUp = false
    @State var username = ""
    @State var password = ""
    @State var show = false
    @State var showAlert = false
    @Binding var menuSelected : Int
    @Binding var name : String
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
            ZStack{
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                    //Color(.blue).clipShape(CShape())
                    //Curve Shape
                    Path{ path in
                        path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - 120 , y: UIScreen.main.bounds.height - 50), radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
                    }
                    .fill(Color.white)
                    //Buttons
                    Button(action: {
                        withAnimation(.easeIn){
                            self.signUp = false
                        }
                    }) {
                        Image(systemName: signUp ? "person.fill" : "chevron.right")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.blue)
                    }
                    .offset(x: -110, y: -50)
                        //Disabling button
                        .disabled(signUp ? false : true)
                    Button(action: {
                        withAnimation(.easeOut){
                            self.signUp = true
                        }
                    }) {
                        Image(systemName: signUp ? "chevron.left" : "person.badge.plus.fill")
                            .font(.system(size: signUp ? 26 : 25, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(x: -30, y: -40)
                    .disabled(signUp ? true : false)
                    }.background(Color.blue).clipShape(CShape())
                // Login View
                VStack(alignment: .leading, spacing: 25) {
                    Text("Login")
                        .font(.largeTitle).fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Usuário")
                        .font(.title).fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack{
                        TextField("Usuário", text: $username)
                        .font(.title)
                        Divider()
                            .background(Color.white)
                    }
                    
                    Text("Senha")
                        .font(.title).fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack{
                        SecureField("Senha", text: $password)
                        .font(.title)
                        Divider()
                            .background(Color.white)
                    }
                    HStack{
                        Spacer()
                        // Login Button
                        Button(action: {
                            if (self.username != "" && self.password != "") {
                                let logged = ObserverUser().login(username: self.username, password: self.password)
                                
                                if logged {
                                    self.name = self.username
                                    self.menuSelected = 1
                                    
                                    print("Meu login é: ", self.name)
                                } else {
                                    self.menuSelected = 0
                                }
                                
                                print(self.username, self.password, logged)

                                self.show.toggle()
                                
   

                             }
                            else {
                                self.showAlert = true
                                return
                             }
                        }) {
                            Text("Conectar")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                                .padding(.vertical)
                                .padding(.horizontal,45)
                                .background(Color.white)
                                .clipShape(Capsule())
                            
                        }.alert(isPresented: $showAlert) {
                        Alert(title: Text("Aviso!"), message: Text("Por gentileza, preencher todos os campos!"), dismissButton: .default(Text("OK")))
                        }
                        Spacer()
                    }
                    .padding(.top)
                    Spacer(minLength: 10)
                    
                }
                .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 25)
                .padding()
            }
            .offset(y: signUp ? -UIScreen.main.bounds.height + (UIScreen.main.bounds.height < 750 ? 100 : 130) : 0)
            .zIndex(1)
           
            // SignUp View
            
            VStack(alignment: .leading, spacing: 25) {
                
                Text("Cadastrar")
                    .font(.largeTitle).fontWeight(.bold)
                    .foregroundColor(Color.blue)
                
                Text("Usuário")
                    .font(.title).fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(.top,10)
                
                VStack{
                    TextField("Usuário", text: $username)
                    .font(.title)
                    Divider()
                        .background(Color.blue)
                }
                
                Text("Senha")
                    .font(.title).fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(.top,10)
                
                VStack{
                    SecureField("Senha", text: $password)
                    .font(.title)
                    Divider()
                        .background(Color.blue)
                }
                
                HStack{
                    Spacer()
                    
                    // Login Button
                    Button(action: {
                        //self.showAlert = false
                        if (self.username != "" && self.password != "") {
                            ObserverUser().add(username: self.username, password: self.password, date: Date())
                            self.show.toggle()
                        } else {
                            self.showAlert = true
                        }
                    }) {
                        Text("Cadastrar")
                            .font(.title).fontWeight(.bold)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,45)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Aviso!"), message: Text("Por gentileza, preencher todos os campos!"), dismissButton: .default(Text("OK")))
                    }
                    Spacer()
                }
                .padding(.top)
                Spacer(minLength: 0)
            }
            .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 50)
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
            .preferredColorScheme(signUp ? .light : .dark)
    }
}

//Custom Shape

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            // starting from bottom
            path.move(to: CGPoint(x: rect.width, y: rect.height - 50))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 50))
            // adding curve
            path.addArc(center: CGPoint(x: rect.width - 40, y: rect.height - 50), radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: false)
        }
    }
}



