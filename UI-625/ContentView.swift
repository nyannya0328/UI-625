//
//  ContentView.swift
//  UI-625
//
//  Created by nyannyan0328 on 2022/07/31.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var currentID : String = ""
    @State var currentSelection : Status = .received
    
    var body: some View {
       
        NavigationStack{
            
            VStack {
                
                Picker(selection: $currentSelection) {
                    
                    Text("Recived")
                        .tag(Status.received)
                    
                    Text("Progress")
                        .tag(Status.progress)
                    
                    Text("Ready")
                        .tag(Status.ready)
                    
                    
                    
                } label: {
                    
               
                }
                .labelsHidden()
                .pickerStyle(.segmented)
                
                
              

                Button("Start Activeity"){
                    
                    addLiveActvity()
                    
                }
                
                Button("Stop"){
                    
                    removeActivity()
                    
                    
                }
                .padding(.top,10)
            }
            .navigationTitle("Live Activities")
            .padding(15)
            .onChange(of: currentSelection) { newValue in
                
                if let activity = Activity.activities.first(where: { (activity : Activity<OrederAtributes>) in
                    
                    activity.id == currentID
                }){
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        var updateState = activity.contentState
                        
                        updateState.status = currentSelection
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            
                            Task{
                                
                                await activity.update(using:updateState)
                            }
                            
                        }
                        
                        
                        
                    }
                }
            }
        }
    }
    func removeActivity(){
        
        if let activity = Activity.activities.first(where: { (activity : Activity<OrederAtributes>) in
            activity.id == currentID
        }){
            
            Task{
                
                await activity.end(using:activity.contentState, dismissalPolicy:.immediate)
            }
            
        }
        
        
    }
    func addLiveActvity(){
        
        
        let orderAtributes = OrederAtributes(orderNumber: 23383, orderName: "Buge $ Milk")
        
        let initialContentState = OrederAtributes.ContentState()
        
        do{
            
            let activity = try Activity<OrederAtributes>.request(attributes: orderAtributes, contentState: initialContentState, pushType: nil)
            
            
            currentID = activity.id
            print("a jjjjjjjj\(activity.id)")
        }
        catch{
            
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
