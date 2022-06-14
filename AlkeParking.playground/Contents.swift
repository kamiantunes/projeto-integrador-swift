struct Vehicle : Parkable, Hashable {
    var plate: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        lhs.plate == rhs.plate
    }
}

struct Parking {
    var vehicles: Set<Vehicle> = Set()
}

protocol Parkable {
    var plate: String { get }
}

let estacionamento: Parking = Parking()
