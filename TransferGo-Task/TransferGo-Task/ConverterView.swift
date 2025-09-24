//
//  ConverterView.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 23/09/2025.
//

import SwiftUI

struct ConverterView: View {
    @StateObject var viewModel = ConverterViewModel()
   
    var body: some View {
        VStack{
            ZStack(alignment: .center) {
                VStack(spacing: 0) {
                    fromAndToSections(isFrom: true)
                    fromAndToSections(isFrom: false)
                }
                overContent
                    .padding(.bottom, 17)
            }
            .padding(.top, 80)
            
            if viewModel.isFrom, viewModel.isLimitReached {
                limitAlert
            }
            Spacer()
        }
        .animation(.easeIn, value: viewModel.isLimitReached)
        .padding(.horizontal, 20)
        .sheet(isPresented: $viewModel.isSheetPresented) {
            CountriesListSheet(viewModel: viewModel)
                .presentationDragIndicator(.visible)
        }
    }
    
    private func fromAndToSections(isFrom: Bool) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(isFrom ? "Sending from" : "Receiver gets")
                    .customText(font: .bodyMRegular, color: .gray)
                
                HStack(alignment: .center, spacing: 8) {
                    Image(isFrom ? viewModel.fromCurrency.flag : viewModel.toCurrency.flag)
                    Text(isFrom ? viewModel.fromCurrency.rawValue.uppercased() : viewModel.toCurrency.rawValue.uppercased())
                        .customText(font: .bodyMBold, color: .black)

                    Image(systemName: "chevron.down")
                        .foregroundStyle(.gray)
                        .imageScale(.small)
                        .fontWeight(.semibold)
                }
                .onTapGesture {
                    viewModel.isFrom = isFrom
                    viewModel.isSheetPresented = true
                }
            }
            Spacer()
            TextField("0", text: isFrom ? $viewModel.fromAmountStr : $viewModel.toAmountStr)
                .customText(font: .headingL, color: isFrom ? .blue : .black)
                .fixedSize()
                .keyboardType(.decimalPad)
                .tint(.clear)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .padding(.top, !isFrom ? 17 : 0)
        .background(isFrom ? .white : Color(red: 0.93, green: 0.94, blue: 0.96))
        .clipShape(
            .rect(
                topLeadingRadius: isFrom ? 16 :0,
                bottomLeadingRadius: 16,
                bottomTrailingRadius: 16,
                topTrailingRadius: isFrom ? 16 :0,
                style: .circular
            )
        )
        .shadow(color: isFrom ? Color(red: 0, green: 0.1, blue: 0.25).opacity(0.16) : .clear, radius: 8, x: 0, y: 0)
        .zIndex(isFrom ? 1 : 0)
        .offset(y: !isFrom ? -17 : 0)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 1)
                .stroke(isFrom && viewModel.isLimitReached ? .red : .clear, lineWidth: 2)
        }
    }
    
    var overContent: some View {
        Group{
            Button {
                withAnimation {
                    viewModel.swapCurrencies()
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down")
                    .imageScale(.small)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.blue)
                    .clipShape(.circle)
            }
            .padding(.trailing, 250)
            
            Text("1 \(viewModel.fromCurrency.rawValue.uppercased()) = 7.23 \(viewModel.toCurrency.rawValue.uppercased())")
                .customText(font: .bodyXSBold, color: .white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.black)
                .clipShape(.rect(cornerRadius: 16))
        }
    }
    
    var limitAlert: some View {
        HStack(spacing: 8){
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 14, height: 14)
            
            Text("Maximum sending amount: \(viewModel.fromCurrency.limitsForSending.formatted()) \(viewModel.fromCurrency.rawValue.uppercased())")
                .customText(font: .bodySRegular, color: .red)
        }
        .foregroundStyle(.red)
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.red.opacity(0.1))
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    ConverterView()
}
