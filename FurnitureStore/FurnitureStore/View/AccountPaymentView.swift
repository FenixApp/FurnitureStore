//
//  AccountPaymentView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import SwiftUI

struct AccountPaymentView: View {
    
    private enum Constants {
        static let verdana = "Verdana"
        static let backImage = "chevron.backward"
        static let title = "Payment"
        static let buttonTitle = "Add now"
        static let cardNumber = "Card number"
        static let yourName = "Your Name"
        static let cardholder = "Cardholder"
        static let cardholderName = "Cardholder Name"
        static let initialCardNumber = "0000 0000 0000 0000"
        static let cardNumberPlaceholder = "**** **** **** 0000"
        static let maxCardNumberLength = 16
        static let addCard = "Add new card"
        static let month = "Month"
        static let year = "Year"
        static let cvc = "CVC"
        static let cvcPromt = "000"
        static let cvcCVV = "CVC/CVV"
        static let valid = "Valid"
        static let gradientHeight = 118.0
        static let duration = 0.3
    }
    
    @State var passwordIsHide = true
    @State var cardHolder = ""
    @State var cardNumber = ""
    @State var dateNumber = "1"
    @State var yearNumber = "2024"
    @State var cvc = ""
    @State var frontDegree = 0.0
    @State var backDegree = 90.0
    @State var isFlipped = false
    @State var iscvcAlertShown = false
    @State var isSuccessAlertShown = false
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                .frame(height: 100)
                .ignoresSafeArea(edges: .top)
            ScrollView {
                ZStack {
                    cardFrontView
                    cardBackView
                }
                .onTapGesture {
                    flipCard()
                }
                cardInputView
                dateInputView
                cvcView
            }
            .padding(.top, -70)
            Spacer()
            addNowButtonView
        }
    }
    
    private var cardFrontView: some View {
        VStack(alignment: .leading) {
            ZStack {
                LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 30)
                    .shadow(radius: 3, y: 3)
                VStack(alignment: .leading) {
                    Image(.logoMir)
                        .padding(.leading, 230)
                    Group {
                        Text(cardNumberSecurePlaceholder)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text("Card number")
                            .foregroundStyle(.appCardNumbers)
                            .font(.system(size: 16))
                        Spacer()
                            .frame(height: 20)
                        Text("Your Name")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(cardholderPlaceholder)
                            .foregroundStyle(.appCardNumbers)
                            .font(.system(size: 16))
                    }
                    .padding(.trailing, 100)
                }
            }
        }
        .rotation3DEffect(
            Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private var cardBackView: some View {
        ZStack {
            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 30)
                .shadow(radius: 3, y: 3)
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    Text(cardNumberPlaceholder)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                    HStack {
                        Text(cvcPlaceholder)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text("CVC/CVV")
                            .foregroundStyle(.appCardNumbers)
                            .font(.system(size: 16))
                    }
                    HStack {
                        Text(date)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text("Valid")
                            .foregroundStyle(.appCardNumbers)
                            .font(.system(size: 16))
                    }
                }
                .padding(.trailing, 50)
            }
        }
        .rotation3DEffect(
            Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private var cardInputView: some View {
        VStack(alignment: .leading) {
            Text("Add new card")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(.appGreen)
            TextField("", text: $cardHolder, prompt: Text("Cardholder name"))
            .foregroundStyle(.appGreen)
            .font(.system(size: 20))
            Divider()
            Text("Card number")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(.appGreen)
            if #available(iOS 17.0, *) {
                TextField("", text: $cardNumber, prompt: Text("0000 0000 0000 0000"))
                    .foregroundStyle(.appGreen)
                    .font(.system(size: 20))
                    .keyboardType(.decimalPad)
                    .onChange(of: cardNumber) { oldValue, _ in
                        if cardNumber.count > Constants.maxCardNumberLength {
                            cardNumber = oldValue
                        }
                    }
            }
            Divider()
        }
        .padding()
    }
    
    private var dateInputView: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Date")
                        .font(.system(size: 20))
                    Picker(selection: $dateNumber) {
                        ForEach (1...12, id: \.self) {Text("\($0)").tag("\($0)")}
                    } label: {
                        Text("")
                            .foregroundStyle(.appGreen)
                    }
                    .pickerStyle(.menu)
                }
                Divider()
            }
            .padding(.trailing, 40)
            VStack(alignment: .leading) {
                HStack {
                    Text("Year")
                        .font(.system(size: 20))
                    Picker(selection: $yearNumber) {
                        ForEach (0...10, id: \.self) {Text(String(2024 + $0)).tag(String(2024 + $0))}
                    } label: {
                        Text("Year")
                    }
                    .pickerStyle(.menu)
                }
                Divider()
            }
            .padding(.trailing, 40)
        }
        .tint(.appDarkGray)
        .padding(.horizontal)
    }
    
    private var cvcView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("CVC")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(.appGreen)
            HStack {
                if #available(iOS 17.0, *) {
                    if passwordIsHide {
                        SecureField("***", text: $cvc)
                            .font(.system(size: 20))
                            .foregroundStyle(.appGreen)
                            .keyboardType(.decimalPad)
                            .onChange(of: cvc) { oldValue, _ in
                                if cvc.count == 4 {
                                    cvc = oldValue
                                }
                            }
                    } else {
                        TextField("***", text: $cvc)
                            .font(.system(size: 20))
                            .foregroundStyle(.appGreen)
                            .keyboardType(.decimalPad)
                            .onChange(of: cvc) { oldValue, _ in
                                if cvc.count == 4 {
                                    cvc = oldValue
                                }
                            }
                    }
                    Button(action: {
                        passwordIsHide.toggle()
                    }){
                        Image(systemName: passwordIsHide ? "eye.slash" : "eye")
                            .foregroundStyle(.appGreen)
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var addNowButtonView: some View {
        Button {
            addNowAction()
        }
    label: {
        Text("Add now")
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
    .padding(.bottom, 20)
    .alert("Карта успешно добавлена", isPresented: $isSuccessAlertShown, actions: {})
    .alert("CVC должен иметь 3 цифры", isPresented: $iscvcAlertShown, actions: {})
    }
    
    private func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: 0.3)) {
                frontDegree = -90
                withAnimation(.linear(duration: 0.3).delay(0.3)){
                    backDegree = 0
                }
            }
        } else {
            withAnimation(.linear(duration: 0.3).delay(0.3)){
                frontDegree = 0
            }
            withAnimation(.linear(duration: 0.3)) {
                backDegree = 90
            }
        }
    }
    
    private func addNowAction() {
        print("cvcText", cvcView)
        if cvc.count == 3 {
            isSuccessAlertShown = true
        } else { iscvcAlertShown = true}
    }
    
    private var cardholderPlaceholder: String {
        cardHolder.isEmpty ? "Cardholder" : cardHolder
    }
    
    private var cardNumberSecurePlaceholder: String {
        if cardNumber.count == 16 {
            let lastSymbols = String(cardNumber.suffix(4))
            return "**** **** **** " + lastSymbols
        } else {
            return "**** **** **** 0000"
        }
    }
    
    private var cardNumberPlaceholder: String {
        cardNumber.count == 16 ? cardNumber : "0000 0000 0000 0000"
    }
    
    private var cvcPlaceholder: String {
        cvc.count == Constants.cvcPromt.count ? cvc : Constants.cvcPromt
    }
    
    private var date: String {
        let monthInteger = Int(dateNumber) ?? 0
        return String(format: "%02d", monthInteger) + "/" + String(yearNumber.suffix(2))
    }
}

#Preview {
    AccountPaymentView()
}
