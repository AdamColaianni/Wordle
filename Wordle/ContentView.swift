//
//  ContentView.swift
//  Wordle
//
//  Created by 90310013 on 2/17/24.
//

import SwiftUI

struct ContentView: View {
  @State private var squish: Bool = false
  @State private var fill: Bool = false
  @State var colors: [Color] = Array(repeating: .black, count: 5)
  
  @State var greenKeys: [String] = []
  @State var yellowKeys: [String] = []
  @State var grayKeys: [String] = []
  
  func animate(colors: [Color]) {
    withAnimation(.easeInOut(duration: 0.25)) {
      self.squish.toggle()
    } completion: {
      self.colors = colors
      self.fill.toggle()
      withAnimation(.easeInOut(duration: 0.25)) {
        self.squish.toggle()
      }
    }
  }
  
  func reset() {
    animate(colors: Array(repeating: .black, count: 5))
  }
  
  func displayedWord(word: [String]) -> some View {
    HStack(spacing: 10) {
      ForEach(0..<5) { index in
        var imageName = "square"
        if index < word.count {
          imageName = String(word[index]) + ".square" + (fill ? ".fill" : "")
        }
        return Image(systemName: imageName)
          .resizable()
          .frame(width: 60.0, height: 60.0)
          .foregroundColor(colors[index])
          .scaleEffect(x: 1, y: squish ? 0.0 : 1.0)
        
      }
    }
  }
  
  @ObservedObject var keyboardViewModel = KeyboardViewModel(greenKeys: [], yellowKeys: [], grayKeys: [])
  @ObservedObject var guessGridViewModel = GuessGridViewModel()
  
  var body: some View {
    Spacer()
    
    GuessGridView(viewModel: guessGridViewModel)
//        displayedWord(word: keyboardViewModel.typedWord)
//          .padding(.bottom, 10.0)
    
//    HStack {
//      Button(action: {reset()}) {
//        Text("Reset")
//      }
//      Button(action: {animate(colors: [.gray, .green, .yellow, .gray, .green])}) {
//        Text("Animate")
//      }
//    }
//    .buttonStyle(SubmitButtonStyle())
    
    Spacer()
    
    KeyboardView(viewModel: keyboardViewModel)
    
    Spacer()
  }
}

struct SubmitButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .foregroundColor(.white)
      .background(Rectangle()
        .foregroundColor(Color.blue)
        .cornerRadius(5))
  }
}

#Preview {
  ContentView()
}
