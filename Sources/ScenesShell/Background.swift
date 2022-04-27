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
    let pixelsPerFrame = 2048
    var x = 0
    var y = 0
    var pixelSize : Double = 0

    let testTriangle1 = Triangle3d(Point3d(x:-1, y:1, z:4),
                                   Point3d(x:-1, y:-1, z:4),
                                   Point3d(x:1, y:-1, z:4),
                                   (r:1.0,g:0.0,b:0.0))
    let testTriangle2 = Triangle3d(Point3d(x:1, y:-1, z:4),
                                   Point3d(x:1, y:1, z:4),
                                   Point3d(x:-1, y:1, z:4),
                                   (r:0.0,g:0.0,b:1.0))

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    /*
    func crunchyNoise(x:Int, y:Int, z:Int, iterations:Int, zoom:Int) -> Double {
        var height = 0.0

        for iteration in 1 ... iterations {
            height += Noise(x:Double(x)/(pow(2.0, Double(iteration)) * Double(zoom)), y:Double(8 * y + iteration)+0.5, z:Double(z)/(pow(2.0, Double(iteration)) * Double(zoom)))
        }

        height /= 0.75 + (Double(iterations) / 4.0)
        
        if height <= -1.0 {
            return -1.0
        } else if height >= 1.0 {
            return 1.0
        }
        return height
    }

    func mapToColor(_ value:Double) -> Color {
        if value < (1.0/6.0) {
            return Color(red:255, green:UInt8(6*255*value), blue:0)
        } else if value < (2.0/6.0) {
            return Color(red:255-UInt8(6*255*(value-(1.0/6.0))), green:255, blue:0)   
        } else if value < (3.0/6.0) {
            return Color(red:0, green:255, blue:UInt8(6*255*(value-(2.0/6.0))))
        } else if value < (4.0/6.0) {
            return Color(red:0, green:255-UInt8(6*255*(value-(3.0/6.0))), blue:255)
        } else if value < (5.0/6.0) {
            return Color(red:UInt8(6*255*(value-(4.0/6.0))), green:0, blue:255)
        } else {
            return Color(red:255, green:0, blue:255-UInt8(6*255*(value-(5.0/6.0))))
        }
    }
     */
    
    override func render(canvas:Canvas) {
        if !rendered {
            if width == 0 {
                width = canvas.canvasSize!.width
                canvas.render(FillStyle(color:Color(red:32, green:32, blue:32)))
                canvas.render(Rectangle(rect:Rect(topLeft:Point(x:0, y:0), size:canvas.canvasSize!), fillMode:.fill))
            }
            if height == 0 {
                height = canvas.canvasSize!.height
                maxPixels = width * height
                pixelSize = 4.0/Double(height)
            }

            let canvasCenter = Point(x:width/2, y:height/2)
            
            for _ in 0 ..< pixelsPerFrame {
                let relativePoint = Point(x:x-canvasCenter.x, y:y-canvasCenter.y)
                let XY = DoublePoint(x:Double(relativePoint.x) * pixelSize, y:Double(relativePoint.y) * pixelSize)
                let ray = Ray3d(origin:Point3d(x:XY.x, y:XY.y, z:0))
                ray.length = 1.0
                var r = 0.0
                var g = 0.0
                var b = 0.0

                if testTriangle1.intersect(ray:ray) {
                    r = testTriangle1.color.r
                    g = testTriangle1.color.g
                    b = testTriangle1.color.b
                }
                if testTriangle2.intersect(ray:ray) {
                    r = testTriangle2.color.r
                    g = testTriangle2.color.g
                    b = testTriangle2.color.b
                }
                
                let intR = UInt8(r*255)
                let intG = UInt8(g*255)
                let intB = UInt8(b*255)

                /*
                let noise = (crunchyNoise(x:x, y:1, z:y, iterations:2, zoom:64) + 1.0) / 2.0
                let color = mapToColor(noise)
                */
                
                canvas.render(FillStyle(color:(Color(red:intR, green:intG, blue:intB))))
                canvas.render(Rectangle(rect:Rect(topLeft:Point(x:x, y:y), size:Size(width:1, height:1)), fillMode:.fill))
                x += 1
                pixelsRendered += 1
                if x >= width {
                    y += 1
                    x = 0
                }
                if pixelsRendered >= maxPixels {
                    rendered = true
                }
            }
        } else {
            fatalError("finished rendering")
        }
    }
}
