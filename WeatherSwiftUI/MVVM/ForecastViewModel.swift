//
//  ForecastViewModel.swift
//  WeatherSwiftUI
//
//  Created by Dimitar Spasovski on 9/16/21.
//

import Foundation

struct ForecastViewModel {
    let forecast: Forecast.Daily

    var system:Int = 0
    
    private static var dateFormater:DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "E, MMM, d"
        return dateFormater
    }
    
    private static var numberFormater:NumberFormatter {
        let numberFormater = NumberFormatter()
        numberFormater.maximumFractionDigits = 0
        return numberFormater
    }
    
    private static var numberFormater2:NumberFormatter {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .percent
        return numberFormater
    }
    
    var day:String {
        return Self.dateFormater.string(from: forecast.dt)
    }
    
    var overView:String {
        return forecast.weather[0].description.capitalized
    }
    
    var high:String {
        return  "H: \(Self.numberFormater.string(for: convert(forecast.temp.max)) ?? "0")"
    }
    
    var low:String {
        return  "H: \(Self.numberFormater.string(for: convert(forecast.temp.min)) ?? "0")"
    }
    
    var pop:String {
        return "💧 \(Self.numberFormater2.string(for: forecast.pop) ?? "0%")"
    }
    
    var clouds:String {
        return "☁️ \(forecast.clouds)%"
    }
    
    var humidity:String {
        return "Humidity: \(forecast.humidity)%"
    }
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }
    
    func convert(_ temp:Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        }else {
            return celsius * 9 / 5 + 32
        }
    }
}
