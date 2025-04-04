import Foundation
import SwiftUI

struct FastRequestPopupSheetModifier<SheetContent: View>: ViewModifier {
    @State private var sheetHeight: CGFloat = .zero

    @Binding var isPresented: Bool
    
    let onDismiss: (() -> Void)?
    let content: () -> SheetContent

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: onDismiss)
            {
                ScrollView
                {
                    self.content()
                        .modifier(FastRequestGetHeightModifier(height: $sheetHeight))
                        .presentationDetents([.height(sheetHeight)])
                        .presentationDragIndicator(.visible)
                }
            }
    }
}

extension View {
    func fastRequestpopupSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(FastRequestPopupSheetModifier(isPresented: isPresented, onDismiss: onDismiss, content: content))
    }
}

struct FastRequestGetHeightModifier: ViewModifier
{
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                height = geo.size.height
                return .clear
            }
        )
    }
}

