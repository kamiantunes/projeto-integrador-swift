import Foundation
import Darwin
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
    var parkedTime: Int?



    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }

    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        lhs.plate == rhs.plate
    }

    func checkOutVehicle(plate: String, onSuccess: (Int) -> Void, onError: ()) {
        guard alkeParking.vehicles.contains(self) else
            {
            return onError
            }
        let veiculoRemover = self
        alkeParking.vehicles.remove(veiculoRemover)
        onSuccess(2)
    }
}

struct Parking {
    var vehicles: Set<Vehicle> = Set()
    let quantidadeMaximaVeiculos = 3

    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish:
    (Bool) -> Void) {

        guard vehicles.count < quantidadeMaximaVeiculos else {
            return onFinish(false)

        }

        guard !vehicles.contains(vehicle) else {
            return onFinish(false)

        }

        onFinish(vehicles.insert(vehicle).inserted)
    }

    func onFinished(aceito: Bool){
        if aceito {
            print("Welcome to AlkeParking!")
        } else {
            print("Sorry, the check-in failed")
        }
    }

    func calculateFee(vehicle: Vehicle, parkedTime: Int) -> Int {

        if parkedTime <= 120 {
            return vehicle.type.fee
        } else {
            return vehicle.type.fee + ((parkedTime - 120)/15 * 5)        }
    }
}

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var checkInTime: Date { get }
    var discountCard: String? { get }
    var parkedTime: Int? { get }

    func checkOutVehicle(plate: String, onSuccess:
                         (Int)->Void, onError:())

}

let estacionamento: Parking = Parking()

var alkeParking = Parking()

let vehicle1 = Vehicle(plate: "AA111AA", type:
VehicleType.car, checkInTime: Date(), discountCard:"DISCOUNT_CARD_001")

let vehicle2 = Vehicle(plate: "B222BBB", type:
VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle3 = Vehicle(plate: "CC333CC", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:nil)

let vehicle4 = Vehicle(plate: "DD444DD", type:
VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_002")

let vehicle5 = Vehicle(plate: "AA111BB", type:
VehicleType.car, checkInTime: Date(), discountCard:"DISCOUNT_CARD_003")

let vehicle6 = Vehicle(plate: "B222CCC", type:
VehicleType.moto, checkInTime: Date(), discountCard:"DISCOUNT_CARD_004")

let vehicle7 = Vehicle(plate: "CC333CC", type:
VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle8 = Vehicle(plate: "DD444EE", type:
VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_005")

let vehicle9 = Vehicle(plate: "AA111CC", type:
VehicleType.car, checkInTime: Date(), discountCard: nil)

let vehicle10 = Vehicle(plate: "B222DDD", type:
VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle11 = Vehicle(plate: "CC333EE", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:nil)

let vehicle12 = Vehicle(plate: "DD444GG", type:
VehicleType.bus, checkInTime: Date(), discountCard:"DISCOUNT_CARD_006")

let vehicle13 = Vehicle(plate: "AA111DD", type:
VehicleType.car, checkInTime: Date(), discountCard:"DISCOUNT_CARD_007")

let vehicle14 = Vehicle(plate: "B222EEE", type:
VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle15 = Vehicle(plate: "CC333FF", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:nil)

var veiculos: [Vehicle] = [
    vehicle1,
    vehicle2,
    vehicle3
]

for veiculo in veiculos {
    alkeParking.checkInVehicle(veiculo, onFinish: alkeParking.onFinished(aceito:))
}
