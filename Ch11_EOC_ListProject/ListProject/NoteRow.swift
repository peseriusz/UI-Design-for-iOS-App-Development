//
//  NoteRow.swift
//  ListProject
//
//  Created by Bear Q Cahill on 8/31/20.
//

import SwiftUI

enum Priority : Int, Codable, CaseIterable {
    case low, medium, high
    
    static var max : Int {
        Priority.init(rawValue:
            Priority.allCases.count - 1)!.rawValue
    }
}

//MARK: ------- Model
class Note : Identifiable, Codable {
    var id = UUID().uuidString
    var text = "New Note" {
        didSet {
            self.updatedAtTime = Date()
        }
    }
    var updatedAtTime = Date()
    var priority = Priority.low {
        didSet {
            self.updatedAtTime = Date()
        }
    }
    var image = ""
    var dueDate = Date.distantFuture
    var isPastDue : Bool {
        dueDate < Date()
    }
}

//MARK: ------- View Model
class NoteViewModel : Identifiable {
    var id = UUID().uuidString
    var text = ""
    var priorityImages : [String]
    var time = ""
    var imageName = ""
    var renderingColor = Color(UIColor.label)
    
    static var dateFormatter : DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .medium
        return df
    }
    
    init(model : Note) {
        text = model.text
        time = NoteViewModel.dateFormatter.string(from:
                        model.updatedAtTime)
        renderingColor = model.isPastDue ? Color.red : renderingColor
        imageName = model.image
        priorityImages = Array(repeating: "star.circle",
                        count: model.priority.rawValue + 1)
        priorityImages += Array(repeating: "circle",
                        count: Priority.max -  model.priority.rawValue)
    }

    #if DEBUG
    static func loadTestData() -> [NoteViewModel] {
        guard let url = Bundle.main.url(forResource: "Data",
                                        withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let notes = try? JSONDecoder().decode([Note].self,
                                                    from: data)
                else { return [] }
        return notes.map { NoteViewModel(model: $0) }
    }
    #endif
}

//MARK: ------- View
struct NoteRow: View {
    var noteVM : NoteViewModel
    
    var body: some View {
        HStack {
            Image(noteVM.imageName)
                .resizable()
                .frame(width: 100.0,height:100)
            VStack(alignment: .leading) {
                Text(noteVM.text)
                NotePriorityAndTime(noteVM: noteVM)
            }
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(NoteViewModel.loadTestData(), id: \.id)
        { (noteVM) in
            NoteRow(noteVM: noteVM)
                .previewLayout(.sizeThatFits)
        }
    }
}



struct NotePriorityAndTime: View {
    var noteVM : NoteViewModel

    var body: some View {
        HStack {
            ForEach(noteVM.priorityImages, id: \.self)
            { (imageName) in
                Image(systemName: imageName)
                    .foregroundColor(self.noteVM.renderingColor)
            }
            Spacer()
            Text(noteVM.time)
                .fontWeight(.thin)
                .foregroundColor(self.noteVM.renderingColor)
        }
    }
}
