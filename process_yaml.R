library(yaml)

# 1. Read publications from a manually updated YAML file
# Make file is named 'publications_source.yaml'
pubs <- read_yaml("publications_source.yaml")

# 2. Process each entry to generate HTML buttons
pubs_processed <- lapply(pubs, function(x) {
  
  # Check if this entry has links
  if (!is.null(x$links)) {
    
    # Start an empty string for buttons
    buttons_html <- ""
    
    # Loop through every link in this entry
    for (link in x$links) {
      
      # Determine if it's a file or a URL (for target="_blank")
      target_attr <- ' target="_blank"' 
      
      # Optional: Add an icon if you want (e.g. <i class="bi bi-github"></i>)
      # You can assume specific icons based on text if you want, 
      # but plain text buttons are cleaner.
      
      # Build the HTML button
      # We use 'btn-outline-primary' for the blue outline look
      # 'btn-sm' makes them small and elegant
      btn <- sprintf(
        '<a href="%s" class="btn btn-outline-primary btn-sm" role="button"%s>%s</a>&nbsp;', 
        link$href, 
        target_attr,
        link$text
      )
      
      buttons_html <- paste0(buttons_html, btn)
    }
    
    # Inject this HTML into the 'subtitle' field
    # If you already have a subtitle in your manual YAML, this appends the buttons below it.
    if (is.null(x$subtitle)) {
      x$subtitle <- buttons_html
    } else {
      x$subtitle <- paste0(x$subtitle, "<br>", buttons_html)
    }
    x$links <- NULL  # Remove the original links field
  }
  
  # Return the modified entry
  return(x)
})

# 3. Save the result as the file Quarto actually uses
# We use !expr NULL to prevent R from adding weird metadata tags
write_yaml(pubs_processed, "publications.yaml", handlers = list(logical = function(x) {
  result <- ifelse(x, "true", "false")
  class(result) <- "verbatim"
  return(result)
}))

cat("✅ Processed", length(pubs), "publications into publications.yaml\n")