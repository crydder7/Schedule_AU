import SwiftUI
import EventKit



func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}


func parse(jsonData: Data) -> ScheduleFull? {
    do {
        let decodedData = try JSONDecoder().decode(ScheduleFull.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}



struct ContentView: View {
    @StateObject private var calendarManager = CalendarManager()
    let dateForm = DateFormatter()
    @State private var accessGranted = false
    @State private var error: Error?
    private var groups = ["101.1","101.2","102.1","102.2","201.1","201.2","202","301","302","401","402"]
    @State private var pickedGroup: String = "101.1"
    @State private var pickedDate: Date = Date()
    @State var fullSchedule: ScheduleFull?
    @State var pickedSchedule: [Schedule] = []
    @State var showAlert: Bool = false
    @State var fullDates: Bool = false
    @State var isScrollable: Bool = false
    @State var animate: Bool = false
    @State var isLoad: Bool = false
    
    
    var body: some View {
        TabView {
            Tab{
                VStack{
                    Form{
                        DatePicker("Дата 📆", selection: $pickedDate, displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .pickerStyle(.menu)
                            .disabled(fullDates)
                        
                        Picker(selection: $pickedGroup, label: Text("Группа 🎓")) {
                            ForEach(groups, id: \.self){ i in
                                Text(i)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Toggle("Показать расписание на всю неделю 🗓️", isOn: $fullDates)
                        
                        Button {
                            pickedSchedule = []
                            isLoad = true
                            let data = readLocalJSONFile(forName: "zxc")
                            let zxc = parse(jsonData: data!)
                            guard let zxc = zxc else { showAlert = true; return }
                            fullSchedule = zxc
                            if fullDates{
                                isScrollable = false
                                for i in fullSchedule!.schedule{
                                    if i.group == pickedGroup{
                                        pickedSchedule.append(i)
                                        animate.toggle()
                                    }
                                }
                            } else{
                                isScrollable = true
                                for i in fullSchedule!.schedule{
                                    let weekDay = Calendar.current.component(.weekday, from: pickedDate) - 1
                                    if i.weekDay == dateForm.weekdaySymbols[weekDay].lowercased() && i.group == pickedGroup{
                                        pickedSchedule = [i]
                                        animate.toggle()
                                    }
                                }
                            }
                            
                        } label: {
                            Text("Показать расписание 📅")
                        }
                        .alert("Something wrong", isPresented: $showAlert, actions: {
                            Button {
                                
                            } label: {
                                Text("ok")
                            }
                            
                        })
                        .buttonStyle(.borderedProminent)
                        
                        
                    }
                    .frame(height: UIScreen.main.bounds.height / 3.5)
                    .background(.purple, in: .rect(cornerRadius: 10))
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    
//                    ProgressView()
//                        .progressViewStyle(.circular)
                        
                    ScheduleListView(pickedSchedule: $pickedSchedule)
                        .scrollDisabled(isScrollable)
                        .clipped()
                        .animation(.bouncy, value: animate)
                        .background(.blue, in: .rect(cornerRadius: 10))
                        .scrollContentBackground(.hidden)
                }
            }
            .customizationID("1")
        }
        .tabViewStyle(.sidebarAdaptable)
        
    }
}



#Preview {
    ContentView()
}
