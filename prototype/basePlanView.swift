import SwiftUI

struct basePlanView: View {
    // Names of the days for navigation links
    private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(daysOfWeek, id: \.self) { day in
                    NavigationLink(day, destination: dayPlanView(day: day))
                }
            }
            .navigationTitle("Meal Planning")
        }
    }
}


// MARK: - Previews
struct basePlanView_Previews: PreviewProvider {
    static var previews: some View {
        basePlanView().environmentObject(DraftPlan())
    }
}
