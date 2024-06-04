//
//  EventView.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/20/24.
//

import SwiftUI


struct Event: Identifiable {
    var id: String { title }
    var title: String
    var organization: String
    var date: Date
    var description: String
    var imageName: String // For simplicity, assuming image names match those in Assets catalog
}

let sampleEvents: [Event] = [
    Event(title: "Bingo Fundraiser", organization: "Wolverine Support Network", date: Date(), description: "Come support Wolverine Support Network by joining us for an unmissable game of bingo! Amazing prizes to those who win. $5 to enter.", imageName: "bingo"),
    Event(title: "Detroit Pistons Game", organization: "French Speakers Association", date: Date(), description: "Kick back and watch the San Antonio Spurs play the Pistons at Little Caesar's Arena with your French-speaking peers.", imageName: "pistons"),
    // Add more events as needed
]

struct CardView: View {
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(event.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            
            Text(event.title)
                .font(.headline)
                .padding(.top, 5)
            
            Text(event.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(event.description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.top, 2)
            
            Spacer()

            Button(action: {
                // Action when "Apply Now" is tapped
            }) {
                Text("I want to go!")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct EventDetailView: View {
    var event: Event

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(event.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 10) {
                    Text(event.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Text(event.organization)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    
                    Text(event.date, style: .date)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    Text(event.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)

                    // Here you can add more event details or sections.
                }
                .padding()
            }
        }
        .navigationBarTitle(event.title, displayMode: .inline) // Sets the navigation bar title
        .toolbar { // Adds an 'I want to go!' button in the navigation bar
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Action when 'I want to go!' is tapped
                    // This could toggle the user's attendance, send an RSVP, etc.
                }) {
                    Text("I want to go!")
                }
            }
        }
    }
}

// Update the destination in the original NavigationLink to point to EventDetailView
struct EventView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(sampleEvents) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            CardView(event: event)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                    }
                }
            }
            .navigationTitle("Events")
        }
    }
}


#Preview {
    EventView()
}
