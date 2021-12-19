import SwiftUI
import BudouX

struct ContentView: View {

    let sample: String = "あなたに寄り添う最先端のテクノロジー。"

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Without BudouX")
                    .font(.headline)
                Text(sample)
                    .foregroundColor(.primary)
                    .border(.gray.opacity(0.5), width: 1)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text("With BudouX")
                    .font(.headline)
                Text(sample.budouxed)
                    .foregroundColor(.primary)
                    .border(.gray.opacity(0.5), width: 1)
            }
        }
        .frame(width: 160, alignment: .center)
    }
}

extension String {
    var budouxed: String {
        let parser = Parser()
        return parser.translate(sentence: self)
    }
}
