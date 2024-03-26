//
//  ContentView.swift
//  SearchTokensBug
//
//  Created by Matthew Hanlon on 3/26/24.
//

import SwiftUI

struct ContentView: View {
    enum Token: String, Identifiable, CaseIterable {
        case human = "Human"
        case candy = "Candy"
        case vampire = "Vampire"
        case other = "Other"
        
        var id: String { rawValue }
    }
        
    @State var selected: String?
    @State var searchText: String = ""
    
    let names = [
        "Finn",
        "Jake",
        "Simon",
        "Bonnie",
        "Marceline",
        "Fiona",
        "Cake",
        "Gunter",
        "Betty",
        "Lady",
        "Phoebe",
    ]
    
    var filteredNames: [String] {
        if searchText == "" {
            return names
        }
        return names.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    @State var currentTokens = [Token]()
    
    var suggestedTokens: [Token] {
        if searchText.contains("#") {
            return Token.allCases
        } else {
            return .init()
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selected) {
                ForEach(filteredNames, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
            .searchable(
                text: $searchText,
                tokens: $currentTokens,
                suggestedTokens: .constant(suggestedTokens),
                placement: .sidebar, // commenting out this line will cause suggested tokens to work as expected
                prompt: "Search names"
            ) {
                token in
                Label {
                    Text(token.rawValue)
                } icon: {
                    Image(systemName: "circle.fill")
                }
            }
        } detail: {
            Text("Hello, world")
        }
    }
}

#Preview {
    ContentView()
}
