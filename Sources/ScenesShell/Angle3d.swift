func absVal(_ n:Double) -> Double {
    if n < 0 {
        return -n
    }
    return n
}

class Angle3d {
    var angleHorizontal : Double
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
