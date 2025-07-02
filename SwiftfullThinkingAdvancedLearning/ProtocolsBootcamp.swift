//
//  ProtocolsBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 30/06/2025.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secendary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secendary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secendary: Color = .red
    var tertiary: Color = .purple
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secendary: Color { get }
    var tertiary: Color { get }
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol buttonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, buttonPressedProtocol {
    
}


class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Protocols are awsome!"
    
    func buttonPressed() {
        print("Default button was pressed")
    }
    
}



class AlternativeDataSource: ButtonTextProtocol {
    var buttonText: String = "Protocols are Lame!"
}

struct ProtocolsBootcamp: View {
    
//    let colorTheme: DefaultColorThreme = DefaultColorThreme()
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol
   
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secendary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: AnotherColorTheme(), dataSource: DefaultDataSource())
}
