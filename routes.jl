using Genie.Router
using Genie.Renderer

using ScafGenie.Auth
using ScafGenie.Responses

frontend_origin = get(ENV, "FRONTEND_ORIGIN", "http://localhost:3000")
Genie.config.cors_headers["Access-Control-Allow-Origin"] = frontend_origin
Genie.config.cors_headers["Access-Control-Allow-Credentials"] = "true"
Genie.config.cors_headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS, PATCH"
Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization"

route("/api/accounts/login", method="POST") do
    return AccountsController.login()
end

route("/api/accounts/logout", method="POST") do
    return AccountsController.logout()
end

route("/api/accounts/signup", method="POST") do
    return AccountsController.signup()
end

route("/api/accounts/refresh", method="POST") do
    return AccountsController.refresh()
end

route("/api/accounts/me") do
    with_api_auth() do payload
        return AccountsController.me(payload)
    end
end

###################################################################################################

function with_api_auth(f::Function)
    payload = authenticated()
    if isnothing(payload)
        return json_unauthorized()
    end
    return f(payload)
end

###################################################################################################