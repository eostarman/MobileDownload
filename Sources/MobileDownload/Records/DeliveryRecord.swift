/// Orders downloaded for delivery by the driver are "blobbed" (encoded) and sent down in these records

import MobileLegacyOrder

public final class DeliveryRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var order = LegacyOrder()

    public init() {}
}
