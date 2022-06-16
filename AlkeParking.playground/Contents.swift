import Foundation
import Darwin

//Exercício 2
enum VehicleType {
    case car
    case moto
    case miniBus
    case bus

    var fee: Int {
        switch self {
        case .car:
            return 20
        case .moto:
            return 15
        case .miniBus:
            return 25
        case .bus:
            return 30
        }
    }
}

struct Vehicle : Parkable, Hashable {

    let plate: String
    let type: VehicleType
    var checkInTime: Date
    var discountCard: String?
    var parkedTime: Int {
        get {
            Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }

    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        lhs.plate == rhs.plate
    }
}

struct Parking {
    var vehicles: Set<Vehicle> = Set()
    let maxVehicles = 20
    // Exercício 11
    var dataParking: (vehiclesRemoved: Int, earnings: Int) = (0,0)
    let onFinish: (Bool) -> Void = {$0 ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")}

    // Exercício 5
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish:(Bool) -> Void) {
        guard vehicles.count < maxVehicles else { return onFinish(false) }

        guard !vehicles.contains(vehicle) else { return onFinish(false) }

        onFinish(vehicles.insert(vehicle).inserted)
    }

    // Exercício 7
    mutating func checkOutVehicle(plate: String, onSuccess: (Int) -> Void, onError: () -> Void) {
        var vehicleRemoveOptional: Vehicle?

        for vehicle in vehicles {
            if vehicle.plate.elementsEqual(plate){
                vehicleRemoveOptional = vehicle
                break
            }
        }

        guard let vehicleRemove = vehicleRemoveOptional else { return onError() }
        vehicles.remove(vehicleRemove)
        dataParking.vehiclesRemoved += 1

        let hasDiscountCard = vehicleRemove.discountCard == nil ? false : true

        // Exercício 10
        let fee = calculateFee(vehicle: vehicleRemove, parkedTime: vehicleRemove.parkedTime, hasDiscountCard: hasDiscountCard)

        dataParking.earnings += fee

        onSuccess(fee)
    }

    // Exercício 8 e 9
    func calculateFee(vehicle: Vehicle, parkedTime: Int, hasDiscountCard: Bool) -> Int {
        let fixedFee = vehicle.type.fee
        let variableFee = Int(ceil(Double((parkedTime - 120)) / 15.0) * 5)

        let fee = parkedTime <= 120 ? fixedFee : fixedFee + variableFee

        return hasDiscountCard ? fee - Int(Double(fee) * 0.15) : fee
    }

    // Exercício 11
    func consulteDataParking() {
        print("\(dataParking.vehiclesRemoved) vehicles have checked out and have earnings of $\(dataParking.earnings)")
    }

    // Exercício 12
    func listVehicles() {
        for vehicle in vehicles {
            print("Plate: \(vehicle.plate)")
        }
    }
}

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    //Exercício 3
    var checkInTime: Date { get }
    var discountCard: String? { get }
    //Exercício 4
    var parkedTime: Int { get }
}

var alkeParking = Parking()

var vehicles: [Vehicle] = [
    Vehicle(plate: "AA111AA", type: VehicleType.car, checkInTime: Date(), discountCard:"DISCOUNT_CARD_001"),
    Vehicle(plate: "B222BBB", type:VehicleType.moto, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "CC333CC", type: VehicleType.miniBus, checkInTime: Date(), discountCard:nil),
    Vehicle(plate: "DD444DD", type: VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_002"),
    Vehicle(plate: "AA111BB", type: VehicleType.car, checkInTime: Date(), discountCard:"DISCOUNT_CARD_003"),
    Vehicle(plate: "B222CCC", type: VehicleType.moto, checkInTime: Date(), discountCard:"DISCOUNT_CARD_004"),
    Vehicle(plate: "CC333CC", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "DD444EE", type: VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_005"),
    Vehicle(plate: "AA111CC", type: VehicleType.car, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "B222DDD", type: VehicleType.moto, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "CC333EE", type: VehicleType.miniBus, checkInTime: Date(), discountCard:nil),
    Vehicle(plate: "DD444GG", type: VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_006"),
    Vehicle(plate: "AA111DD", type: VehicleType.car, checkInTime: Date(), discountCard:"DISCOUNT_CARD_007"),
    Vehicle(plate: "B222EEE", type: VehicleType.moto, checkInTime: Date(), discountCard: nil),
    Vehicle(plate: "CC333FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard:nil),
    Vehicle(plate: "DD444FF", type: VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_008"),
    Vehicle(plate: "AA111FF", type: VehicleType.car, checkInTime: Date(), discountCard:"DISCOUNT_CARD_009"),
    Vehicle(plate: "BB222FF", type: VehicleType.moto, checkInTime: Date(), discountCard:"DISCOUNT_CARD_010"),
    Vehicle(plate: "CC333GG", type: VehicleType.miniBus, checkInTime: Date(), discountCard:nil),
    Vehicle(plate: "DD444HH", type: VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_011"),
    Vehicle(plate: "AA111GG", type: VehicleType.car, checkInTime: Date(), discountCard:nil),
    Vehicle(plate: "BB222GG", type: VehicleType.car, checkInTime: Date(), discountCard:nil)
]



// Exercício 6
for vehicle in vehicles {
    alkeParking.checkInVehicle(vehicle, onFinish: alkeParking.onFinish)
}

print("\n")
alkeParking.listVehicles()

print("\n")

let onSuccess: (Int) -> Void = {print("Your fee is $\($0). Come back soon")}
let onError: () -> Void = {print("Sorry, the check-out failed")}

for vehicle in vehicles {
    alkeParking.checkOutVehicle(plate: vehicle.plate, onSuccess: onSuccess, onError: onError)
}

print("\n")
alkeParking.consulteDataParking()
