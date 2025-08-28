//
//  ScrollType.swift
//  QuickPhrase WatchKit Extension
//
//  Created by Samantha Chang on 1/30/21.
//

import SwiftUI

struct ScrollType: View {
    @Binding var items: [String]
    @Binding var currentItem: String
    @Binding var isEditing: Bool
    @Binding var activeSheet: ActiveSheet?
    @Binding var alert: AlertView?
    @Binding var title: String
    @Binding var message: String
    @Binding var recipient: String
    @Binding var buttonText: String
    @Binding var instructions: String
    
    @State var characters: [ String ] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    @State var text: String = ""
    
    @State var textBoxText: String = ""
    
    @State private var showModal: Bool = false
    @State var characterStatus: String = "letters"
    @State var moreButtonText: String = "•••"
    @State var checkMessageLength: Int = 1
    
    @State var previousCharacter = ""
    @State var currentCharacter = ""
    @State var isNextLetterCapitalized: Bool = false
    
    var body: some View {
        HStack {
            VStack() {
                ZStack (alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.black)
                    Text(text.firstCapitalized) + Text("|").foregroundColor(.blue).bold()
                }
                
                VStack {
                    HStack {
                        Button(action: {
                            if characterStatus == "letters" {
                                self.showModal.toggle()
                            } else {
                                moreButtonText = "•••"
                                characters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
                                characterStatus = "letters"
                            }
                        }) {
                            Text(moreButtonText).bold()
                        }.sheet(isPresented: $showModal) { ModalView(showModal: self.$showModal, characters: $characters, characterStatus: $characterStatus, moreButtonText: $moreButtonText, textBoxText: $textBoxText, text: $text) }
                            
                        Button(action: {
                            self.text.append(" ")
                            
                            if text.contains("  ") {
                                text = text.replacingOccurrences(of: "  ", with: ". ", options: .literal, range: nil)
                                previousCharacter = "."
                            } else { previousCharacter = currentCharacter }
                                
                            currentCharacter = " "
                            checkForCapitalize()
                        }) { Image("space") }
                    }
                        
                    HStack {
                        Button(action: {
                            if isEditing == true {
                                activeSheet = nil
                            } else {
                                //if text == "" {
                                    //self.alert = AlertView(text: "You did not type anything - please type something")
                                //} else {
                                    if instructions == "Enter a title for your button:" {
                                        title = text
                                    } else if instructions == "Add a kind message:" {
                                        message = text
                                    } else {
                                        //recipient = text
                                    }
                                    
                                    buttonText = text
                                    print(buttonText)
                                    
                                    text = ""
                                    activeSheet = nil
                               // }
                            }
                        }) { Text("done").font(.caption) }
                        .alert(item: $alert) { message in
                            Alert(
                                title: Text(message.text),
                                dismissButton: .cancel()
                            )}
                            
                        Button(action: {
                            if checkMessageLength > 0 {
                                self.text.remove(at: self.text.index(before: self.text.endIndex))
                            }
                            checkMessageLength = text.count
                        }) { Text("del").bold() }
                    }
                }
            }
                
            Spacer()
            
            List {
                VStack {
                    ForEach(0..<characters.count) { index in
                        Text(characters[index])
                            .font(.largeTitle)
                            .onTapGesture {
                                text.append(characters[index])
                                text = text.firstCapitalized
                                
                                previousCharacter = currentCharacter
                                currentCharacter = characters[index]
                                capitalize(number: index)
                            }
                    }
                }
            }.frame(width: 50)
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    func checkForCapitalize() {
        if previousCharacter == "." || previousCharacter == "!" || previousCharacter == "?" {
            if currentCharacter == " " {
                isNextLetterCapitalized = true
            }
        }
    }

    func capitalize(number: Int) {
        checkForCapitalize()
        if isNextLetterCapitalized == true {
            text.remove(at: text.index(before: text.endIndex))
            text.append(characters[number].firstCapitalized)
            isNextLetterCapitalized = false
        }
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

struct ModalView: View {
    @Binding var showModal: Bool
    @Binding var characters: [ String ]
    @Binding var characterStatus: String
    @Binding var moreButtonText: String
    @Binding var textBoxText: String
    @Binding var text: String
    
    var body: some View {
        List {
            ZStack(alignment: .center) {
                if textBoxText.isEmpty { Text("Emojis").foregroundColor(.white) }
                TextField("", text: $textBoxText)
                    .onChange(of: textBoxText, perform: { value in
                        text.append(textBoxText)
                        textBoxText = ""
                        self.showModal = false
                }).multilineTextAlignment(.center)
            }.cornerRadius(20)
            
            HStack {
                Spacer()
                Text("Capitals").onTapGesture {
                    characters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
                    characterStatus = "capitals"
                    moreButtonText = "abc"
                    self.showModal.toggle()
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("Numbers").onTapGesture {
                    characters = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "/", ":", ";", "(", ")", "$", "&", "@", "\"", ".", ",", "?", "!", "'", ""]
                    characterStatus = "numbers"
                    moreButtonText = "abc"
                    self.showModal.toggle()
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("Symbols").onTapGesture {
                    characters = [".", ",", "?", "!", "'", "\"", "[", "]", "{", "}", "#", "%", "^", "*", "+", "=", "_", "\\", "|", "~" , "<", ">", "€", "£", "¥", "•"]
                    characterStatus = "symbols"
                    moreButtonText = "abc"
                    self.showModal.toggle()
                }
                Spacer()
            }
            
            
        }
    }
}
