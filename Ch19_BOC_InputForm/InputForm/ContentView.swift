//
//  ContentView.swift
//  InputForm
//
//  Created by Bear Cahill on 9/15/20.
//

import SwiftUI

extension DateFormatter {
    static var shortDateFormatter : DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }
}

extension NumberFormatter {
    static var currencyFormatter : NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.isLenient = true
        return nf
    }
}

extension String {
    var isValidEmail:  Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+"
            + "\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:
            "SELF MATCHES %@", regEx)
        let result = pred.evaluate(with: self)
        return result
    }
}

struct ContentView: View {
    
    var body: some View {
        Text("Form BOC")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
