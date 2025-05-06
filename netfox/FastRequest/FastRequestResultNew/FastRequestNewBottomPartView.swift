import Foundation
import SwiftUI

struct FastRequestNewBottomPartView: View {
    @Binding var isSubscriptionActive: Bool
    @Binding var isRealtimeNewOn: Bool
    @Binding var isWifiNewOn: Bool
    @Binding var isBatteryNewOn: Bool
    
    @State private var button1BGColor: Color = Color(red: 11/255, green: 185/255, blue: 109/255)
    @State private var button2BGColor: Color = Color.clear
    @State private var button2TextColor: Color = Color(red: 58/255, green: 58/255, blue: 58/255)
    @State private var button2BorderWidth: CGFloat = 1
    @State private var button2FontWeight: Font.Weight = .medium
    @State private var button2FontSize: CGFloat = 12
    
    @State private var isLoading2 = false
    @State private var isLoading3 = false
    @State private var isLoading4 = false
    @State private var isButtonDisabled = false
    @State private var button1TitleText = ""
    @State private var button2TitleText = ""
    
    var model: ResultNewModel?
    
    let sheetButtonAction: () -> Void
    let openFeature1Action: () -> Void
    let openFeature2Action: () -> Void
    let openWallViewAction: () -> Void
    let topButtonEventAction: () -> Void
    let completeAllEventAction: () -> Void
    
    public var body: some View {
        VStack {
            mainView
                .onAppear {
                    setupState()
                }
        }
    }
    
