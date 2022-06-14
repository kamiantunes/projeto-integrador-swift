enum VehicleType {
    case car
    case bike
    case microBus
    case bus
    
    var fee: Int {
        switch self {
        case .car:
            return 20
        case .bike:
            return 15
        case .microBus:
            return 25
        case .bus:
            return 30
        }
    }
}

struct Vehicle : Parkable, Hashable {
    let plate: String
    let type: VehicleType
    
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
    var type: VehicleType { get }
}

let estacionamento: Parking = Parking()
