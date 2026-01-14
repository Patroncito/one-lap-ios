//
//  OBWelcome.swift
//  One Lap
//
//  Created by Alfonso Patron on 14/01/26.
//

import SwiftUI

struct OBWelcome: View {
    @State private var page: Int  = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = true
    private var slides : [OnboardingSlide] = [
        .init(
            title: "One Lap",
            subtitle: "Tu Pomodoro con vibra racing: enfoque como si fuera una vuelta rápida.",
            systemImage: "flag.checkered"
        ),
        .init(
            title: "Focus Lap",
            subtitle: "Entra en ritmo. Corre una vuelta de enfoque y evita distracciones.",
            systemImage: "stopwatch"
        ),
        .init(
            title: "Pit Stops",
            subtitle: "Descansa como en pits: breaks cortos y uno largo cada X laps.",
            systemImage: "wrench.and.screwdriver"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Button("Saltar"){
                    hasSeenOnboarding = true
                }
                .font(.headline)
                .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            TabView(selection: $page) {
                ForEach(Array(slides.enumerated()), id: \.offset) { index, slide in
                    OnboardingSlideView(slide: slide)
                        .tag(index)
                        .padding(.horizontal, 24)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .animation(.easeInOut, value: page)
            
            Spacer(minLength: 0)

            
            Button {
                if page < slides.count - 1 {
                    page += 1
                } else {
                    hasSeenOnboarding = true
                }
            } label: {
                Text(page < slides.count - 1 ? "Continuar" : "Empezar")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }
}

struct OnboardingSlideView : View {
    let slide : OnboardingSlide
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: slide.systemImage)
                .font(.system(size: 56, weight: .semibold))
                .padding(.bottom, 6)
            Text(slide.title)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            Text(slide.subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
#Preview {
    OBWelcome()
}
