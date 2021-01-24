//
//  Search.swift
//  Sticky
//
//  Created by deo on 2021/01/24.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var locationSearchService: LocationSearchService

    var body: some View {
        VStack {
            SearchBar(text: $locationSearchService.searchQuery)
            List(locationSearchService.completions) { completion in
                VStack(alignment: .leading) {
                    Text(completion.title)
                    Text(completion.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }.navigationBarTitle(Text("Search near me"))
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .environmentObject(LocationSearchService())
    }
}
