import Foundation
import SwiftUI
import ScreenShield

public struct FastRequestResultViewNew: View {
    @AppStorage("isRealtimeNew") private var isRealTimeNew = false
    @AppStorage("isWifiNew") private var isWifiNew = false
    @AppStorage("isBatteryNew") private var isBatteryNew = false
    
    @State private var showingSheet = false
    @State private var isSheetPresented = false
    @State private var sheetHeight: CGFloat = .zero
    
    @Binding var isSubscriptionActive: Bool
    @Binding var isDisabled: Bool
    @State private var isProtect = false
    
    private let model: AuthorizationOfferModel?
    private let currentTariff: String?
    private let completion: ((EventsTitles?) -> Void)?
    
    public init(isDisabled: Binding<Bool>, isSubscriptionActive: Binding<Bool>, model: AuthorizationOfferModel?, currentTariff: String?, completion: ((EventsTitles?) -> Void)?) {
        self._isSubscriptionActive = isSubscriptionActive
        self.model = model
        self.currentTariff = currentTariff
        self.completion = completion
        self._isDisabled = isDisabled
    }
    
    public var body: some View {
        if !NFX.sharedInstance().isShow {
            myView()
                .navigationBarHidden(true)
                .sheet(isPresented: $showingSheet) {
                    SuperRequestView(isDisabled: $isDisabled, currentTariff: currentTariff, completion: completion)
                }
                .fastRequestpopupSheet(isPresented: $isSheetPresented, onDismiss: {
                    print("Sheet was dismissed")
                }){
                    return VStack {
                        FastRequestNewSheetView(model: model?.resultNew)
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
                }
                .protectScreenshot()
                .onAppear {
                    checkState()
                    completion?(.specialOffer5NewShow)
                    ScreenShield.shared.protectFromScreenRecording()
                }
                .onChange(of: isSubscriptionActive) { newValue in
                    if newValue {
                        completion?(.specialOffer5NewGreenOne)
                    }
                }
        } else {
            myView()
                .navigationBarHidden(true)
                .sheet(isPresented: $showingSheet) {
                    SuperRequestView(isDisabled: $isDisabled, currentTariff: currentTariff, completion: completion)
                }
                .fastRequestpopupSheet(isPresented: $isSheetPresented, onDismiss: {
                    print("Sheet was dismissed")
                }){
                    return VStack {
                        FastRequestNewSheetView(model: model?.resultNew)
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
                }
                .onAppear {
                    checkState()
                    completion?(.specialOffer5NewShow)
                }
                .onChange(of: isSubscriptionActive) { newValue in
                    if newValue {
                        completion?(.specialOffer5NewGreenOne)
                    }
                }
        }
        
    }
    
    @MainActor
    private func myView() -> some View {
        ZStack {
            Color(red: 246/255, green: 246/255, blue: 246/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15) {
                FastRequestNewTopPartView(isSubscriptionActive: $isSubscriptionActive,
                                          isRealtimeNewOn: $isRealTimeNew,
                                          isWifiNewOn: $isWifiNew,
                                          isBatteryNewOn: $isBatteryNew,
                                          topTextR: model?.resultNew?.titleDis ?? "",
                            bottomTextR: model?.resultNew?.subtitleDis ?? "",
                            topTextB: model?.resultNew?.titleAct ?? "",
                            bottomTextB: model?.resultNew?.subtitleAct ?? "",
                            iconR: model?.resultNew?.topIconDis ?? "",
                            iconB: model?.resultNew?.topIconAct ?? "")
                
                FastRequestNewBottomPartView(isSubscriptionActive: $isSubscriptionActive,
                                             isRealtimeNewOn: $isRealTimeNew,
                                             isWifiNewOn: $isWifiNew,
                                             isBatteryNewOn: $isBatteryNew,
                                             model: model?.resultNew,
                                             sheetButtonAction: {
                    isSheetPresented = true
                    completion?(.specialOffer5NewButtonLow1Tap)
                },
                                             openFeature1Action: {
                    completion?(.feature1Action)
                },
                                             openFeature2Action: {
                    completion?(.feature2Action)
                    completion?(.specialOffer5NewButtonLow2Tap)
                },
                                             openWallViewAction: {
//                    completion?(nil)
                    showingSheet = true
                }, topButtonEventAction: {
                    completion?(.specialOffer5NewButtonTap)
                }, completeAllEventAction: {
                    completion?(.specialOffer5NewGreenComplete)
                })
            }
            .padding()
        }
    }
    
    private func checkState() {
        if !isSubscriptionActive {
            isRealTimeNew = false
            isWifiNew = false
            isBatteryNew = false
        }
    }
}


