//
//  DetailView.swift
//  QuickPhrase WatchKit Extension
//
//  Created by Samantha Chang on 1/30/21.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case ScrollType, Emojis, Numbers
    
    var id: Int {
        hashValue
    }
}

struct DetailView: View {
    @Binding var isDetailViewPresented: Bool
    @Binding var items: [String]
    @Binding var currentItem: String
    @Binding var isEditing: Bool
    
    @State var instructions: String = "Enter a title for your button:"
    @State var buttonText: String = ""
    
    @State var activeSheet: ActiveSheet?
    @Binding var alert: AlertView?
    
    @State var icon: String = ""
    @State var title: String = ""
    @State var message: String = ""
    @State var recipient: String = ""
    
    var body: some View {
        
        Text(instructions)
            .fontWeight(.semibold)
            .padding(.bottom)
        
        List {

            Button(action: {
                if instructions == "Enter a title for your button:" {
                    buttonText = title
                    print(title)
                        //currentItem = ""
                    activeSheet = .ScrollType
                } else if instructions == "Add a kind message:" {
                    buttonText = message
                        //currentItem = ""
                    activeSheet = .ScrollType
                } else if instructions == "Select an emoji for your button:" {
                    buttonText = icon
                        //currentItem = ""
                    activeSheet = .Emojis
                } else {
                    activeSheet = .Numbers
                }
                    
            }) { Text(buttonText).foregroundColor(Color(red: 61/255, green: 64/255, blue: 91/255)) }
            .sheet(item: $activeSheet) { view in
                switch view {
                case .ScrollType:
                    ScrollType(items: $items, currentItem: $currentItem, isEditing: $isEditing, activeSheet: $activeSheet, alert: $alert, title: $title, message: $message, recipient: $recipient, buttonText: $buttonText, instructions: $instructions)
                case .Numbers:
                    NumberKeyPad(buttonText: $buttonText, recipient: $recipient, activeSheet: $activeSheet, alert: $alert)
                case .Emojis:
                    EmojiKeyPad(icon: $icon, buttonText: $buttonText, activeSheet: $activeSheet)
                }
            }
            .listRowPlatterColor(Color(red: 244/255, green: 241/255, blue: 222/255))
            
            Spacer().listRowPlatterColor(.black)
            
            //VStack{}.listRowPlatterColor(.black)
            
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 40, height: 40)
                        //.foregroundColor(Color(red: 53/255, green: 54/255, blue: 58/255))
                        .foregroundColor(Color(red: 244/255, green: 241/255, blue: 222/255))
                    Text("→")
                        .font(.title2)
                        .foregroundColor(Color(red: 61/255, green: 64/255, blue: 91/255))
                        .offset(y: -1)
                }.onTapGesture {
                    if buttonText == "" {
                        self.alert = AlertView(text: "You did not type anything - please type something")
                    } else {
                        if instructions == "Enter a title for your button:" {
                            checkText(for: title, itemInstructions: "Add a kind message:")
                        } else if instructions == "Add a kind message:" {
                            checkText(for: message, itemInstructions: "Select an emoji for your button:")
                        } else if instructions == "Select an emoji for your button:" {
                            checkText(for: icon, itemInstructions: "Enter a recipient's phone number:")
                        } else {
                            if recipient == "" {
                                self.alert = AlertView(text: "You did not type anything - please type something")
                            } else {
                                currentItem = "\(icon):\(title):\(message):\(recipient)"
                                items.append(currentItem)
                                defaults.set(items, forKey: "items")
                                print(items)
                                self.isDetailViewPresented.toggle()
                            }
                        }
                        buttonText = ""
                    }
                }
                .alert(item: $alert) { message in
                    Alert(
                        title: Text(message.text),
                        dismissButton: .cancel()
                    )}
            }.listRowPlatterColor(Color.black)
            .padding(.bottom)
            /*HStack {
                Button(action: {
                    if buttonText == "" {
                        self.alert = AlertView(text: "You did not type anything - please type something")
                    } else {
                        if instructions == "Enter a title for your button:" {
                            checkText(for: title, itemInstructions: "Add a kind message:")
                        } else if instructions == "Add a kind message:" {
                            checkText(for: message, itemInstructions: "Select an emoji for your button:")
                        } else if instructions == "Select an emoji for your button:" {
                            checkText(for: icon, itemInstructions: "Enter a recipient's phone number:")
                        } else {
                            if recipient == "" {
                                self.alert = AlertView(text: "You did not type anything - please type something")
                            } else {
                                currentItem = "\(icon):\(title):\(message):\(recipient)"
                                items.append(currentItem)
                                defaults.set(items, forKey: "items")
                                print(items)
                                self.isDetailViewPresented.toggle()
                            }
                        }
                        buttonText = ""
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            //.foregroundColor(Color(red: 53/255, green: 54/255, blue: 58/255))
                            .foregroundColor(Color(red: 244/255, green: 241/255, blue: 222/255))
                        Text("→")
                            .font(.title2)
                            .foregroundColor(Color(red: 61/255, green: 64/255, blue: 91/255))
                            .offset(y: -1)
                    }
                        
                }
                .alert(item: $alert) { message in
                    Alert(
                        title: Text(message.text),
                        dismissButton: .cancel()
                    )}
            }.listRowPlatterColor(Color.black)*/
        }
        //HStack {
        //Spacer()
        
        /*HStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    //.foregroundColor(Color(red: 53/255, green: 54/255, blue: 58/255))
                    .foregroundColor(Color(red: 244/255, green: 241/255, blue: 222/255))
                Text("→")
                    .font(.title2)
                    .foregroundColor(Color(red: 61/255, green: 64/255, blue: 91/255))
                    .offset(y: -1)
            }.onTapGesture {
                if buttonText == "" {
                    self.alert = AlertView(text: "You did not type anything - please type something")
                } else {
                    if instructions == "Enter a title for your button:" {
                        checkText(for: title, itemInstructions: "Add a kind message:")
                    } else if instructions == "Add a kind message:" {
                        checkText(for: message, itemInstructions: "Select an emoji for your button:")
                    } else if instructions == "Select an emoji for your button:" {
                        checkText(for: icon, itemInstructions: "Enter a recipient's phone number:")
                    } else {
                        if recipient == "" {
                            self.alert = AlertView(text: "You did not type anything - please type something")
                        } else {
                            currentItem = "\(icon):\(title):\(message):\(recipient)"
                            items.append(currentItem)
                            defaults.set(items, forKey: "items")
                            print(items)
                            self.isDetailViewPresented.toggle()
                        }
                    }
                    buttonText = ""
                }
            }
            .alert(item: $alert) { message in
                Alert(
                    title: Text(message.text),
                    dismissButton: .cancel()
                )}
        }*/

    }
    
    func checkText(for item: String, itemInstructions: String) {
        if item == "" {
            instructions = itemInstructions
        } else {
            instructions = itemInstructions
        }
    }
}
