//
//  ContentView.swift
//  Drawing
//
//  Created by 加藤巧真 on 2023/05/26.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    
    // MARK: - Function
    
    // MARK: - Body
    var body: some View {
        VStack {
            Button(action: { lines = []}, label: {
                Image(systemName: "clear")
                    .font(.system(size: 30))
            })
        
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(.red))
                }
                var path = Path()
                path.addLines(currentLine.points)
                context.stroke(path, with: .color(.black))
            } // CANVAS
            .frame(minWidth: 400, minHeight: 400)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        let newPoint = value.location
                        currentLine.points.append(newPoint)
                    }
                    .onEnded { value in
                        lines.append(currentLine)
                        currentLine = Line(points: [])
                    }
            )
        } // VSTACK
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Line {
    var points : [CGPoint] = []
}
