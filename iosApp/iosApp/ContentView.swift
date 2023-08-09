import SwiftUI
import shared
import KMPNativeCoroutinesCombine

class ViewModel: ObservableObject {
    private let flowCreator = FlowCreator()
    
    @Published
    var stringBinding: String = ""
    
    @Published
    private(set) var currentInt: Int = 0
    
    @MainActor // So that the uiState (which drives the views in the ui) is updated on the main thread.
    func loadInts() async {
        Task { [self] in
             do {
                 let seq = $stringBinding
                    .removeDuplicates { prev, next in
                        prev == next
                    }
                    .map { createPublisher(for: self.flowCreator.getFlow(input: $0)) }
                    .switchToLatest()
                    .values
 
                for try await newValue in seq {
                    print("Got new value: \(newValue)")
                    currentInt = Int(truncating: newValue)
                }
            } catch {
                print("Error!!!!")
            }
        }
    }
}


struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

	var body: some View {
        VStack {
            Picker("String", selection: $viewModel.stringBinding) {
                Text("Item A").tag("A")
                Text("Item B").tag("B")
                Text("Item C").tag("C")
                Text("Item D").tag("D")
                Text("Item E").tag("E")
                Text("Item F").tag("F")
            }.padding()

            Text("Current Int: \(viewModel.currentInt)")
                .padding()
        }.task {
            await viewModel.loadInts()
        }
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
