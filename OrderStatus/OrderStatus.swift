//
//  OrderStatus.swift
//  OrderStatus
//
//  Created by nyannyan0328 on 2022/07/31.
//

import WidgetKit
import SwiftUI
import Intents

@main

struct OrderStaus : Widget{
    
    var body: some WidgetConfiguration{
        
        ActivityConfiguration(attributesType: OrederAtributes.self) { context in
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(Color("Green").gradient)
                
                VStack{
                    
                    HStack{
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                         .frame(width: 30,height: 30)
                         
                        Text("In Store Pick Up")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack(spacing:-2){
                            
                            ForEach(["Burger","Shake"],id:\.self){image in
                                
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                 .frame(width: 30,height: 30)
                                 .background{
                                  
                                     Circle()
                                         .fill(Color("Green"))
                                         .padding(-2)
                                         
                                 }
                                 .background{
                                  
                                     Circle()
                                         .stroke(.white,lineWidth: 3)
                                         .padding(-2)
                                 }
                                
                                
                            }
                        }
                        
                        
                    }
                    
                    HStack(alignment: .bottom,spacing: 0) {
                        
                        VStack(alignment: .leading,spacing: 5) {
                            
                            
                            Text(messge(status:context.state.status))
                                .font(.title3)
                                .foregroundColor(.white)
                            
                            
                            Text(subMSG(status:context.state.status))
                                .font(.caption2)
                                .foregroundColor(.gray)
                            
                            
                            
                            
                            
                            
                        }
                          .frame(maxWidth: .infinity,alignment: .leading)
                          .offset(y:13)
                        
                        HStack(alignment: .bottom,spacing: 0) {
                            
                            ForEach(Status.allCases,id:\.self){type in
                                
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                    .foregroundColor(context.state.status == type ? Color("Green") : .white.opacity(0.7))
                                    .frame(width: context.state.status == type ? 45 : 32,height: context.state.status == type ? 45 : 32)
                                     .background{
                                    
                                         
                                         Circle()
                                             .fill(context.state.status == type ? .white : .gray.opacity(0.5))
                                    }
                                     .background(alignment:.bottom){
                                      
                                         bottomArrow(status:context.state.status, type: type)
                                     }
                                     .frame(maxWidth: .infinity,alignment: .center)
                                
                            }
                            
                        }
                        .overlay(alignment:.bottom) {
                            
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(height:2)
                                .offset(y:12)
                                .padding(.horizontal,27.5)
                            
                        }
                        .frame(maxWidth: .infinity,alignment: .center)
                        .padding(.leading,15)
                        .padding(.trailing,-10)
                    
                          
                        
                    }
                    .frame(maxHeight: .infinity,alignment: .bottom)
                    .padding(.bottom,10)
                    
                  
                }
                .padding(15)
            }
            
        }
    }
    @ViewBuilder
    func bottomArrow(status : Status,type : Status)->some View{
        
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x:1.5)
            .offset(y:6)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.white)
            .overlay(alignment:.bottom) {
                
                Circle()
                    .fill(.white)
                     .frame(width: 5,height: 5)
                     .offset(y:13)
            }
        
    }
    func messge(status : Status) -> String{
        
        switch status {
        case .received:
            
            return "Order Recived"
            
        case .progress:
            
            return "Order Progress"
        case .ready:
            
            return "Oreder Ready"
        }
        
    }
    
    func subMSG(status : Status)->String{
        
        switch status {
        case .received:
            
            return "We just received your oreder"
            
        case .progress:
            
            return "We are handCrafting your order"
            
        case .ready:
            
            return "We crafted your order"
        
        }
        
        
        
    }
    
}

