import Foundation
import SwiftUI
import Kingfisher

struct FastRequestNewTopPartView: View {
    @Binding var isSubscriptionActive: Bool
    @Binding var isRealtimeNewOn: Bool
    @Binding var isWifiNewOn: Bool
    @Binding var isBatteryNewOn: Bool
    
    @State private var localRedBG1Color: Color = Color(red: 254/255, green: 176/255, blue: 183/255)
    @State private var localRedBG2Color: Color = Color(red: 253/255, green: 95/255, blue: 110/255)
    @State private var localBlueBG1Color: Color = Color(red: 208/255, green: 201/255, blue: 255/255)
    @State private var localBlueBG2Color: Color = Color(red: 100/255, green: 51/255, blue: 255/255)
    
    @State private var localCircleRedColor: Color = Color(red: 255/255, green: 227/255, blue: 225/255)
    @State private var localCircleBlueColor: Color = Color(red: 205/255, green: 197/255, blue: 255/255)
    @State private var localBlackColor: Color = Color(red: 21/255, green: 21/255, blue: 21/255)
    
    var topTextR: String
    var bottomTextR: String
    var topTextB: String
    var bottomTextB: String
    var iconR: String
    var iconB: String
        
    var body: some View {
        ZStack {
            backView
            frontView
        }
    }
    
    private var frontView: some View {
        VStack {
            VStack(spacing: Constants.smallScreen ? 10 : 20) {
                Text((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? topTextB : topTextR)
                    .font(.system(size: Constants.smallScreen ? 28 : 36, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, Constants.smallScreen ? 0 : 10)
                
                Text((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? bottomTextB : bottomTextR)
                    .font(.system(size: Constants.smallScreen ? 13 : 16, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? .white : localBlackColor)
                    .padding(.horizontal)
            }
            
            Spacer()
            
//            KFImage((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? (URL(string: iconB)) : (URL(string: iconR)))
//                .setProcessor(PDFImgProcessor())
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: Constants.smallScreen ? 80 : 112, height: Constants.smallScreen ? 80 : 112)
//                .padding(.bottom, Constants.smallScreen ? 0 : 10)
            
            Image((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? ("top_icon_act") : ("top_icon_dis"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.smallScreen ? 80 : 112, height: Constants.smallScreen ? 80 : 112)
                .padding(.bottom, Constants.smallScreen ? 0 : 10)
        }
        .padding()
    }
    
    private var backView: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let circleDiameter = width * 0.6
            let circleLine1Diameter = width * 0.795
            let circleLine2Diameter = width * 0.983
            let centerX = width / 2
            let centerY = height + (width * 0.07756)
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [(isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? localBlueBG1Color : localRedBG1Color,
                                                           (isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? localBlueBG2Color : localRedBG2Color]),
                               startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ZStack {
                    Circle()
                        .stroke((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? localCircleBlueColor : localCircleRedColor, lineWidth: 1)
                        .frame(width: circleLine1Diameter, height: circleLine1Diameter)
                        .position(x: centerX, y: centerY)
                    
                    Circle()
                        .stroke((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? localCircleBlueColor : localCircleRedColor, lineWidth: 1)
                        .frame(width: circleLine2Diameter, height: circleLine2Diameter)
                        .position(x: centerX, y: centerY)
                    
                    Circle()
                        .fill((isSubscriptionActive && isRealtimeNewOn && isWifiNewOn && isBatteryNewOn) ? localCircleBlueColor : localCircleRedColor)
                        .frame(width: circleDiameter, height: circleDiameter)
                        .position(x: centerX, y: centerY)
                }
            }
            .mask(
                RoundedRectangle(cornerRadius: 24)
            )
        }
    }
}
