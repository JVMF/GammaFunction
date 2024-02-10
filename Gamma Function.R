# Gamma Function Complete
calc_gamma_index <- function(profundidade, medido, calculado, tolerancia = 1, distancia_maxima = 1) {
  
  ## Dose Difference Function
  calc_DoseDif <- function(medido, calculado) {
    
    # Verify if the curves has the same length
    if (length(medido) != length(calculado)) {
      stop("R1zou, mano! As curvas de dose devem ter o mesmo comprimento.")
    }
    
    # Calculate the dose difference between the curves
    diferenca <- (medido - calculado)
    return(diferenca)
  }
  
  ## DTA Function
  calc_DTA <- function(profundidade, medido, calculado, distancia_maxima) {
    
    # Verify if the curves has the same length
    if (length(medido) != length(calculado)) {
      stop("R1zou, mano! As curvas de dose devem ter o mesmo comprimento.")
    }
    # Vector to store the distance
    DTA <- numeric(length(profundidade))
    
    # Calculate distance for which depth data point
    for (i in seq_along(profundidade)) {
      
      # Find dose correspondence at second curve
      dose_correspondente <- calculado[which.min(abs(calculado - medido[i]))]
      
      # Find position (depth) correspondence at second curve
      posicao_correspondente <- profundidade[which.min(abs(calculado - dose_correspondente))]
      
      # Calculate the distance between the points
      distancia <- abs(profundidade[i] - posicao_correspondente) / 10
      
      # Return Inf if the result is out of the tolerance [defined in mm]
      DTA[i] <- ifelse(distancia > distancia_maxima, Inf, distancia)
    }
    return(DTA)
  }
  
  # Calculate the Dose Difference
  dif_dose <- calc_DoseDif(medido, calculado)
  
  # Calculate DTA
  dta <- calc_DTA(profundidade, medido, calculado, distancia_maxima)
  
  # Minimum between dose difference and DTA
  min_diff <- pmin(abs(dif_dose), dta)
  
  # Gamma Index
  gamma <- min_diff / tolerancia
  
  # Pass Rate
  gamma[gamma > 1] <- Inf
  gamma[is.infinite(gamma)] <- NA  # Define as NA if is inf (only because its more pleasure)
  pass_rate <- sum(gamma <= 1, na.rm = TRUE) / length(gamma) * 100
  
  # Return the minimum between  dose difference and DTA, Gamma Index and the pass rate
  return(list(min_diff = min_diff, gama = gamma, pass_rate = pass_rate))
}