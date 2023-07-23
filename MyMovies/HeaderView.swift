//
//  HeaderView.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text(Wordings.headerText)
                .font(.title)
            Spacer()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}

