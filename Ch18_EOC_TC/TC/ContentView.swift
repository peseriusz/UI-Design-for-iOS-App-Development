//
//  ContentView.swift
//  TC
//
//  Created by Bear Cahill on 9/14/20.
//

import SwiftUI

struct ContentView: View {
    @State private var tipSelected = 1
    @State private var billInput = ""
    private var tipPercentages = [0.1, 0.15,
                0.2, 0.25]
    private var numFormatter : NumberFormatter {
            let nf = NumberFormatter()
            nf.numberStyle = .currency
            nf.isLenient = true
            return nf
        }
    private var billAmount : Double {
            numFormatter.number(from:
                billInput)?
                .doubleValue ?? 0.0
        }
    private var tipAmount : Double {
            billAmount * tipPercentages[tipSelected] }
    private var total : Double {
            tipAmount + billAmount }

    var body: some View {
        VStack {
            Text("Tip Calculator")
                .fontWeight(.heavy)
            TextField("Bill Amount", text: $billInput)
                .textFieldStyle(RoundedBorderTextFieldStyle()
            )
            Picker("Tip", selection: $tipSelected) {
                ForEach (tipPercentages.indices, id: \.self) {
                    let dbl = Double(self.tipPercentages[$0])
                    Text("\(Int(dbl * 100.0))%")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            HStack {
                let tipStr = numFormatter.string(for: tipAmount)
                Text("Tip: \(tipStr ?? "$0.00")")
                Spacer()
                let totalStr = numFormatter.string(for: total)
                Text("Total: \(totalStr ?? "$0.00")")
            }
            Spacer()

        }.padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
