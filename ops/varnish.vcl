vcl 4.0;

backend default {
  .host = "web:3000";
}


sub vcl_recv {
    if (req.url ~ "^/(users|notifications|dashboard|admin|importers|exporters|embargos|leases|content_blocks)"
        )  {
        return(pipe);
    }
}

sub vcl_backend_response {

        # For static content strip all backend cookies and push to static storage
        if (bereq.url ~ "\.(css|js|png|gif|jp(e?)g)|tif(f?)|pdf|swf|ico") {
                unset beresp.http.cookie;
                set beresp.storage_hint = "static";
                set beresp.http.x-storage = "static";
        } else {
                set beresp.storage_hint = "default";
                set beresp.http.x-storage = "default";
        }

}
