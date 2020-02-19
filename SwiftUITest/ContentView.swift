//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Dev on 19.02.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eighth, nine
    case equal, plus, minus, devide, multiply, dot
    case ac, percent, plusMinus

    var title: String {
        switch self {
        case .ac: return "AC"
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eighth: return "8"
        case .nine: return "9"
        case .dot: return "."
        case .equal: return "="
        case .devide: return "/"
        case .minus: return "-"
        case .plus: return "+"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .multiply: return "*"
        }
    }

    var bacgroundColor: Color {
        switch self {
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        case .devide,.multiply, .minus, .plus, .equal:
            return Color(.orange)
        default:
            return Color(.darkGray)
        }
    }

    var buttonWidth: CGFloat {
        switch self {
        case .zero:
            return (UIScreen.main.bounds.width - 5 * 12) / 2
        default:
            return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
    }

    var buttonHeight: CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}


class GlobalEnvironment: ObservableObject {
    @Published var display: String = "0"

    func setDisplay(button: CalculatorButton) {
        display = button.title
    }
}

struct ContentView: View {
    let buttons:[[CalculatorButton]] = [
        [.ac,.plusMinus, .percent, .devide],
        [.seven,.eighth, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one,.two, .three, .plus],
        [.zero,.dot, .equal],
    ]
    let result: String = "42"

    @EnvironmentObject var env: GlobalEnvironment

    var body: some View {
        ZStack(alignment: .bottom) {
        Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                Text(env.display).foregroundColor(.white).font(.system(size: 48))
                }.padding()
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row,  id: \.self) { button in
                        CalculatorButtonViews(button: button)
                        }
                    }
            }
            }.padding(.bottom)
        }
    }
    func getButtonWidth() -> CGFloat {
        (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct CalculatorButtonViews: View {

    var button: CalculatorButton
    @EnvironmentObject var env: GlobalEnvironment

    var body: some View {
        Button(action: {
            self.env.setDisplay(button: self.button)
        }) {
            Text(self.button.title)
                .font(.system(size: 32))
                .frame(width: self.button.buttonWidth, height: self.button.buttonHeight, alignment: .center)
                .foregroundColor(.white)
                .background(self.button.bacgroundColor)
            .cornerRadius(self.button.buttonWidth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
