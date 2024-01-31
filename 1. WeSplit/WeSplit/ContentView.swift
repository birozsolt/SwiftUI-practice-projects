//
//  Created by Qing Li on 12/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountKeyboardIsFocused: Bool
    
    var totalCheckAmount: Double {
        checkAmount * (1 + Double(tipPercentage) / 100)
    }
    
    var totalPerPerson: Double {
        totalCheckAmount / Double(numberOfPeople)
    }

    private let localeCurrencyCode = Locale.current.currency?.identifier ?? "USD"

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: localeCurrencyCode)
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountKeyboardIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(0 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much percentage do you tip?")
                }
                
                Section {
                    Text(totalCheckAmount, format: .currency(code: localeCurrencyCode))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Total check amount")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: localeCurrencyCode))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountKeyboardIsFocused {
                    Button("Done") {
                        amountKeyboardIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
