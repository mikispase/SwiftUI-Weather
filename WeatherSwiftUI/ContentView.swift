//
//  ContentView.swift
//  WeatherSwiftUI
//
//  Created by Dimitar Spasovski on 9/16/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @StateObject private var forecastListVM = ForecastListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $forecastListVM.system, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    Text("˚C").tag(0)
                    Text("˚F").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width:100)
                .padding(.vertical)
                HStack {
                    TextField("Enter Location", text: $forecastListVM.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        forecastListVM.getWeatherForecast()
                    }, label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                    })
                } // end HStack
                List(forecastListVM.forecasts, id: \.day) { day in
                    VStack(alignment: .leading){
                        
                        Text(day.day)
                            .fontWeight(.bold)
                        
                        HStack(alignment: .center){
                            
                            WebImage(url: day.weatherIconURL)
                                .placeholder {
                                    Image(systemName:"hourglass")
                                }
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            VStack(alignment: .leading) {
                                Text(day.overView)
                                HStack {
                                    Text(day.high)
                                    Text(day.low)
                                }
                                HStack {
                                    Text(day.clouds)
                                    Text(day.pop)
                                }
                                
                                Text(day.humidity)
                            }
                        }
                    }.listStyle(PlainListStyle())
                }
               
                
                
            } // end VStack
            .padding(.horizontal, 2.0)
            .navigationTitle("Weathet App")
            
    
            
            
        }// End Navigationview
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
