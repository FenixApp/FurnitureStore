//
//  AuthorizationView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 07.05.2024.
//

import SwiftUI

/// Экран авторизации
struct AuthorizationView: View {
    
    private struct Constants {
        static let password = "Password"
        static let chevronImage = "chevron.left"
        static let forgotPassword = "Forgot your password?"
        static let help = "Телефон поддержки"
        static let phoneNumber = "+7 (123) 456-78-99"
        static let signUp = "Sing up"
        static let phoneTextfield = "+9 (999) 999-99-99"
        static let symbols = "●●●●●●"
        static let eyeSlash = "eye.slash"
        static let eye = "eye"
        static let checkVerif = "Check Verification"
        static let error = "Ошибка"
        static let makePassword = "Пароль должен быть больше 6 символов"
        static let login = "Log in"
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = AuthorisationViewModel()
    @State var totalPasswordChars = 0
    @State var lastPasswordText = ""
    @State var isShowingVerificationScreen = false
    @FocusState var isPhoneFocused: Bool
    @FocusState var isPasswordFocused: Bool
    
    var body: some View {
        NavigationView(content: {
            VStack {
                Spacer()
                    .frame(height: 1)
                mainView
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(
                VStack {
                    LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                }
                    .ignoresSafeArea(.all, edges: .all)
            )
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: Constants.chevronImage)
            })
                                        .foregroundStyle(.gray)
            )
        })
    }
    
    @State private var phoneNumberText = ""
    @State private var passwordText = ""
    @State private var isForgotAlertShow = false
    @State private var isPasswordAlertShow = false
    
    private var mainView: some View {
        VStack {
            Spacer()
                .frame(height: 37)
            pickerView
            Spacer()
                .frame(height: 78)
            phoneTextFieldView
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Divider()
                .frame(maxHeight: 1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
                .frame(height: 24)
            Text(Constants.password)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .padding(.trailing, 280)
                .foregroundStyle(.appGreen)
                .modifier(ShakeEffect(shakes: isPasswordAlertShow ? 2 : 0))
            passwordTextFieldView
            Divider()
                .frame(maxHeight: 1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
                .frame(height: 111)
            signUpButtonView
            Spacer()
                .frame(height: 24)
            Button(action: {
                isForgotAlertShow = true
            }) {
                Text(Constants.forgotPassword)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.appGreen)
            }
            .alert(Constants.help, isPresented: $isForgotAlertShow, actions: {
            }, message: {
                Text(Constants.phoneNumber)
            })
            Spacer()
                .frame(height: 18)
            NavigationLink(destination: VerificationView()) {
                checkVerificationView
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    private var pickerView: some View {
        HStack(spacing: 0) {
            if #available(iOS 16.0, *) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 27.0,
                    bottomLeading: 27.0,
                    bottomTrailing: 0,
                    topTrailing: 0),
                                       style: .continuous)
                .stroke(.appGray, lineWidth: 2)
                .frame(width: 150, height: 51)
                .overlay {
                    Text(Constants.login)
                        .foregroundStyle(
                            LinearGradient(colors: [Color.appGreen, Color.appLightGreen.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                        )
                        .font(.title2.bold())
                }
            }
            
            if #available(iOS 16.0, *) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 0,
                    bottomTrailing: 27.0,
                    topTrailing: 27.0),
                                       style: .continuous)
                .frame(width: 150, height: 53)
                .foregroundStyle(.appGray)
                .overlay {
                    Text(Constants.signUp)
                        .foregroundStyle(
                            LinearGradient(colors: [Color.appGreen, Color.appLightGreen.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                        )
                        .font(.title2.bold())
                }
            }
        }
    }
    
    private var phoneTextFieldView: some View {
        TextField(Constants.phoneTextfield, text: $phoneNumberText)
            .font(.title2)
            .onChange(of: phoneNumberText) { text in
                phoneNumberText = viewModel.format(phone: text)
            }
            .keyboardType(.phonePad)
            .textContentType(.telephoneNumber)
            .focused($isPhoneFocused)
    }
    
    private var passwordTextFieldView: some View {
        HStack {
            Group {
                if viewModel.passwordIsHide {
                    SecureField(Constants.symbols, text: $passwordText)
                        .font(.title2.bold())
                } else {
                    TextField(Constants.symbols, text: $passwordText)
                        .font(.title2.bold())
                }
            }
            .focused($isPasswordFocused)
            .onChange(of: passwordText) { text in
                totalPasswordChars = text.count
                if totalPasswordChars <= 15 {
                    lastPasswordText = text
                } else {
                    passwordText = lastPasswordText
                    isPasswordFocused = false
                }
            }
            Button(action: {
                viewModel.passwordIsHide.toggle()
            }){
                Image(systemName: viewModel.passwordIsHide ? Constants.eyeSlash : Constants.eye)
                    .foregroundStyle(.appGreen)
            }
        }
        .modifier(ShakeEffect(shakes: isPasswordAlertShow ? 2 : 0))
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
    
    private var signUpButtonView: some View {
        Button {
            if passwordText.count < 6 {
                withAnimation {
                    isPasswordAlertShow = true
                }
            } else {
                isShowingVerificationScreen = true
            }
        } label: {
            Text(Constants.signUp)
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
    
    private var checkVerificationView: some View {
        VStack {
            NavigationLink {
                VerificationView()
            } label: {
                Text(Constants.checkVerif)
                    .font(.system(size: 20).bold())
                    .foregroundStyle(.appGreen)
                    .padding(.bottom, 5)
                    .alert(Constants.error, isPresented: $isPasswordAlertShow, actions: {
                    }, message: {
                        Text(Constants.makePassword)
                    })
            }
            Divider()
                .frame(width: 160, height: 1)
                .foregroundStyle(.gray)
        }
    }
}

struct ShakeEffect: GeometryEffect {
        func effectValue(size: CGSize) -> ProjectionTransform {
            return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
        }

        init(shakes: Int) {
            position = CGFloat(shakes)
        }

        var position: CGFloat
        var animatableData: CGFloat {
            get { position }
            set { position = newValue }
        }
    }

#Preview {
    AuthorizationView()
}
