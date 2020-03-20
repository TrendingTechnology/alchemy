struct APIServer: Application {
    @Inject var db: Database
    @Inject var router: Router<Request>

    func setup() {
        self.db
            .configure()

        self.router
            // Applied to all subsequent routes
            .middleware(LoggingMiddleware())
            // Group all requests to /users
            .group(path: "/users") {
                // `POST /users`
                $0.on(.post, do: { req in "hi from create user" })
                    // `POST /users/reset`
                    .on(.post, at: "/reset", do: { req in "hi from user reset" })
                    // Applies to the rest of the requests in this chain, giving them a `User` parameter.
                    .middleware(BasicAuthMiddleware())
                    // `POST /users/login`
                    .on(.post, at: "/login") { req, authedUser in "hi from user login" }
            }
            // Applies to requests in this group, validating a token auth and giving them a `User` parameter.
            .group(with: TokenAuthMiddleware()) {
                // Applies to the rest of the requests in this chain.
                $0.path("/todo")
                    // `POST /todo`
                    .on(.post) { req, user in "hi from todo create" }
                    // `PUT /todo`
                    .on(.put) { req, user in "hi from todo update" }
                    // `DELETE /todo`
                    .on(.delete) { req, user in "hi from todo delete" }

                // Abstraction for handling requests related to friends.
                let friends = FriendsController()

                // Applies to the rest of the requests in this chain.
                $0.path("/friends")
                    // `POST /friends`
                    .on(.post, do: friends.message)
                    // `DELETE /friends`
                    .on(.delete, do: friends.remove)
                    // `POST /friends/message`
                    .on(.post, at: "/message", do: friends.message)
            }
    }
}

struct LoggingMiddleware: Middleware {
    func intercept(_ input: Request) -> Void {
        print("hey")
    }
}
