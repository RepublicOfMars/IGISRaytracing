import Foundation

func sind(_ degrees:Double) -> Double {
    return sin(degrees * (Double.pi / 180))
}
func cosd(_ degrees:Double) -> Double {
    return cos(degrees * (Double.pi / 180))
}

class Angle3d {
    var angleHorizontal : Double // 0 degrees is positive on the z axis
    var angleVertical : Double

    init(h:Double, v:Double) {
        angleHorizontal = h
        angleVertical = v
    }

    func correctAngle() {
        while angleHorizontal >= 360.0 {angleHorizontal -= 360.0}
        while angleVertical >= 360.0 {angleVertical -= 360.0}
        while angleHorizontal < 0.0 {angleHorizontal += 360.0}
        while angleVertical < 0.0 {angleVertical += 360.0}
    }
}
