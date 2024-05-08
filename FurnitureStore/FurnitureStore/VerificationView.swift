//
//  VerificationView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 08.05.2024.
//

import SwiftUI

/// Экран верификации
struct VerificationView: View {
    
    private struct Constants {
        static let verification = "Verification"
        static let chevronImage = "chevron.left"
        static let messageImage = "messageImage"
        static let verifCode = "Verification code"
        static let checkSms = "Check the SMS"
        static let messageVerifCode = "message to get verification code"
        static let continueText = "Continue"
        static let didntSms = "Didn't receive sms"
        static let sendAgain = "Send sms again"
        static let fillMessage = "Fill in from message"
        static let okText = "Ok"
    }
    
    private enum FieldFocusNumber: Hashable {
        case firstNumber
        case secondNumber
        case thirdNumber
        case lastNumber
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView(content: {
            ZStack {
                LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                mainContentView
                    .onAppear {
                        focused = .firstNumber
                    }
                    .onTapGesture {
                        focused = nil
                    }
            }
        })
        .ignoresSafeArea(.keyboard)
        .navigationTitle(Constants.verification)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.chevronImage)
        })
                                    .foregroundStyle(.gray)
        )
    }
    
    @Environment(\.dismiss) private var dismiss
    @State private var firstNumber = ""
    @State private var secondNumber = ""
    @State private var thirdNumber = ""
    @State private var lastNumber = ""
    @State private var randomNumber = ""
    @State private var isSendSmsAlertShow = false
    @FocusState private var focused: FieldFocusNumber?
    
    private var mainContentView: some View {
        VStack {
            Spacer()
                .frame(height: 1)
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .overlay {
                    VStack {
                        messageImageAndVerificatonCodeView
                        Spacer()
                            .frame(height: 14)
                        messageTextFieldsView
                        Spacer()
                            .frame(height: 20)
                        messageInstructionView
                        Spacer()
                            .frame(height: 20)
                        continueButtonView
                        Spacer()
                            .frame(height: 20)
                        sendSMSagainView
                        Spacer()
                    }
                }
        }
    }
    
    private var messageImageAndVerificatonCodeView: some View {
        VStack {
            Image(Constants.messageImage)
                .frame(width: 200, height: 200)
            Text(Constants.verifCode)
                .font(.system(size: 20))
                .foregroundStyle(.appGreen)
        }
    }
    
    private var messageTextFieldsView: some View {
        HStack {
            if #available(iOS 17.0, *) {
                TextField("", text: $firstNumber)
                    .frame(width: 60, height: 60)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .keyboardType(.numberPad)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.appGray, lineWidth: 2)
                    }
                    .focused($focused, equals: .firstNumber)
                    .onChange(of: firstNumber) { oldValue, newValue in
                        if newValue.count >= 1 {
                            firstNumber = String(newValue.prefix(1))
                            focused = .secondNumber
                        }
                    }
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 17.0, *) {
                TextField("", text: $secondNumber)
                    .frame(width: 60, height: 60)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .keyboardType(.numberPad)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.appGray, lineWidth: 2)
                    }
                    .focused($focused, equals: .secondNumber)
                    .onChange(of: secondNumber) { oldValue, newValue in
                        if newValue.count >= 1 {
                            secondNumber = String(newValue.prefix(1))
                            focused = .thirdNumber
                        } else if newValue == "" {
                            focused = .firstNumber
                        }
                    }
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 17.0, *) {
                TextField("", text: $thirdNumber)
                    .frame(width: 60, height: 60)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .keyboardType(.numberPad)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.appGray, lineWidth: 2)
                    }
                    .focused($focused, equals: .thirdNumber)
                    .onChange(of: thirdNumber) { oldValue, newValue in
                        if newValue.count >= 1 {
                            thirdNumber = String(newValue.prefix(1))
                            focused = .lastNumber
                        } else if newValue == "" {
                            focused = .secondNumber
                        }
                    }
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 17.0, *) {
                TextField("", text: $lastNumber)
                    .frame(width: 60, height: 60)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .keyboardType(.numberPad)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.appGray, lineWidth: 2)
                    }
                    .focused($focused, equals: .lastNumber)
                    .onChange(of: lastNumber) { oldValue, newValue in
                        if newValue.count >= 1 {
                            lastNumber = String(newValue.prefix(1))
                            focused = nil
                        } else if newValue == "" {
                            focused = .thirdNumber
                        }
                    }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private var messageInstructionView: some View {
        VStack(spacing: 8) {
            Text(Constants.checkSms)
                .font(.system(size: 20))
            Text(Constants.messageVerifCode)
                .font(.system(size: 16))
        }
        .foregroundStyle(.appGreen)
    }
    
    private var continueButtonView: some View {
        Button {
        } label: {
            Text(Constants.continueText)
                .padding(.vertical, 20)
                .padding(.horizontal, 120)
                .font(.title2.bold())
                .background(
                    LinearGradient(colors: [Color.appLightGreen, Color.appGreen], startPoint: .leading, endPoint: .trailing)
                )
                .foregroundStyle(.white)
        }
        .cornerRadius(27)
        .shadow(color: .gray, radius: 2, x: 0.0, y: 3.0)
    }
    
    private var sendSMSagainView: some View {
        VStack {
            Text(Constants.didntSms)
                .font(.system(size: 20))
            Spacer()
                .frame(height: 7)
            Button(action: {
                randomNumber = String(Int.random(in: 1000...9999))
                isSendSmsAlertShow = true
            }, label: {
                Text(Constants.sendAgain)
                    .font(.system(size: 20))
                    .foregroundStyle(.appGreen)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
            .alert(isPresented: $isSendSmsAlertShow) {
                Alert(
                    title: Text(Constants.fillMessage),
                    message: Text(randomNumber),
                    primaryButton: .cancel(),
                    secondaryButton: .default(Text(Constants.okText), action: {
                        fillTextFields()
                    }))
            }
            .frame(width: 300, height: 30)
            .padding(.zero)
            Divider()
                .frame(width: 160, height: 1.0)
                .background(.gray)
        }
        .foregroundStyle(.appGreen)
    }
    
    private func fillTextFields() {
        firstNumber = String(randomNumber.removeFirst())
        secondNumber = String(randomNumber.removeFirst())
        thirdNumber = String(randomNumber.removeFirst())
        lastNumber = String(randomNumber.removeFirst())
    }
}

#Preview {
    VerificationView()
}
