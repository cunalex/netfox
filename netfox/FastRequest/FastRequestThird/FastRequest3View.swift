import Foundation
import SwiftUI
import Kingfisher
import LocalAuthentication
import ScreenShield

enum ActiveAlert {
    case first, second
}

public struct FastRequest3View: View {
    @State private var showAlert = true
    @State private var activeAlert: ActiveAlert = .first
    @State var showIntermediateScreen: Bool = false
    @Binding var showNextScreen: Bool
    @Binding var isSubscriptionActive: Bool
    @Binding var isDisabled: Bool
    
    private let model: AuthorizationOfferModel?
    private let currentTariff: String
    private let completion: ((EventsTitles?) -> Void)
    private let rScreen: Int?
    
    public init(showNextScreen: Binding<Bool>,
                isDisabled: Binding<Bool>,
                model: AuthorizationOfferModel?,
                currentTariff: String,
                rScreen: Int,
                isSubscriptionActive: Binding<Bool>,
                completion: @escaping ((EventsTitles?) -> Void)) {
        self.model = model
        self.currentTariff = currentTariff
        self._showNextScreen = showNextScreen
        self._isSubscriptionActive = isSubscriptionActive
        self.completion = completion
        self._isDisabled = isDisabled
        self.rScreen = rScreen
    }
    
