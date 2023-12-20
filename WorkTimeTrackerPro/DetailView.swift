//
//  DetailView.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-12-11.
//

import SwiftUI

struct DetailView: View {
    var difference: TimeDifferenceViewModel.TimeDifference
        @ObservedObject var vm: TimeDifferenceViewModel
    
    var body: some View {
        VStack {
            VStack{
                Text("Date: \(difference.dateFromFirebase)")
                    .fontWeight(.semibold)
                Text("Time Work: \(difference.timeDifference) (\(difference.startTime) - \(difference.endTime))")
                    .fontWeight(.semibold)
            }.padding(.top, 45.0)
            
            VStack{
                if difference.note.isEmpty {
                    Text("No notes added")
                        .padding()
                        .frame(width: 340, alignment: .center)
                        .background(Color.lightgreen.opacity(0.7))
                        .cornerRadius(10)
                } else {
                    Text("\(difference.note)")
                        .padding()
                        .frame(width: 340, alignment: .leading)
                        .background(Color.lightgreen.opacity(0.7))
                        .cornerRadius(10)
                        .contextMenu {
                                      Button {
                                          UIPasteboard.general.string = difference.note
                                      } label: {
                                          Text("Copy")
                                          Image(systemName: "doc.on.doc")
                                      }
                                  }
                }
            }.padding(.top, 20.0)
            
        Spacer()
        }
        Button(action: deleteDifference) {
                        Text("Delete")
                .foregroundStyle(Color.white)
                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.red)
                .cornerRadius(15)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10)
                    }
                }
    func deleteDifference() {
        vm.deleteDifference(withID: difference.id)
        }
    
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TimeDifferenceViewModel()
        let difference = TimeDifferenceViewModel.TimeDifference(id: "1", dateFromFirebase: "2023-12-03", timeDifference: "2:00", note: "note here", startTime: "07:00", endTime: "09:00")
        
        return NavigationView {
            DetailView(difference: difference, vm: viewModel)
        }
    }
}
