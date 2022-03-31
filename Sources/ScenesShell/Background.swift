import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */

func absVal(_ n:Double) -> Double {
    if n < 0 {
        return -n
    }
    return n
}

class Background : RenderableEntity {
    var width = 0
    var height = 0
    var rendered = false
    var pixelsRendered = 0
    var maxPixels = 0
    let pixelsPerFrame = 4096
    var x = 0
    var y = 0

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    override func render(canvas:Canvas) {
        if !rendered {
            if width == 0 {
                width = canvas.canvasSize!.width
            }
            if height == 0 {
                height = canvas.canvasSize!.height
                maxPixels = width * height
            }

            for _ in 0 ..< pixelsPerFrame {
                let r = absVal(Noise(x:Double(x)/256.0, y:0.5, z:Double(y)/256.0))
                let g = absVal(Noise(x:Double(x)/256.0, y:1.5, z:Double(y)/256.0))
                let b = absVal(Noise(x:Double(x)/256.0, y:2.5, z:Double(y)/256.0))
                
                let intR = r <= 1.0 && r >= 0.0 ? UInt8(r*255) : 0
                let intG = g <= 1.0 && g >= 0.0 ? UInt8(g*255) : 0
                let intB = b <= 1.0 && b >= 0.0 ? UInt8(b*255) : 0
                
                canvas.render(FillStyle(color:Color(red:intR, green:intG, blue:intB)))
                canvas.render(Rectangle(rect:Rect(topLeft:Point(x:x, y:y), size:Size(width:1, height:1)), fillMode:.fill))
                x += 1
                if x >= width {
                    y += 1
                    x = 0
                }
                if pixelsRendered >= maxPixels {
                    rendered = true
                    fatalError("finished rendering")
                }
            }
        }
    }
}