    private var mainView: some View {
        VStack {
            cellView
            buttonsView
        }
        .background(.white)
        .mask(
            RoundedRectangle(cornerRadius: 24)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(red: 237/255, green: 237/255, blue: 237/255), lineWidth: 1)
        )
    }
    
    private var cellView: some View {
        VStack(spacing: 11) {
            HStack(spacing: 11) {
                FastRequestBoxView(topTextG: model?.boxTitleAct ?? "",
                                   topTextR: model?.boxTitleDis ?? "",
                                   title: model?.box1Subtitle ?? "",
                                   iconNameG: model?.box1IconAct ?? "",
                                   iconNameR: model?.box1IconDis ?? "",
                                   iconCheckBoxG: model?.boxCheckMarkAct ?? "",
                                   iconCheckBoxR: model?.boxCheckMarkDis ?? "",
                                   isLoading: false,
                                   isActive: isSubscriptionActive)
                    
                FastRequestBoxView(topTextG: model?.boxTitleAct ?? "",
                                   topTextR: model?.boxTitleDis ?? "",
                                   title: model?.box2Subtitle ?? "",
                                   iconNameG: model?.box2IconAct ?? "",
                                   iconNameR: model?.box2IconDis ?? "",
                                   iconCheckBoxG: model?.boxCheckMarkAct ?? "",
                                   iconCheckBoxR: model?.boxCheckMarkDis ?? "",
                                   isLoading: isLoading2,
                                   isActive: isRealtimeNewOn && isSubscriptionActive)
            }
            .frame(height: Constants.smallScreen ? 80 : 92)
            
            HStack(spacing: 11) {
                FastRequestBoxView(topTextG: model?.boxTitleAct ?? "",
                                   topTextR: model?.boxTitleDis ?? "",
                                   title: model?.box3Subtitle ?? "",
                                   iconNameG: model?.box3IconAct ?? "",
                                   iconNameR: model?.box3IconDis ?? "",
                                   iconCheckBoxG: model?.boxCheckMarkAct ?? "",
                                   iconCheckBoxR: model?.boxCheckMarkDis ?? "",
                                   isLoading: isLoading3,
                                   isActive: isWifiNewOn && isSubscriptionActive)
                
                FastRequestBoxView(topTextG: model?.boxTitleAct ?? "",
                                   topTextR: model?.boxTitleDis ?? "",
                                   title: model?.box4Subtitle ?? "",
                                   iconNameG: model?.box4IconAct ?? "",
                                   iconNameR: model?.box4IconDis ?? "",
                                   iconCheckBoxG: model?.boxCheckMarkAct ?? "",
                                   iconCheckBoxR: model?.boxCheckMarkDis ?? "",
                                   isLoading: isLoading4,
                                   isActive: isBatteryNewOn && isSubscriptionActive)
            }
            .frame(height: Constants.smallScreen ? 80 : 92)
        }
        .padding()
    }
    
    private var buttonsView: some View {
        VStack {
            Button(action: {
                topButtonAction()
            }) {
                Text(button1TitleText)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(button1BGColor)
                    .cornerRadius(16)
            }
            .frame(height: Constants.smallScreen ? 48 : 53)
            .disabled(isButtonDisabled)
            
            Button(action: {
                bottomButtonAction()
            }) {
                Text(button2TitleText)
                    .font(.system(size: button2FontSize, weight: button2FontWeight))
                    .foregroundColor(button2TextColor)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 163/255, green: 163/255, blue: 163/255), lineWidth: button2BorderWidth)
                    )
                    .background(button2BGColor)
                    .cornerRadius(16)
            }
            .frame(height: Constants.smallScreen ? 48 : 53)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private func setupState() {
        setupButton1Titile()
        setupButton2Titile()
    }
    
    private func topButtonAction() {
        if isSubscriptionActive {
            if isRealtimeNewOn, isWifiNewOn, isBatteryNewOn {
                topButtonActionExternal()
            } else {
                topButtonActionInternal()
            }
        } else {
            openWallView()
        }
    }
    
    private func bottomButtonAction() {
        if isSubscriptionActive, isRealtimeNewOn, isWifiNewOn, isBatteryNewOn {
            bottomButtonActionExternal()
        } else {
            bottomButtonActionInternal()
        }
    }
    
    private func topButtonActionExternal() {
        openFeature1Action()
    }
    
    private func topButtonActionInternal() {
        topButtonEventAction()
        startLoading()
    }
    
    private func bottomButtonActionExternal() {
        openFeature2Action()
    }
    
    private func bottomButtonActionInternal() {
        sheetButtonAction()
    }
    
    private func openWallView() {
        openWallViewAction()
    }
    
    private func startLoading() {
        isButtonDisabled = true
        isLoading2 = true
        isLoading3 = true
        isLoading4 = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading4 = false
            isBatteryNewOn = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isLoading3 = false
                isWifiNewOn = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isLoading2 = false
                    
                    withAnimation {
                        isRealtimeNewOn = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isButtonDisabled = false
                        completeAllEventAction()
                        withAnimation {
                            setupState()
                        }
                    }
                }
            }
        }
    }
    
    private func setupButton1Titile() {
        let buttonTitileInit = model?.topButtonTitle ?? ""
        let buttonTitileFinal = NFX.sharedInstance().feature1Title
        
        if isSubscriptionActive, isRealtimeNewOn, isWifiNewOn, isBatteryNewOn {
            button1TitleText = buttonTitileFinal
            button1BGColor = Color(red: 8/255, green: 128/255, blue: 226/255)
        } else {
            button1TitleText = buttonTitileInit
            button1BGColor = Color(red: 11/255, green: 185/255, blue: 109/255)
        }
    }
    
    private func setupButton2Titile() {
        let buttonTitileInit = model?.bottomButtonTitle ?? ""
        let buttonTitileFinal = NFX.sharedInstance().feature2Title
        
        if isSubscriptionActive, isRealtimeNewOn, isWifiNewOn, isBatteryNewOn {
            button2TitleText = buttonTitileFinal
            button2BGColor = Color(red: 155/255, green: 75/255, blue: 219/255)
            button2BorderWidth = 0
            button2TextColor = .white
            button2FontWeight = .semibold
            button2FontSize = 14
        } else {
            button2TitleText = buttonTitileInit
            button2BGColor = .clear
            button2BorderWidth = 1
            button2TextColor = Color(red: 58/255, green: 58/255, blue: 58/255)
            button2FontWeight = .medium
            button2FontSize = 12
        }
    }
}
