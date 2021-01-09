import Alchemy

// Add / drop tables for `User` and `UserToken` models.
struct _20210107155059CreateUsers: Migration {
    func up(schema: Schema) {
        schema.create(table: "users") {
            $0.int("id").primary()
            $0.string("name").notNull()
            $0.string("email").notNull().unique()
            $0.string("hashed_password").notNull()
        }
        
        schema.create(table: "user_tokens") {
            $0.int("id").primary()
            $0.string("value").notNull()
            $0.date("created_at").notNull()
            $0.int("user_id").references("id", on: "users").notNull()
        }
    }
    
    func down(schema: Schema) {
        schema.drop(table: "user_tokens")
        schema.drop(table: "users")
    }
}
