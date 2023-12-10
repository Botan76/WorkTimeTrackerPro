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
            
            Button(action: {
                vm.addTimeDifference()
                dismiss()
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
