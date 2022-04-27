import Igis
import Foundation

class Triangle3d {
    let vertex1 : Point3d
    let vertex2 : Point3d
    let vertex3 : Point3d
    let color : (r:Double, g:Double, b:Double)

    init(_ vertex1:Point3d, _ vertex2:Point3d, _ vertex3:Point3d, _ color:(r:Double, g:Double, b:Double)) {
        self.vertex1 = vertex1
        self.vertex2 = vertex2
        self.vertex3 = vertex3
        self.color = color
    }

    func normal() -> Point3d { //returns the normal vector of the triangle
        let A = vertex2.sub(vertex1) // first edge vector
        let B = vertex3.sub(vertex2) // second edge vector
        return A.cross(B) // normal vector
    }

    func intersect(ray:Ray3d) -> Bool {
        let planeDistance = normal().dotProduct(vertex1) // distance of triangle's plane to origin
        if normal().dotProduct(ray.endpoint()) == 0.0 { // ray is parallell to the triangle
            return false
        }
        
        let t = (normal().dotProduct(ray.origin) + planeDistance) / normal().dotProduct(ray.endpoint()) // idk what t is but it's important
        if t < 0.0 { // triangle is behind the ray
            return false
        }
        
        let intercept = Point3d(x:ray.origin.x + t * ray.endpoint().x,
                                y:ray.origin.y + t * ray.endpoint().y,
                                z:ray.origin.z + t * ray.endpoint().z)
        let edge1 = vertex2.sub(vertex1)
        let edge2 = vertex3.sub(vertex2)
        let edge3 = vertex1.sub(vertex3)
        let C1 = intercept.sub(vertex1)
        let C2 = intercept.sub(vertex2)
        let C3 = intercept.sub(vertex3)
        
        if normal().dotProduct(edge1.cross(C1)) <= 0 &&
             normal().dotProduct(edge2.cross(C2)) <= 0 &&
             normal().dotProduct(edge3.cross(C3)) <= 0 {
            return true // intercept is inside triangle
        }
        return false
    }
}
