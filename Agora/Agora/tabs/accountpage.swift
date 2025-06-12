//
//  accountpage.swift
//  Agora
//
//  Created by Islom Shamsiev on 2025/4/11.
//

import SwiftUI

struct accountpage: View {
    @State var selected: Int = 1
    var body: some View {
        ZStack {
            SexyBackgroundView()
                .ignoresSafeArea(.all)

            ScrollView {
            VStack {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.indigo)
                    .padding(.horizontal)
                    .hAlign(.trailing)
                    .padding(.trailing, 65)
                    .font(.title)
                    .bold()
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.indigo)
                    .padding()
 
                
                HStack {
                    Text("Islombek Shamsiev")
                        .font(.title)
                        .font(.system(size: 100, weight: .semibold))
                        .foregroundColor(.indigo)
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.green)
                        .vAlign(.center)
                }
                Spacer()
                HStack(spacing: -20) {
                    RoundedRectangle(cornerRadius:10).foregroundColor(.white.opacity(0.8))
                        .shadow(radius: 5)
                        .frame(width: 150, height:50)
                        .overlay(
                            HStack {
                                Image(systemName: "graduationcap")
                                    .foregroundStyle(.indigo)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 5)
                                Text("Freshman")
                                    .foregroundColor(.indigo)
                                    .fontWeight(.semibold)
                            }
                        )
                        .padding()
                        .padding(.leading, 50)
                    
                    RoundedRectangle(cornerRadius:10).foregroundColor(.white.opacity(0.8))
                        .shadow(radius: 5)
                        .frame(width: 200, height:50)
                        .overlay(
                            HStack {
                                Image(systemName: "house.lodge")
                                    .foregroundStyle(.indigo)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 0)
                                Text("Eastview Terrace")
                                    .foregroundColor(.indigo)
                                    .fontWeight(.semibold)
                            }
                            )
                        .padding()
                        .padding(.trailing, 50)
                }
                .hAlign(.center)
                .vAlign(.center)
                RoundedRectangle(cornerRadius:10).foregroundColor(.white.opacity(0.8))
                    .shadow(radius: 5)
                    .frame(width: 200, height:50)
                    .overlay(
                        HStack {
                            Image(systemName: "books.vertical")
                                .foregroundStyle(.indigo)
                            Text("Computer Science")
                                .foregroundStyle(.indigo)
                                .fontWeight(.semibold)
                        }
                            
                    )
                    .hAlign(.center)
                    // .padding(.leading, 63)
                

                    HStack {
                        Button {
                            selected = 1
                        } label: {
                            Text("Sold")
                                .foregroundColor(.indigo)
                                .font(.title3)
                                .fontWeight(selected == 1 ? .bold : .regular)
                                .underline(selected == 1)
                        }
                        Spacer().frame(width: 150)
                        Button {
                            selected = 2
                        } label: {
                            Text("Requested")
                                .foregroundColor(.indigo)
                                .font(.title3)
                                .fontWeight(selected == 2 ? .bold : .regular)
                                .underline(selected == 2)
                        }
                    }
                    .padding(.vertical, 50)
                }
            }
        }
    }
}

#Preview {
    accountpage()
}
