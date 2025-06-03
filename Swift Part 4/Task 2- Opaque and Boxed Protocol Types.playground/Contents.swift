import Foundation

protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}

final class Rectangle: Shape {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func area() -> Double {
        return width * height
    }

    func perimeter() -> Double {
        return 2 * (width + height)
    }
}

final class Circle: Shape {
    var radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func area() -> Double {
        return .pi * radius * radius
    }

    func perimeter() -> Double {
        return 2 * .pi * radius
    }
}

func generateShape() -> Shape {
    return Circle(radius: 5.0)
}

func calculateShapeDetails(for shape: Shape) -> (area: Double, perimeter: Double) {
    let area = shape.area()
    let perimeter = shape.perimeter()
    return (area, perimeter)
}
