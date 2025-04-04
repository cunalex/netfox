import Foundation
import SwiftUI

struct FastRequestNewSheetView: View {
    @State private var localBlackColor: Color = Color(red: 58/255, green: 58/255, blue: 58/255)
    @State private var localGreenColor: Color = Color(red: 11/255, green: 185/255, blue: 109/255)

    var model: ResultNewModel?
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 24) {
                topTextView
                advTextView
                bottomBoxView
            }
            .padding()
        }
    }
    
    private var topTextView: some View {
        VStack(spacing: 8) {
            Text(model?.sheetTitle ?? "")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(localBlackColor)
            
            Text(model?.sheetSubtitle ?? "")
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundColor(localBlackColor)
        }
    }
    
    private var advTextView: some View {
        VStack() {
            VStack(alignment: .leading, spacing: 15) {
                Text(model?.advText1Colored ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(localGreenColor)
                + Text(model?.advText1 ?? "")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(localBlackColor)
                
                Text(model?.advText2Colored ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(localGreenColor)
                + Text(model?.advText2 ?? "")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(localBlackColor)
                
                Text(model?.advText3Colored ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(localGreenColor)
                + Text(model?.advText3 ?? "")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(localBlackColor)
                
                Text(model?.advText4Colored ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(localGreenColor)
                + Text(model?.advText4 ?? "")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(localBlackColor)
            }
            .padding(.top, 33)
            .padding(.horizontal, 31)
            .padding(.bottom, 18)
        }
        .background(.white)
        .mask(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 237/255, green: 237/255, blue: 237/255), lineWidth: 1)
        )
    }
    
    private var bottomBoxView: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color(red: 172/255, green: 184/255, blue: 255/255))
                .frame(width: 12)
            
            Text(model?.sheetBottomTitle ?? "")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(localBlackColor)
                .padding(.leading, 24)
                .padding(.trailing, 28)
        }
        .background(Color(red: 234/255, green: 237/255, blue: 255/255))
        .mask(
            RoundedRectangle(cornerRadius: 16)
        )
        .frame(height: 92)
    }
}
