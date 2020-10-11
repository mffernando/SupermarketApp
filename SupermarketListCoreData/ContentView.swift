    //
    //  ContentView.swift
    //  SupermarketListCoreData
    //
    //  Created by Fernando Mueller on 03/09/20.
    //  Copyright © 2020 Fernando Mueller. All rights reserved.
    //
    
    import SwiftUI
    import CoreData
    
    struct ContentView: View {
        
        @State var menuSelected = 0
        @State var name = ""
        @State var show = false
        @State var user : User = .init(id: "", username: "", password: "", time: "", day: "")
        
        //call the Product View from ProductMainView.swift
        var body: some View {
            
            ZStack (alignment: .bottom) {
                if self.menuSelected == 0 {
                    if (user.username != "" && user.password != "") {
                        if ObserverUser().login(username: user.username, password: user.password) {
                        ProductView()
                        }
                    } else {
                        Login(menuSelected: $menuSelected, name: $name)
                            .edgesIgnoringSafeArea(.all).statusBar(hidden: true)
                    }
                }
                else if self.menuSelected == 1 {
                    ProductView()
                }
                else if self.menuSelected == 2 {
                    CategoryView()
                }
                else if self.menuSelected == 3 {
                    PerfilView(name: $name)
                }
                else if self.menuSelected == 4 {
                    AboutView()
                }
                //botton bar
                if self.menuSelected != 0 {
                    BottomBar(menuSelected: self.$menuSelected)
                        .padding()
                        .padding(.horizontal, 22)
                        .background(CurvedShape())
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            //Login()
        }
    }
    
    //top bar rounded shape
    struct Rounded : Shape {
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 25, height: 25))
            
            return Path(path.cgPath)
        }
    }
    
    //bottom bar (menu) curved shape
    struct BottomBar : View {
        
        @Binding var menuSelected : Int
        
        var body : some View{
            HStack{
                //0 = login
                Button(action: {
                    self.menuSelected = 0
                }) {
                    Text("")
                }.foregroundColor(Color.blue)
                Button(action: {
                    self.menuSelected = 1
                }) {
                    Image(systemName: "cart.fill")
                }.foregroundColor(self.menuSelected == 1 ? .black : .blue)
                Spacer(minLength: 12)
                Button(action: {
                    self.menuSelected = 2
                }) {
                    Image(systemName: "bag.fill")
                }.foregroundColor(self.menuSelected == 2 ? .black : .blue)
                Spacer().frame(width: 120)
                Button(action: {
                    self.menuSelected = 3
                }) {
                    Image(systemName: "person.fill")
                }.foregroundColor(self.menuSelected == 3 ? .black : .blue)
                    .offset(x: -10)
                Spacer(minLength: 12)
                Button(action: {
                    self.menuSelected = 4
                }) {
                    Image(systemName: "envelope.fill")
                }.foregroundColor(self.menuSelected == 4 ? .black : .blue)
            }
        }
    }
    
    struct CurvedShape : View {
        var body : some View{
            ZStack () {
                Path{path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
                    path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 55))
                    path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2, y: 55), radius: 30, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
                    path.addLine(to: CGPoint(x: 0, y: 55))
                }.fill(Color.white)
                    .rotationEffect(.init(degrees: 180))
            }
        }
    }
