//
//  ShortcutScrollView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI

struct CustomCardButton: View {
    var text: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 8)
                Text(text)
                    .bold()
                    .font(.title2)
            }
            .foregroundColor(.black)
            .padding(.vertical , 10)
            .padding(.horizontal, 25)
        
        }
        .background {
            Color.white
                .cornerRadius(18)
                .shadow(color: .black.opacity(0.24), radius: 8, x: 0, y: 4)
        }
    }
}

struct ShortcutScrollView: View {
    @Binding var destinationSelected: Bool
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    destinationSelected = true
                } label: {
                    Image("naviButton")
                        .resizable()
                        .frame(width: 85, height: 85)
                }
            }
            .offset(y: 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(bookMarkList) { bookmark in
                        CustomCardButton(text: bookmark.bookMarkName, imageName: bookmark.bookMarkImage, action: {
                            Coordinator.shared.moveToBookmarkDestination(bookmark.bookMarkAddress.0, bookmark.bookMarkAddress.1)
                            destinationSelected = true
                        })
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}
struct ShortcutScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutScrollView(destinationSelected: Binding.constant(true))
    }
}
