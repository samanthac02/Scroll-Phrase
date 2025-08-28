//
//  NumberKeyPad.swift
//  QuickPhrase WatchKit Extension
//
//  Created by Samantha Chang on 1/30/21.
//

import SwiftUI

struct NumberKeyPad: View {
    @State var recipientLength: Int = 1
    @Binding var buttonText: String
    @Binding var recipient: String
    
    @Binding var activeSheet: ActiveSheet?
    @Binding var alert: AlertView?
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Spacer(minLength: 16)
                Text(recipient)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    recipient.append("1")
                }) { Text("1").font(.title2) }
                
                Button(action: {
                    recipient.append("2")
                }) { Text("2").font(.title2) }
                
                Button(action: {
                    recipient.append("3")
                }) { Text("3").font(.title2) }
            }
            HStack {
                Button(action: {
                    recipient.append("4")
                }) { Text("4").font(.title2) }
                
                Button(action: {
                    recipient.append("5")
                }) { Text("5").font(.title2) }
                
                Button(action: {
                    recipient.append("6")
                }) { Text("6").font(.title2) }
            }
            HStack {
                Button(action: {
                    recipient.append("7")
                }) { Text("7").font(.title2) }
                
                Button(action: {
                    recipient.append("8")
                }) { Text("8").font(.title2) }
                
                Button(action: {
                    recipient.append("9")
                }) { Text("9").font(.title2) }
            }
            HStack {
                Button(action: {
                    if recipient == "" {
                        self.alert = AlertView(text: "You did not type anything - please type something")
                    } else {
                        buttonText = recipient
                        activeSheet = nil
                    }
                }) { Text("done") }
                
                Button(action: {
                    recipient.append("0")
                }) { Text("0").font(.title2) }
                
                Button(action: {
                    if recipientLength > 0 {
                        self.recipient.remove(at: self.recipient.index(before: self.recipient.endIndex))
                    }
                    recipientLength = recipient.count
                }) { Text("X").font(.title2) }
            }
        }
    }
}
