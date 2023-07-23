//
//  SearchBarView.swift
//  MyMovies
//
//  Created by Christos Tzimas on 22/7/23.
//

import SwiftUI

struct SearchBarView: View {
    private let placeholder = Wordings.searchBarPlaceholderText
    
    @Binding var text: String
    @State var showClearButton = false
    
    var body: some View {
        TextField(placeholder, text: $text) { editing in
            self.showClearButton = editing
        } onCommit: {
            self.showClearButton = false
        }
        .modifier(ClearButton(text: $text, isVisible: $showClearButton))
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color(.placeholderText))
                .opacity(!text.isEmpty ? 1 : 0)
                .opacity(isVisible ? 1 : 0)
                .onTapGesture { self.text = "" }
        }
    }
}
