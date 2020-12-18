fn findReversed(string, char) {
    for let i = string.length-1; i > -1; i = i - 1 {
        if string[i] == char {
            return i
        }
    }
    return -1
}

fn parseIP(address) {
    let ix = findReversed(address, ":")
    return address[:ix]
}

fn getIP(rq, rs) {
    let address = parseIP(rq.address)
    let forwarded = rq.headers["X-Forwarded-For"]
    if forwarded != nil {
        address = forwarded[0]
    }
    io.println("Request from --> " + address)
    rs.write(200, address)
}

http.handler("/", getIP)

let listen = ":8092"
let port = env.get("PORT")
if port != "" {
    listen = ":" + port
}

io.println("Listen " + listen)
http.listen(listen)
