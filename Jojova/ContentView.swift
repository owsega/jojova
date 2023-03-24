//
//  ContentView.swift
//  Jojova
//
//  Created by Gabriel Owoeye on 09/03/2023.
//

import Foundation
import SwiftUI
import shared

struct ContentView: View {
    
    init() {
        UserDefaults.standard.set(false, forKey: "comscoreEnabled")
        UserDefaults.standard.set("Jojoba Seyi", forKey: "mediaTitle")
        UserDefaults.standard.set(2100, forKey: "mediaLength")
    }
    
    let dataStores: [String: DataStore] = [
        "data": HashMapDataStore(map: [
            "eVar23": "Jojoba Seyi",
        ]),
        "context": HashMapDataStore(map: [
            "mediaLength": 2300
        ]),
        "config": HashMapDataStore(map: [
            "isTrue": false
        ])
    ]
    
    var configParser = ConfigParser()
    
    func testWith(key: String, type: ConfigParser.Type_) -> Text {
        var val = configParser.parseKey(key: key, typeHint: type, dataStores: dataStores)
        
        if (val == nil) {
            val = "nil"
        }
        
        return Text("\(key) :: \((val as AnyObject).description ?? "null")")
    }
    
    var body: some View {
        VStack {
            Group {
                Text("Avia Tracking KMM Experiments")
                Divider()
            }
            
            Group {
                testWith(key: "abc", type: ConfigParser.Type_.string)
                testWith(key: "{data.eVar23}", type: ConfigParser.Type_.string)
                .padding([.bottom])
            }
            
            Group {
                testWith(key: "{context.mediaLength}", type: ConfigParser.Type_.string)
                testWith(key: "{context.mediaLength}", type: ConfigParser.Type_.long_)
                testWith(key: "{context.mediaLength}", type: ConfigParser.Type_.boolean)
                .padding([.bottom])
            }
            
            Group {
                testWith(key: "{config.isTrue}", type: ConfigParser.Type_.boolean)
                testWith(key: "{config.isTrue}", type: ConfigParser.Type_.string)
                .padding([.bottom])
            }
            
            Group {
                testWith(key: "{localStorage.comscoreEnabled} ? no_title : {localStorage.mediaTitle}", type: ConfigParser.Type_.string)
                testWith(key: "{localStorage.mediaLength} | -1 ", type: ConfigParser.Type_.long_)
                .padding([.bottom])
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
