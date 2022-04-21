import Igis
import Scenes
import Foundation

public class Ray3d {
    var origin : Point3d
    var angle : Angle3d
    var length : Double

    init(origin:Point3d, angle:Angle3d = Angle3d(h:0.0, v:0.0)) {
        self.origin = origin
        self.angle = angle
        self.length = 0.0
    }

    func endpoint() -> Point3d {
        let y = length * sind(angle.angleVertical)
        let horizontalVector = length * cosd(angle.angleVertical)
        
        let z = horizontalVector * cosd(angle.angleHorizontal)
        let x = horizontalVector * sind(angle.angleHorizontal)
        
        return Point3d(x:x, y:y, z:z)
    }
}
