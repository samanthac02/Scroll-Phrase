//
//  ContentView.swift
//  QuickPhrase WatchKit Extension
//
//  Created by Samantha Chang on 1/30/21.
//

import SwiftUI

let defaults = UserDefaults.standard

struct ContentView: View {
    @State var items: [String] = defaults.object(forKey: "items") as? [String] ?? [String]()
    @State var currentItem: String = ""
    @State var isEditing: Bool = false
    
    @State var isDetailViewPresented: Bool = false
    @State private var alert: AlertView? = nil
    
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    HStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(red: 242/255, green: 204/255, blue: 143/255))
                                .aspectRatio(1.0, contentMode: .fit)
                            
                                //.resizable()
                                //.aspectRatio(contentMode: .fit)
                                
                                
                            Text(Array(item.components(separatedBy: ":"))[0])
                                .font(.title2)
                                .offset(x: 0.5, y: -0.3)
                        }//.frame(width: 40, height: 40)
                        .frame(minWidth: 20, maxWidth: 40, minHeight: 20, maxHeight: 40)
                        .cornerRadius(7)
                        .padding(.top,3)
                        .padding(.bottom,3)
                        .padding(.leading, 3)
                        
                        /*.overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.white, lineWidth: 2)
                            )*/
                        .offset(x: -4)
                        
                        Text(Array(item.components(separatedBy: ":"))[1])
                            .font(.title3)
                            .fontWeight(.bold)
                            //.foregroundColor(.black)
                            .foregroundColor(Color(red: 61/255, green: 64/255, blue: 91/255))
                        
                        Spacer()
                        
                    }.onTapGesture {
                        let url = URL(string: "sms:\(Array(item.components(separatedBy: ":"))[3]),&body=\((Array(item.components(separatedBy: ":"))[2]).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)")!
                        WKExtension.shared().openSystemURL(url)
                    }
                    //Cream - .listRowPlatterColor(Color(red: 247/255, green: 255/255, blue: 247/255))
                    // Cyan - .listRowPlatterColor(Color(red: 78/255, green: 205/255, blue: 196/255))
                    .listRowPlatterColor(Color(red: 244/255, green: 241/255, blue: 222/255))
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            //.foregroundColor(Color(red: 53/255, green: 54/255, blue: 58/255))
                            .foregroundColor(Color(red: 244/255, green: 241/255, blue: 222/255))
                        Text("+")
                            .font(.title)
                            .foregroundColor(Color(red: 61/255, green: 64/255, blue: 91/255))
                            .offset(y: -3)
                    }
                    
                    Spacer()
                }.onTapGesture {
                    self.isDetailViewPresented.toggle()
                }
                .sheet(isPresented: $isDetailViewPresented) {
                    DetailView(isDetailViewPresented: $isDetailViewPresented, items: $items, currentItem: $currentItem, isEditing: $isEditing, alert: $alert)
                }
                .listRowPlatterColor(.black)
            }
        }
        .navigationTitle("ScrollPhrase")
    }
    
    func delete (at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        defaults.set(items, forKey: "items")
    }
    
    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
        defaults.set(items, forKey: "items")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

