//
//  ContentView.swift
//  QuickPhrase
//
//  Created by Samantha Chang on 1/30/21.
//

import SwiftUI

let defaults = UserDefaults.standard

struct ContentView: View {
    @State var showDonationView: Bool = false
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    VStack(alignment: .center) {
                        Text("Tip Jar")
                            .font(.headline)
                            .padding(.top)

                        Divider()
                        
                        Image("yoda cookie")
                            .frame(width: 300, alignment: .center)
                            .cornerRadius(20)
                            .padding(.bottom)
                            .onTapGesture {
                                showDonationView.toggle()
                            }
                            .sheet(isPresented: $showDonationView) {
                                DonateView(showDonationView: $showDonationView)
                            }
                    }
                }
                
                Section {
                    
                    VStack(alignment: .center) {
                        Text("ScrollPhrase has been installed on your Apple Watch! 😄")
                            .font(.headline)
                            .padding(.vertical)

                        Divider()
                        
                        Image("installed")
                            .frame(width: 300, alignment: .center)
                            .cornerRadius(20)
                            .padding(.bottom)
                    }
                }

                Section {
                    VStack(alignment: .leading) {
                        Text("SEND QUICK PHRASES")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .padding(.top, 10)

                        Text("Send messages with a tap")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(height: 60)
                            .padding(.bottom)

                        HStack (alignment: .center) {
                            Spacer()
                            
                            Image("buttons")
                                .frame(width: 300, alignment: .center)
                                .cornerRadius(20)
                                .padding(.bottom)
                        
                            Spacer()
                        }
                        
                        List {
                            Text("• Create a phrase with the + button")
                            
                            Divider()
                            
                            Text("• Includes ScrollType typing keyboard to edit and add phrases")
                            
                            Divider()
                            
                            Text("• Intuitive design makes it easy to use")
                                .padding(.bottom, 10)
                        }
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("KEYBOARD")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .padding(.top, 10)

                        Text("Revolutionary keyboard with never before seen scrolling")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(height: 60)
                            .padding(.bottom)

                        HStack (alignment: .center) {
                            Spacer()
                            
                            Image("key")
                                .frame(width: 300, alignment: .center)
                                .cornerRadius(20)
                                .padding(.bottom)
                        
                            Spacer()
                        }
                        
                        List {
                            Text("• Add a task with the + Add button")
                            
                            Divider()
                            
                            Text("• Includes ScrollType typing keyboard to edit and add tasks")
                            
                            Divider()
                            
                            Text("• Edit your text by tapping your specified task")
                                .padding(.bottom, 10)
                        }
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("OTHER APPS YOU MIGHT LIKE")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .padding(.top, 10)

                        Text("ScrollType")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(height: 60)
                            .padding(.bottom)

                        HStack {
                            Spacer()
                            
                            Image("d")
                                .frame(width: 300, alignment: .center)
                                .cornerRadius(20)
                                .padding(.bottom)
                            
                            Spacer()
                        }
                        
                        Text("Easy to use Apple Watch keyboard that allows you to send messages from your wrist")
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack {
                            Spacer()
                            
                            Image("appStore")
                                .padding(.bottom)
                                .onTapGesture {
                                    openURL(URL(string: "“itms-apps://apps.apple.com/us/app/scrolltype-watch-keyboard/id1546511710”")!)
                                }
                            Spacer()
                        }
                        
                        Divider()
                        
                        Text("ScrollTask")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(height: 60)
                            .padding(.bottom)
                        
                        HStack {
                            Spacer()
                            
                            Image("task")
                                .frame(width: 300, alignment: .center)
                                .cornerRadius(20)
                                .padding(.bottom)
                            
                            Spacer()
                        }
                        
                        Text("Standalone to-do list app on Apple Watch. No need for iPhone.")
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack {
                            Spacer()
                            
                            Image("appStore")
                                .padding(.bottom)
                                .onTapGesture {
                                    openURL(URL(string: "itms-apps://itunes.apple.com/app/1550485375")!)
                                }
                            Spacer()
                        }
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Need Help?")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(height: 60)
                        
                        WebView(url: .publicUrl, viewModel: viewModel).overlay (
                            RoundedRectangle(cornerRadius: 4, style: .circular)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .frame(height: 350)
                        .padding()
                    }
                }
            }

            .navigationTitle("ScrollPhrase")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
