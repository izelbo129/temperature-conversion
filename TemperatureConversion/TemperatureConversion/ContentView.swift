//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Ian Zelbo on 7/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0
    @State private var inputSelection = 0
    @State private var outputSelection = 0
    private var inputList = [UnitLength.millimeters, UnitLength.centimeters, UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.meters, UnitLength.kilometers, UnitLength.miles]
    
    var conversionCalc: Measurement<UnitLength> {
        let inputAmount = Measurement(value: Double(checkAmount) , unit: inputList[inputSelection])
        let outputAmount = inputAmount.converted(to: inputList[outputSelection])
        return outputAmount
    }
    
    
    var formatter: MeasurementFormatter {
        let newFormat = MeasurementFormatter()
        newFormat.unitStyle = .long
        newFormat.unitOptions = .providedUnit
        return newFormat
    }
    
    
    
    @FocusState private var amountIsFocused: Bool
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("amount", value: $checkAmount, format:.number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Input unit", selection: $inputSelection) {
                        ForEach(0..<8) {
                            let formattedOutput = formatter.string(from:inputList[$0])
                            Text(formattedOutput)
                            
                        }
                        
                    }
                    
                    Picker("Output unit", selection: $outputSelection) {
                        ForEach(0..<8) {
                            let formattedOutput = formatter.string(from:inputList[$0])
                            Text(formattedOutput)
                            
                        }
                        
                    }
                }
                
                Section(header: Text("Conversion")) {
                    Text(formatter.string(from: conversionCalc))
                }
            }

            .navigationTitle("Converter")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
