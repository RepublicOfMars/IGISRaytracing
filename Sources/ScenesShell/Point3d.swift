import Igis
import Foundation

public class Point3d {
    // point on (x, y, z)
    var x : Double
    var y : Double
    var z : Double

    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    // Stand in for vector
    func distance() -> Double {
        return sqrt((self.x) * (self.x) + (self.y) * (self.y) + (self.z) + (self.z))
    }

    func add(_ point:Point3d) -> Point3d {
        return Point3d(x:self.x + point.x, y:self.y + point.y, z:self.z + point.z)
    }
    func sub(_ point:Point3d) -> Point3d {
        return Point3d(x:self.x - point.x, y:self.y - point.y, z:self.z - point.z)
    }

    func cross(_ point:Point3d) -> Point3d {
        return Point3d(x:(self.y * point.z) - (self.z * point.y),
                       y:(self.z * point.x) - (self.x * point.z),
                       z:(self.x * point.y) - (self.y * point.x))
    }

    func dotProduct(_ point:Point3d) -> Double {
        return -((self.x * point.x) + (self.y * point.y) + (self.z * point.z))
    }
}
