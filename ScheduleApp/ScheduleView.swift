import SwiftUI

struct ScheduleView: View {
    let dateForm = DateFormatter()
    private var groups = ["101.1","101.2","102.1","102.2","201.1","201.2","202","301.1","301.2","301.3","302","401.1","401.2","402.1","402.2"]
    private var styles = ["List", "Table"]
    @State private var pickedGroup: String = UserDefaults.standard.string(forKey: "favGroup") ?? "101.1"
    @State private var pickedDate: Date = Date()
    @State var fullSchedule: ScheduleFull?
    @State var pickedSchedule: [Schedule] = []
    @State var showAlert: Bool = false
    @State var fullDates: Bool = false
    @State var isScrollable: Bool = false
    @State var animate: Bool = false
    @State var isLoad: Bool = false
    @State var group: String = ""
    @State var weekDays: [WeekDays] = []
    @State var pickedDay: String = ""
    @State var scheduleStyle: String = "List"
    @State var scaleButton: Bool = false
    
    var body: some View {
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
                
                Picker(selection: $scheduleStyle) {
                    ForEach(styles, id: \.self){ style in
                        Text(style)
                    }
                } label: {
                    Text("")
                }
                .animation(.snappy, value: scheduleStyle)
                .pickerStyle(.segmented)
                
                Button {
                    scaleButton = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        scaleButton = false
                    }
                    weekDays = []
                    pickedDay = ""
                    group = ""
                    pickedSchedule = []
                    isLoad = true
                    let data = readLocalJSONFile(forName: "schedule")
                    let _schedule = parse(jsonData: data!)
                    guard let _schedule = _schedule else { showAlert = true; return }
                    fullSchedule = _schedule
                    if fullDates{
                        isScrollable = false
                        for i in fullSchedule!.schedule{
                            if i.group == pickedGroup{
                                for j in i.weekDays{
                                    weekDays.append(j)
                                }
                                self.group = pickedGroup
                                pickedDay = "full week"
                                animate.toggle()
                            }
                        }
                    } else{
                        isScrollable = true
                        for i in fullSchedule!.schedule{
                            for j in i.weekDays{
                                let weekDay = Calendar.current.component(.weekday, from: pickedDate) - 1
                                if j.dayOfWeek == dateForm.weekdaySymbols[weekDay].lowercased() && i.group == pickedGroup{
                                    pickedDay = j.dayOfWeek
                                    self.weekDays = [j]
                                    self.group = pickedGroup
                                    animate.toggle()
                                }
                            }
                        }
                    }
                    
                } label: {
                    Text("Показать расписание 📅")
                }
                .frame(maxWidth:.infinity)
                .alert("Something wrong", isPresented: $showAlert, actions: {
                    Button {
                        
                    } label: {
                        Text("ok")
                    }
                    
                })
                .scaleEffect(scaleButton ? 0.85 : 1)
                .animation(.bouncy(duration: 0.27), value: scaleButton)
                .shadow(radius: 3)
                .buttonStyle(.borderedProminent)

            }
            .frame(height: UIScreen.main.bounds.height / 3)
            .background(.purple, in: .rect(cornerRadius: 10))
            .shadow(radius: 5)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
//            ProgressView()
//                .progressViewStyle(.circular)
            if weekDays.isEmpty{
                PickGroupView()
            } else {
                if scheduleStyle == "List"{
                    ScheduleListView(group: $group, weekDays: $weekDays, pickedDay: $pickedDay)
                        .frame(width: UIScreen.main.bounds.width)
                        .scrollDisabled(isScrollable)
                        .clipped()
                        .animation(.bouncy, value: animate)
                        .scrollContentBackground(.hidden)
                        .shadow(radius: 5)
                } else if scheduleStyle == "Table"{
                    ScheduleTableView(weekDays: $weekDays, pickedDay: $pickedDay, group: $group)
                        .frame(width: UIScreen.main.bounds.width)
                        .scrollDisabled(isScrollable)
                        .clipped()
                        .animation(.bouncy, value: animate)
                        .scrollContentBackground(.hidden)
                        .shadow(radius: 5)
                }
            }
        }
        .backgroundStyle(.black)
        .transition(.slide)
    }
}

#Preview {
    ScheduleView()
}
