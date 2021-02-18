//
//  ContentView.swift
//  WeSplit v2
//
//  Created by Edgars Jaudzems on 02/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var peopleCountFinal: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        return peopleCount
    }
    
    var totalPerPerson: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCountFinal

        return amountPerPerson
    }
    
    var total: Double {
        let totalAmount = totalPerPerson * peopleCountFinal
        return totalAmount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount")) {
                    Text("$\(total, specifier: "%.2f")")
                }
                .foregroundColor(tipPercentage == 4 ? .red : .black)
                //.foregroundColor((tipPercentages[tipPercentage] != 0) ? .black : .red)

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
