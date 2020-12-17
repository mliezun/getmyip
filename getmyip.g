fn parseIP(address) {
    let aux = 0
    for let i = address.length-1; i > -1; i = i - 1 {
        if address[i] == ":" {
            aux = i
            i = -1
        }
    }
    return address[:aux]
}

fn getIP(rq, rs) {
    io.println("Request from --> " + rq.address)
    rs.write(200, parseIP(rq.address))
}

http.handler("/", getIP)

let listen = ":8092"
io.println("Listen " + listen)
http.listen(listen)
