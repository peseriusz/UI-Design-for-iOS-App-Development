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
    let states = ["Alabama", "Alaska",
        "American Samoa", "Arizona", "Arkansas",
          "California", "Colorado", "Connecticut",
        "Delaware",    "District of Columbia"]
    
    @State var email = ""
    @State var selectedState = 0
    @State var userIncome = 0.0
    @State var dateOfBirth = Date.distantPast
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                    { (beingEdited) in
                        print (beingEdited)
                    } onCommit: {
                        if email.isValidEmail == false {
                            $email.wrappedValue = ""
                        }
                    }
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                }
                Section  {
                    HStack {
                        TextField("Income", value: $userIncome,
                        formatter: NumberFormatter.currencyFormatter)
                            .disabled(self.email.count == 0)
                    }
                }
                Section {
                    TextField("DOB", value: $dateOfBirth,
                        formatter: DateFormatter.shortDateFormatter)
                }
                Section {
                    ScrollView(.horizontal) {
                        HStack(spacing: 40) {
                            ForEach(states.indices) { index in
                                Text(self.states[index])
                                    .onTapGesture {
                                        self.selectedState = index
                                }.foregroundColor(self.selectedState
                                    == index ? .black : .gray)
                            }
                        }
                    }
                    Picker(selection: $selectedState,
                        label: Text("State")) {
                        ForEach(self.states.indices, id: \.self) {
                            Text(self.states[$0])
                        }
                    }
                }
            }.navigationTitle("Account Details")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
