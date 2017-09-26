struct Location {
    let latitude : Double
    let longitude : Double
    let address : String?
    let venue : String?

    init(latitude: Double, longitude: Double, address: String? = nil, venue: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.venue = venue
    }
}