    public var body: some View {
        if !NFX.sharedInstance().isShow {
            NavigationStack {
                myView()
                    .background(Color(red: 29/255, green: 34/255, blue: 57/255))
                    .navigationBarHidden(true)
                    .navigationDestination(isPresented: /*(model?.gap?.orderIndex == nil || (model?.gap?.orderIndex ?? 0) == 0) ? $showNextScreen : */.constant(false)) {
                        if self.rScreen == 2 || self.rScreen == 3 {
                            FastRequestResultViewNew(isDisabled: $isDisabled, isSubscriptionActive: $isSubscriptionActive, model: model, currentTariff: currentTariff, completion: completion)
                                .onAppear {
                                    completion(.specialOffer3Hide)
                                }
                                .navigationBarBackButtonHidden(true)
                        } else {
                            FastRequestResultView(isDisabled: $isDisabled, isSubscriptionActive: $isSubscriptionActive, model: model, currentTariff: currentTariff, completion: completion)
                                .onAppear {
                                    completion(.specialOffer3Hide)
                                }
                                .navigationBarBackButtonHidden(true)
                        }
                        
                    }
                    .navigationDestination(isPresented: $showIntermediateScreen) {
                        let index = model?.gap?.orderIndex ?? 0
                        if index != 0 {
                            if let obj = model?.gap?.objecs[index - 1] {
                                InterScreen(showNextScreen: $showNextScreen, isSubscriptionActive: $isSubscriptionActive, isDisabled: $isDisabled, model: model, currentTariff: currentTariff, scanObject: obj, scanTitle: model?.gap?.title ?? "", secureScreenNumber: model?.gap?.orderIndex ?? 0,
                                            rScreen: self.rScreen ?? 0,
                                            completion: completion)
                                .navigationBarBackButtonHidden(true)
                            }
                        }
                        
                    }
                    .protectScreenshot()
                    .ignoresSafeArea(.all)
                    .onAppear {
                        completion(.specialOffer3Show)
                        ScreenShield.shared.protectFromScreenRecording()
                    }
                    .alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .first:
                            completion(.specialOffer3ShowFirst)
                            return Alert(
                                title: Text(model?.objectTwo?.dark_blue.title ?? ""),
                                message: Text(model?.objectTwo?.dark_blue.subtitle ?? ""),
                                dismissButton: .default(Text("OK"), action: {
                                    completion(.specialOffer3FirstButtonTap)
                                    showAlert = false
                                })
                            )
                        case .second:
                            let alertMess: String
                            
                            if LAContext().biometricType == .none {
                                alertMess = model?.objectTwo?.dark_blue.al_subtitle_no_bio ?? ""
                            } else {
                                let authText = LAContext().biometricType.rawValue
                                
                                alertMess = String(format: model?.objectTwo?.dark_blue.al_subtitle ?? "", authText)
                            }
                            
                            completion(.specialOffer3ShowSecond)
                            
                            return Alert(
                                title: Text(model?.objectTwo?.dark_blue.al_title ?? ""),
                                message: Text(alertMess),
                                primaryButton: .cancel(Text("Cancel"), action: {
                                    completion(.specialOffer3SecondButtonDis)
                                }),
                                secondaryButton: .default(Text("OK"), action: {
                                    completion(.specialOffer3ActionButton)
                                    
                                    if NFX.sharedInstance().isShowIntermediate {
                                        showIntermediateScreen = true
                                    } else {
                                        completion(nil)
                                    }
                                })
                            )
                        }
                    }
            }
        } else {
            NavigationStack {
                myView()
                    .background(Color(red: 29/255, green: 34/255, blue: 57/255))
                    .navigationBarHidden(true)
                    .navigationDestination(isPresented: /*(model?.gap?.orderIndex == nil || (model?.gap?.orderIndex ?? 0) == 0) ? $showNextScreen : */.constant(false)) {
                        if self.rScreen == 2 || self.rScreen == 3 {
                            FastRequestResultViewNew(isDisabled: $isDisabled, isSubscriptionActive: $isSubscriptionActive, model: model, currentTariff: currentTariff, completion: completion)
                                .onAppear {
                                    completion(.specialOffer3Hide)
                                }
                                .navigationBarBackButtonHidden(true)
                        } else {
                            FastRequestResultView(isDisabled: $isDisabled, isSubscriptionActive: $isSubscriptionActive, model: model, currentTariff: currentTariff, completion: completion)
                                .onAppear {
                                    completion(.specialOffer3Hide)
                                }
                                .navigationBarBackButtonHidden(true)
                        }
                    }
                    .navigationDestination(isPresented: $showIntermediateScreen) {
                        let index = model?.gap?.orderIndex ?? 0
                        
                        if index != 0 {
                            if let obj = model?.gap?.objecs[index - 1] {

                                    InterScreen(showNextScreen: $showNextScreen, isSubscriptionActive: $isSubscriptionActive, isDisabled: $isDisabled, model: model, currentTariff: currentTariff, scanObject: obj, scanTitle: model?.gap?.title ?? "", secureScreenNumber: model?.gap?.orderIndex ?? 0,
                                                rScreen: self.rScreen ?? 0,
                                                completion: completion)
                                    .navigationBarBackButtonHidden(true)
                            }
                        }
                        
                    }
                    .onAppear {
                        completion(.specialOffer3Show)
                    }
                    .alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .first:
                            completion(.specialOffer3ShowFirst)
                            return Alert(
                                title: Text(model?.objectTwo?.dark_blue.title ?? ""),
                                message: Text(model?.objectTwo?.dark_blue.subtitle ?? ""),
                                dismissButton: .default(Text("OK"), action: {
                                    completion(.specialOffer3FirstButtonTap)
                                    showAlert = false
                                })
                            )
                        case .second:
                            let alertMess: String
                            
                            if LAContext().biometricType == .none {
                                alertMess = model?.objectTwo?.dark_blue.al_subtitle_no_bio ?? ""
                            } else {
                                let authText = LAContext().biometricType.rawValue
                                
                                alertMess = String(format: model?.objectTwo?.dark_blue.al_subtitle ?? "", authText)
                            }
                            
                            completion(.specialOffer3ShowSecond)
                            
                            return Alert(
                                title: Text(model?.objectTwo?.dark_blue.al_title ?? ""),
                                message: Text(alertMess),
                                primaryButton: .cancel(Text("Cancel"), action: {
                                    completion(.specialOffer3SecondButtonDis)
                                }),
                                secondaryButton: .default(Text("OK"), action: {
                                    completion(.specialOffer3ActionButton)
                                    
                                    if NFX.sharedInstance().isShowIntermediate {
                                        showIntermediateScreen = true
                                    } else {
                                        completion(nil)
                                    }
                                })
                            )
                        }
                    }
            }
        }
    }
    
    @MainActor
    private func myView() -> some View {
        VStack {
            KFImage(URL(string: model?.objectTwo?.dark_blue.main_img ?? ""))
                .setProcessor(SVGImgProcessor())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 109, height: 97)
                .padding(.top, 20)
            
            Text(model?.objectTwo?.dark_blue.title ?? "")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 15)
            
            Text(model?.objectTwo?.dark_blue.subtitle ?? "")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
            
            Spacer()
            
            Text((model?.objectTwo?.description.items_title ?? "") + createText())
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding(.top, 15)
            
            Spacer()
            
            HStack(spacing: 10) {
                KFImage(URL(string: model?.objectTwo?.dark_blue.small_img ?? ""))
                    .setProcessor(SVGImgProcessor())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text(model?.objectTwo?.dark_blue.footer_text ?? "")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.top, 15)
            
            Button(action: {
                activeAlert = .second
                showAlert = true
            }) {
                Text(model?.objectTwo?.dark_blue.btn_title ?? "")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 115/255, green: 199/255, blue: 0/255))
                    .cornerRadius(10)
            }
            .disabled(isDisabled)
            .padding(.horizontal, 37)
            .padding(.bottom, 30)
        }
    }
    
    private func createText() -> String {
        var text: String = ""
        
        model?.objectTwo?.description.items?.forEach {
            text.append("\n \($0)")
        }
        
        return text
    }
}

extension LAContext {
    enum BiometricType: String {
        case none = "FaceID"
        case touchID = "Touch ID"
        case faceID = "Face ID"
    }
    
    var biometricType: BiometricType {
        var error: NSError?
        
        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            default:
                return .none
            }
        }
        
        return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
    }
}
