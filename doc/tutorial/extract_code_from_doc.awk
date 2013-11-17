BEGIN {
  is_inside_listing = 0;
  i = 0;
}

/^\..+$/ {
  title=substr($0, 2, length($0));
  gsub(" ", "_", title);
}

/^-{1,72}/ {
  is_inside_listing = ! is_inside_listing
  i++;
  if (! is_inside_listing && title != "") {
    title = "";
  }
  next
}

is_inside_listing == 1 && title != "" {
  print $0 > title".ml"
}
