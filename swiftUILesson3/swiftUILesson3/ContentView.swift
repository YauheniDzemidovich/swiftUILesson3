//
//  ContentView.swift
//  swiftUILesson3
//
//  Created by Yauheni Dzemidovich on 5.10.23.
//

import SwiftUI

private enum Settings {
    static let elementSize = 30.0
    static let duration = 0.25
    static let imageName = "play.fill"
}

struct NextTrackButton: View {

    @Binding var isAnimating: Bool

    var body: some View {
        let startElementSize = isAnimating ? Settings.elementSize : 0.0
        let endElementSize = isAnimating ? 0.0 : Settings.elementSize
        Button(action: {
            self.isAnimating.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + Settings.duration) {
                isAnimating.toggle()
            }
        }) {
            HStack(spacing: 0) {
                Image(systemName: Settings.imageName)
                    .resizable()
                    .frame(width: startElementSize, height: startElementSize)
                Image(systemName: Settings.imageName)
                    .resizable()
                    .frame(width: Settings.elementSize, height: Settings.elementSize)
                Image(systemName: Settings.imageName)
                    .resizable()
                    .frame(width: endElementSize, height: endElementSize)
            }
            .animation(isAnimating ? .spring(dampingFraction: 0.5, blendDuration: Settings.duration) : nil, value: isAnimating)
        }
    }
}

struct ContentView: View {

    @State private var isAnimating = false
    
    var body: some View {
        NextTrackButton(isAnimating: $isAnimating)
            .padding(.all, isAnimating ? Settings.elementSize * 1.5 : Settings.elementSize * 1.2)
            .background(isAnimating ? .gray.opacity(0.2) : .clear)
            .clipShape(Circle())
            .animation(.easeInOut, value: isAnimating)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
