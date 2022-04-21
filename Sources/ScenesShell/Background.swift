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

func sharpen(_ color:Color) -> Color {
    let red = color.red <= 128 ? UInt8(0) : UInt8(255)
    let green = color.green <= 128 ? UInt8(0) : UInt8(255)
    let blue = color.blue <= 128 ? UInt8(0) : UInt8(255)
    return Color(red:red, green:green, blue:blue)
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

    func crunchyNoise(x:Int, y:Int, z:Int) -> Double {
        var height = 0.0

        for iteration in 1 ... 8 {
            height += Noise(x:Double(x)/pow(2.0, Double(iteration)), y:Double(8 * y + iteration)+0.5, z:Double(z)/pow(2.0, Double(iteration)))
        }
        height /= 8.0

        return height
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
                let r = crunchyNoise(x:x, y:1, z:y)
                let g = crunchyNoise(x:x, y:2, z:y)
                let b = crunchyNoise(x:x, y:3, z:y)

                let intR = r <= 1.0 && r >= 0.0 ? UInt8(r*255) : 0
                let intG = g <= 1.0 && g >= 0.0 ? UInt8(g*255) : 0
                let intB = b <= 1.0 && b >= 0.0 ? UInt8(b*255) : 0
                
                canvas.render(FillStyle(color:(Color(red:intR, green:intG, blue:intB))))
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
