//
//  UIViewRepresentableBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 29/06/2025.
//

import SwiftUI

struct UIViewRepresentableBootcamp: View {
    
    @State private var text: String = ""
    
    var body: some View {
        Text(text)
        HStack {
            Text("Swift UI")
            TextField("Ty[e here...", text: $text)
        }
        HStack {
            Text("UIKit:")
            UITextFieldVIewRepresentable(text: $text).updatePlaceHolder("New PLaceholder !!")
                .frame(height: 55)
                .background(Color.gray)
        }
    
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}

struct UITextFieldVIewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let placeHolderColor: UIColor
    
    init(text: Binding<String>, placeHolder: String = "Default placeHolder...", placeHolderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeHolder
        self.placeHolderColor = placeHolderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeHolder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeHolderColor
            ]
        )
        textField.attributedPlaceholder = placeHolder
        return textField
    }
    
    func updatePlaceHolder(_ text: String) -> UITextFieldVIewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
    
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
