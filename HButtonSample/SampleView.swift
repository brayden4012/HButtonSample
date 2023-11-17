//
//  ContentView.swift
//  HButtonSample
//
//  Created by Brayden Harris on 11/16/23.
//

import HButton
import SwiftUI

struct SampleView: View {
    @State var showPopover = false
    @State var actionText: String?

    var body: some View {
        ZStack {
            VStack {
                HButton(title: "Primary button", style: .primary) {
                    actionText = "Primary button tapped"
                } doubleTapAction: {
                    actionText = "Primary button double-tapped"
                }

                HButton(title: "Secondary button", style: .secondary) {
                    actionText = "Secondary button tapped"
                } doubleTapAction: {
                    actionText = "Secondary button double-tapped"
                }

                contextMenuButton
            }

            VStack {
                Spacer()
                if let actionText {
                    Text(actionText)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                self.actionText = nil
                            }
                        }
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: actionText)
    }

    private var contextMenuButton: some View {
        HButton(
            title: "Context menu button",
            style: .primary
                .withBackgroundColor(.red)
                .withBorderColor(.black)
                .withBorderWidth(3)
        ) {
            actionText = "Context menu button tapped"
        } doubleTapAction: {
            actionText = "Context menu button double-tapped"
        } longPressAction: {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover) {
            Text("Hello, world")
                .padding(.horizontal)
                .presentationCompactAdaptation(.popover)
        }
    }
}

#Preview {
    SampleView()
}
