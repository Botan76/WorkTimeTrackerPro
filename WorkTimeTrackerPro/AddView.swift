//
//  AddView.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-11-30.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var vm: TimeDifferenceViewModel
    @Environment (\.dismiss) var dismiss
    @State private var note: String = ""

    
    var totalDifference: String {
            var totalHours = 0
            var totalMinutes = 0
            
        for difference in vm.timeDifferences {
            let components = difference.timeDifference.components(separatedBy: ":")
                if components.count == 2,
                   let hours = Int(components[0]),
                   let minutes = Int(components[1]) {
                    totalHours += hours
                    totalMinutes += minutes
                }
            }
            
            totalHours += totalMinutes / 60
            totalMinutes %= 60
            
            return "\(totalHours):\(String(format: "%02d", totalMinutes))"
        }
        
        var formattedTotalDifference: String {
            let components = totalDifference.components(separatedBy: ":")
            if components.count == 2,
               let hours = Int(components[0]),
               let minutes = Int(components[1]) {
                return "\(hours):\(String(format: "%02d", minutes))"
            }
            return "0:00"
        }
    
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2022)) ?? Date()
    let endingDate : Date = Date()
  
    
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName:"calendar")
                
                DatePicker("Selected date", selection: $vm.selectedDate,in: startingDate...endingDate, displayedComponents: [.date])
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    
                
            }
            
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName:"arrowshape.up")
                    DatePicker("Start Time", selection: $vm.startTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                    Spacer()
                    Image(systemName:"arrowshape.down")
                    DatePicker("End Time", selection: $vm.endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    Spacer()
                }.padding(.top)
                
            }
            
            
            Text("Hour you Work: \(vm.calculateTimeDifference())")
                .padding(.top)
            
            TextView(text: $note, placeholder: "Add your notes here...")
                .frame(maxHeight: 100)
                .overlay(
                         RoundedRectangle(cornerRadius: 10)
                             .stroke(Color.gray, lineWidth: 1)
                     )
                .padding()
            
            Button(action: {
                vm.addTimeDifference(note: note)
                dismiss()
                vm.showCheckmark = true

                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()  //Vibrating
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    vm.showCheckmark = false
                                }
            }, label: {
                Text("Add Time")
                    .foregroundColor(.white)
                    .frame(width: 320, height: 47.0)
                    .background(Color.darkgreen)
                    .cornerRadius(10)
            })

            
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TimeDifferenceViewModel()
        AddView(vm: viewModel)
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.text = placeholder
        textView.textColor = UIColor.placeholderText
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if text.isEmpty {
            uiView.text = placeholder
            uiView.textColor = UIColor.placeholderText
        } else {
            uiView.text = text
            uiView.textColor = UIColor.label
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, placeholder: placeholder)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        var placeholder: String
        
        init(text: Binding<String>, placeholder: String) {
            _text = text
            self.placeholder = placeholder
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == placeholder {
                textView.text = ""
                textView.textColor = UIColor.label
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = placeholder
                textView.textColor = UIColor.placeholderText
            }
        }
    }
}
