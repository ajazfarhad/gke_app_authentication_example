require 'json'

response = ->(req) { 
    [ 200, 
      { 'Content-Type' => 'application/json' }, 
      [{message: 'Rack application is running.'}.to_json]
    ] 
}
response_handler = ->(env) {
  req = Rack::Request.new(env)
  status, headers, body = response[req]
  body = [{message: "Hello World! - #{req.ip}"}.to_json] if req.path_info.eql?('/hello')
  [status, headers, body]
}

APP = ->(env) { response_handler[env] } 

run APP
