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
}
