//
//  CountriesListSheet.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import SwiftUI

struct CountriesListSheet: View {
    @ObservedObject var viewModel: ConverterViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Sending " + "\(viewModel.isFrom ? "from" : "to")")
                .customText(font: .headingM, color: .black)
                .padding(.vertical, 20)
            // TODO: Search
            
            Text("All countries")
                .customText(font: .bodyLBold, color: .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Currencies.allCases, id: \.self) { currency in
                    VStack(spacing: 0){
                        Button {
                            viewModel.changeCurrency(currency: currency)
                        } label: {
                            HStack(spacing: 16){
                                Image(currency.flag)
                                    .padding(8)
                                    .background(Color(red: 0.93, green: 0.94, blue: 0.96))
                                    .clipShape(.circle)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(currency.country)
                                        .customText(font: .bodyMBold, color: .black)
                                    Text(currency.name + " . " +  currency.rawValue.uppercased())
                                        .font(.bodyMRegular)
                                }
                                .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.48))
                                
                                Spacer()
                            }
                        }
                        .padding(.vertical, 12)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(red: 0.93, green: 0.94, blue: 0.96))
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    CountriesListSheet(viewModel: ConverterViewModel())
}
