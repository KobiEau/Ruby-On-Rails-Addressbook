class Rack::Attack
  #Rule 1 Throttle all requests by IP
  throttle("request/ip",limit:100, period:1.minute) do |req|
    req.ip
  end

  #Rule 2 Stricter limit on login attempts
  throttle("logins/ip",limit:10, period: 1.minute) do |req|
    req.ip if req.path == "/users/sign_in" && req.post?
  end

  #Rule 3 
  #plain text 429 response is returned instead of hitting app
  self.throttled_responder = lambda do |req|
    [
      429,
      { "Content-Type"=>"text/plain" },
      ["Too many requests. Please wait a moment and try again"]
    ]
  end
end