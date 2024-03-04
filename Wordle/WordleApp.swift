//
//  WordleApp.swift
//  Wordle
//
//  Created by 90310013 on 2/17/24.
//

import SwiftUI

@main
struct WordleApp: App {
  @ObservedObject var datamodel = WordleDataModel()
  var body: some Scene {
    WindowGroup {
      MainView()
        .environmentObject(datamodel)
    }
  }
}
