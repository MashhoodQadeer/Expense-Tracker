// TransactionsCharts.swift
// Expense Tracker
// Created by Mashhood Qadeer on 14/12/2024.

import SwiftUI
import Charts

struct ChartsView: View {
    
    @Binding var transactionsGraphData: [Double]
    @State var netAmount: Double = 0
    @State private var selectedValue: Double? = nil
    @State private var selectedXPosition: CGFloat? = nil
        
    var body: some View {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack {
                    Text(netAmount, format: .currency(code: "USD"))
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.icon)
                    Spacer().frame(height: 20)
                }
                
                Chart {
                    
                    ForEach(transactionsGraphData.indices, id: \.self) { index in
                        
                        let value = transactionsGraphData[index]
                        
                        LineMark(
                            x: .value("", index),
                            y: .value("Transaction", value)
                        )
                        .foregroundStyle(Color.icon)
                        
                        AreaMark(
                            x: .value("", index),
                            y: .value("Transaction", value)
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue.opacity(0.4), .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        
                    }
                    
                }
                .chartXAxis(.hidden)
                .frame(height: 250)
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        
                        ZStack(alignment: .topLeading) {
                            
                            Rectangle().fill(Color.clear) .contentShape(Rectangle())
                                       .frame(width: geometry.size.width, height: geometry.size.height)
                                       .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                
                                                let location = value.location
                                                if let closestX = findClosestX(for: location, in: proxy, geometry: geometry) {
                                                    self.selectedXPosition = closestX.xPosition
                                                    self.selectedValue = closestX.dataPoint
                                                }
                                            }
                                            .onEnded { _ in
                                                self.selectedXPosition = nil
                                                self.selectedValue = nil
                                            }
                                    )
                            
                            
                            if let selectedValue = selectedValue, let xPosition = selectedXPosition {
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(width: 2, height: geometry.size.height)
                                    .position(x: xPosition, y: geometry.size.height / 2)
                                
                                Text("\(selectedValue, specifier: "%.1f")")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .position(x: xPosition, y: 10)
                            }
                        }
                        .contentShape(Rectangle())
                        
                    }
                }
                .background(Color(.systemBackground))
                .frame(maxWidth: .infinity)
                .padding()
                
                .onAppear {
                    netAmount = self.transactionsGraphData.reduce(0, +)
                }
            }.beautify()
            
        }
        
        func findClosestX(for location: CGPoint, in proxy: ChartProxy, geometry: GeometryProxy) -> (xPosition: CGFloat, dataPoint: Double)? {
            
            let xValue = proxy.value(atX: location.x, as: Int.self)
            guard let xValue = xValue else { return nil }
            
            if let xPosition = proxy.position(forX: xValue),
               xValue >= 0 && xValue < self.transactionsGraphData.count{
               let matchingPoint = self.transactionsGraphData[ xValue ]
               return (xPosition, matchingPoint)
            }
            return nil
            
        }
    
}

struct ChartsViewPreviews: PreviewProvider {
    
    static var previews: some View {
        ChartsView(transactionsGraphData: .constant([10, 20, 30, 40]))
    }
    
}
