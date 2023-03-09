//
//  PreEndView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 08.03.2023.
//

import SwiftUI

struct PreEndView: View {
    var startTime = 5
    @State var timeLeft = 5
    @State var isPaused = false
    @State var showAd = false
    
    var dismissClosure: () -> ()
    var rewardClosure: () -> ()

    var timeStr: String {
        "\(timeLeft)"
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    var body: some View {
        ZStack {
        
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    ZStack {
                        Text(timeStr)
                            .font(.system(size: 46, weight: .medium))
                            .animation(.none)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(timeLeft) / CGFloat(startTime))
                            .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .frame(width: geometry.size.width * 0.6)
                            .shadow(radius: 10)
                            .rotationEffect(.degrees(-90))
                    }
                    .foregroundColor(.init(white: 0.8))
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                    .padding(.horizontal, geometry.size.width * 0.2)
                    .onReceive(timer) { _ in
                        reduceTime()
                    }
                    Spacer()
                    
                    Button {
                        isPaused = true
                        showAd = true
                    } label: {
                        HStack {
                            Text("Продолжить")
                                .font(.title2)
                                .padding(.leading)
                            Image("clapperboard")
                                .padding(.leading)
                        }
                        .padding()
                        .frame(minWidth: 200)
                        .background(Capsule().fill(Color.white))
                        .foregroundColor(.black)
                    }

                    
                    Spacer()
                }
            }
            .background(Color.black.opacity(0.8))
            .onTapGesture(perform: reduceTime)
            
            if showAd{
                YandexRewardedAd(dismissClosure: dismissClosure, rewardClosure: rewardClosure)
            }
        }
    }
    
    func reduceTime() {
        if timeLeft == 0 {
            dismissClosure()
            return
        }
        withAnimation {
            if !isPaused && timeLeft > 0 {
                timeLeft -= 1
            }
        }
    }
}

struct PreEndView_Previews: PreviewProvider {
    static var previews: some View {
        PreEndView(){
        } rewardClosure: {
        }
    }
}
