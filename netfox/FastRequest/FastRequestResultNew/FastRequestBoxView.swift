import Foundation
import SwiftUI
import Kingfisher

struct FastRequestBoxView: View {
    @State private var localGreenColor: Color = Color(red: 11/255, green: 185/255, blue: 109/255)
    @State private var localRedColor: Color = Color(red: 252/255, green: 55/255, blue: 73/255)
    
    var topTextG: String
    var topTextR: String
    var title: String
    var iconNameG: String
    var iconNameR: String
    var iconCheckBoxG: String
    var iconCheckBoxR: String
    let isLoading: Bool
    var isActive: Bool
    
    var body: some View {
        VStack {
            mainView
        }
    }
    
    private var mainView: some View {
        ZStack {
            backView
            
            HStack(spacing: 0) {
                lineView
                textView
                Spacer()
            }
        }
        .background(isActive ? localGreenColor.opacity(0.11) : .white)
        .mask(
            RoundedRectangle(cornerRadius: 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isActive ? localGreenColor.opacity(0.19) : localRedColor, lineWidth: 1)
        )
    }
    
    private var lineView: some View {
        Rectangle()
            .fill(isActive ? localGreenColor : localRedColor)
            .frame(width: 5)
    }
    
    private var backView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
//                Image(isActive ? iconNameG : iconNameR)
                KFImage(isActive ? (URL(string: iconNameG)) : (URL(string: iconNameR)))
                    .setProcessor(SVGImgProcessor())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 40, height: 40)
            }
        }
    }
    
    private var textView: some View {
        VStack(alignment: .leading){
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .frame(width: Constants.smallScreen ? 20 : 23, height: Constants.smallScreen ? 20 : 23)
                } else {
//                    Image(isActive ? iconCheckBoxG : iconCheckBoxR)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: Constants.smallScreen ? 20 : 23, height: Constants.smallScreen ? 20 : 23)
                    
                    KFImage(isActive ? (URL(string: iconCheckBoxG)) : (URL(string: iconCheckBoxR)))
                        .setProcessor(SVGImgProcessor())
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.smallScreen ? 20 : 23, height: Constants.smallScreen ? 20 : 23)
                }
                
                Text(isActive ? topTextG : topTextR)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(isActive ? localGreenColor : localRedColor)
                    .multilineTextAlignment(.leading)
            }
            Text(title)
                .font(.system(size: Constants.smallScreen ? 11 : 12, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}
