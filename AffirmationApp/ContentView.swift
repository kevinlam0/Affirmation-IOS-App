//
//  ContentView.swift
//  AffirmationApp
//
//  Created by Kevin Lam on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var affirmation = ""
    var body: some View {
        ZStack {
            Color(red: 250/255, green: 247/255, blue: 242/255)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        print("Button")
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding([.leading], 15)
                    Spacer()
                    VStack {
                        Text("Cheer up Jit")
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(red: 63/255, green: 65/255, blue: 78/255))
                        Text("affirmation quotes")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    Button {
                        print("Button")
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding([.trailing], 15)
                }
                Spacer()
                Text(affirmation)
                    .onAppear {
                        affirmation = getAffirmationMessage()
                    }
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                HStack {
                    Button {
                        // Make a call to our affirmation API
                        affirmation = getAffirmationMessage()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding([.trailing], 5)
                    Button {
                        print("Button")
                    } label: {
                        Image(systemName: "heart.fill")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding([.trailing], 10)
                }
            }
        }
    }
}
struct Affirmation: Codable {
    let affirmation: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
    }
}

func getAffirmationMessage() {
    Task {
        let (data, _) = try await
            URLSession.shared.data(from:
                        URL(string: "https://www.affirmations.dev/")!)
        let decodedResponse = try?
            JSONDecoder().decode(Affirmation.self, from: data)
        
        return (decodedResponse?.affirmation as? String) ?? ""
    }
}
