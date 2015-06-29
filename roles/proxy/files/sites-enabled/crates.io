server {
    server_name crates.io www.crates.io;
    rewrite ^ http://doc.crates.io$request_uri?;
}

