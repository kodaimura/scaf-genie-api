(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using ScafGenie
const UserApp = ScafGenie
ScafGenie.main()
