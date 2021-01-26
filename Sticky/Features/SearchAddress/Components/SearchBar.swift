//
//  SearchBar.swift
//  Sticky
//
//  Created by deo on 2021/01/24.
//

import SwiftUI

// MARK: - SearchBar

struct SearchBar: UIViewRepresentable {
    class Coordinator: NSObject, UISearchBarDelegate {
        // MARK: Lifecycle

        init(text: Binding<String>) {
            _text = text
        }

        // MARK: Internal

        @Binding var text: String

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    @Binding var text: String

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

// MARK: - SearchBar_Previews

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("hi"))
    }
}
