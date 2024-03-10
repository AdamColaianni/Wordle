//
//  Guess.swift
//  Wordle
//
//  Created by 90310013 on 3/4/24.
//

import Foundation
import SwiftUI

struct Guess {
  var word: String = ""
  var submitted: Bool = false
  var colors: [Color] = Array(repeating: .black, count: 5)
  
  mutating func reset() {
    self.word = ""
    for index in 0..<5 {
      colors[index] = .black
    }
    self.submitted = false
  }
}
