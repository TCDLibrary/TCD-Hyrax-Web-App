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
