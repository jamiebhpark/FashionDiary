import SwiftUI
import PhotosUI

struct DiaryEntryView: View {
    @State private var date = Date()
    @State private var outfitPhoto: UIImage?
    @State private var outfitDescription = ""
    @State private var concept = ""
    @State private var purpose = ""
    @ObservedObject var viewModel = DiaryViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Date")) {
                    DatePicker("Select a date", selection: $date, displayedComponents: .date)
                }

                Section(header: Text("Photos")) {
                    PhotoPickerView(selectedImage: $outfitPhoto, title: "Select Outfit Photo")
                }

                Section(header: Text("Outfit Description")) {
                    TextEditor(text: $outfitDescription)
                }

                Section(header: Text("Concept")) {
                    TextField("Enter the concept", text: $concept)
                }

                Section(header: Text("Purpose")) {
                    TextField("Enter the purpose", text: $purpose)
                }

                Button(action: {
                    let entry = DiaryEntry(date: date, outfitPhotoURL: nil, outfitDescription: outfitDescription, concept: concept, purpose: purpose, isShared: false)
                    viewModel.addEntry(entry: entry)
                }) {
                    Text("Save Entry")
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Fashion Diary")
            .onAppear {
                viewModel.fetchEntries()
            }
        }
    }
}
