plot_custom_map <- function(map,
                       data_to_join = data.frame(),
                       join_by = NULL,
                       var = "values",
                       theme = theme_map()) {
  
    if (any(class(map) == "sf")) map <- as(map, "Spatial") %>% ggplot2::fortify(region = "number_of_fires")
    map$id <- as.numeric(map$id)
    
    ggplot2::ggplot() +
      ggplot2::geom_polygon(ggplot2::aes(x = map$long, y = map$lat, group = map$group, fill=map$id),
                            data = map,
                            color = "black",
                            size = 0.2)+
      labs(fill = "Number of fires") +
      scale_fill_gradient(low="blue", high="red") +
      ggplot2::coord_fixed() +
      theme_map()
}


theme_map <- function(base_size = 9, base_family = "") {
  elementBlank = ggplot2::element_blank()
  `%+replace%` <- ggplot2::`%+replace%`
  unit <- ggplot2::unit
  
  ggplot2::theme_bw(base_size = base_size, base_family = base_family) %+replace%
    ggplot2::theme(axis.line = elementBlank,
                   axis.text = elementBlank,
                   axis.ticks = elementBlank,
                   axis.title = elementBlank,
                   panel.background = elementBlank,
                   panel.border = elementBlank,
                   panel.grid = elementBlank,
                   panel.spacing = unit(0, "lines"),
                   plot.background = elementBlank,
                   legend.justification = c(0, 0),
                   legend.position = c(0, 0))
}