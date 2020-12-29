import Alchemy

struct UserJSON: Codable {
    let age: Int
    let name: String
}

struct User: Model, BasicAuthable {
    static var tableName: String = "users"
    static var usernameKeyString: String = "email"
    static var keyMappingStrategy: DatabaseKeyMappingStrategy { .convertToSnakeCase }
    
    var id: UUID?
    let bmi: Double
    let email: String
    let age: Int
    let isPro: Bool
    let createdAt: Date
    var someJSON: UserJSON?
    let passwordHash: String
    
    @BelongsTo
    var parent: User?
    
    @HasOne(this: "pet", to: \.$owner, keyString: "owner_id")
    var pet: Pet?
    
    @HasMany(this: "pets", to: \.$owner, keyString: "owner_id")
    var pets: [Pet]
}

struct UserToken: Model, TokenAuthable {
    static var userKey: KeyPath<UserToken, BelongsTo<User>> = \.$user
    
    var id: Int?
    let value: String
    
    @BelongsTo
    var user: User
    
    @BelongsTo
    var user2: User?
    
    @HasMany
    var user3: [User]
    
    @HasOne
    var user4: User?
    
    @HasOne
    var user5: User
}

enum PetType: Int, Codable {
    case dog, cat
}

struct Pet: Model {
    static var tableName: String = "pets"
    
    var id: Int?
    let name: String
    let type: PetType
    
    @BelongsTo
    var owner: User
    
    @HasMany(
        named: "vaccines",
        from: \PetVaccine.$pet,
        to: \.$vaccine,
        fromString: "pet_id",
        toString: "vaccine_id"
    )
    var vaccines: [Vaccine]
}

struct Vaccine: Model {
    static var tableName: String = "vaccines"
    
    var id: Int?
    let name: String
}

struct PetVaccine: Model {
    static var tableName: String = "pet_vaccines"
    
    var id: Int?
    
    @BelongsTo
    var pet: Pet
    
    @BelongsTo
    var vaccine: Vaccine
}