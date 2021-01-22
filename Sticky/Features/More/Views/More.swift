//
//  More.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

struct More: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            NavigationLink(destination: SearchAddress()) {
                Text("주소 변경")
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .navigationBarTitle("더보기", displayMode: .inline)
        }
    }

    var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("back")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }

    func focusRelease() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct More_Previews: PreviewProvider {
    static var previews: some View {
        More()
    }
}
