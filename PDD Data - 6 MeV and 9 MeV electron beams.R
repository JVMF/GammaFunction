library(ggplot2)

### ------------------------- DATA  ------------------------- ###

# Obtained from TrueBeam STx's PDDs measurements
Prof_E <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70)

# E6 Vectors
pdp_E6_0mm <- c(74.238, 77.493, 79.372, 81.378, 83.382, 85.511, 87.557, 89.687, 91.900, 94.113, 96.117, 97.912, 99.165, 100.000, 99.958, 99.165,
                97.495, 94.697, 89.981, 84.096, 79.543, 71.737, 64.555, 56.455, 50.271, 39.582, 8.618, 1.186, 1.006, 0.948, 0.898, 0.852,
                0.806, 0.768, 0.731)

pdp_E6_5mm <- c(87.39, 88.95, 91.14, 93.32, 95.38, 97.24, 98.68, 99.71, 100.00,  99.46,  98.06,  95.75,  92.42, 87.96, 82.52, 76.26, 69.13, 61.42,
                53.13, 44.64, 36.25, 28.33, 21.04, 14.89, 9.98, 6.33, 1.10, 0.99, 0.94, 0.88, 0.84, 0.80, 0.76, 0.73,  0.69)

pdp_E6_10mm <- c(97.89, 99.03, 99.88, 100.00, 99.35, 97.85, 95.21, 91.59, 86.92, 81.40, 74.78, 67.55, 59.59, 51.34, 42.73, 34.43, 26.52, 19.54,
                 13.60, 9.00, 5.61, 3.44, 2.14, 1.49, 1.19, 1.09, 0.98, 0.92, 0.87, 0.83, 0.79, 0.75, 0.71, 0.68, 0.65)

# E9 Vectors
pdp_9E_0mm <- c(79.18, 80.68, 82.26, 83.48, 84.78, 86.27, 87.09, 88.27, 89.37, 90.38, 91.36, 92.33, 93.30, 94.36, 95.29, 96.35, 97.20, 98.09,
                98.90, 99.55, 99.92, 100.00, 99.84, 99.31, 98.34, 95.96, 81.43, 53.58, 23.53, 5.96, 1.72, 1.47, 1.39, 1.32, 1.26)

pdp_9E_5mm <- c(87.97, 88.93, 89.53, 90.49, 91.38, 92.26, 93.26, 94.18, 95.19, 96.11, 97.11, 97.95, 98.72, 99.32, 99.80, 100.00, 99.92, 99.48,
                98.64, 97.47, 95.75, 93.58, 90.77, 87.57, 83.79, 79.46, 51.74, 21.65, 4.80, 1.63, 1.45, 1.38, 1.30, 1.24, 1.18)

pdp_9E_10mm <- c(93.12, 93.87, 94.62, 95.53, 96.44, 97.39, 98.22, 98.93, 99.54, 99.92, 100.00, 99.84, 99.29, 98.42, 97.03, 95.21, 92.88, 90.11,
                 86.67, 82.79, 78.32, 73.50, 68.16, 62.46, 56.49, 50.32, 20.54, 4.47, 1.60, 1.44, 1.36, 1.29, 1.23, 1.17, 1.12)

# Obtained from Eclipse EMC calculation
# Shift of 1.2 mm from first value (effective point of Diode detector: 1.2 mm +- 0.2 mm)
E6_B0_EMC <- c(73.67895366, 78.09142062, 79.52855569, 81.08673218, 83.53988025, 85.52776538, 87.13659197, 90.56783824, 91.95787190, 95.01021461,
                 97.51851021, 98.94614671, 99.83213732, 100.00000000, 98.47364535, 98.44569108, 96.84157156, 93.98924320, 89.33385093, 83.28945722,
                 78.64272702, 71.54411243, 64.47032467, 56.43134090, 48.31920395, 39.33350173, 8.57198250, 1.13270402, 0.08704617, 0.84592097,
                 0.78564416,  0.74098370, 0.71470443, 0.61750728, 0.57501557)

E9_B0_EMC <- c(76.990933, 81.716731, 82.460845, 83.905639, 86.567002, 87.979031, 88.797860, 89.801500, 89.896537, 90.241604, 92.175628, 93.387865,
               94.316842, 95.754257, 95.279324, 96.075675, 97.378324, 98.067210, 98.969997, 99.333358, 100.000000, 99.899884, 99.644339, 99.508990,
               98.115629, 95.437936, 80.613183, 54.061165, 23.513952, 5.810025, 1.728225, 1.422806, 1.333984, 1.275551, 1.212953)

# Shift of 1.2 mm from first value + 5 mm of bolus thickness
E6_B5_EMC <- c(85.6420677, 89.1744654,  90.8551008,  92.3714069,  94.6118920,  96.5102751,  98.4860374,  99.7810973, 100.0000000,  98.3465788,  97.9563849,
                 95.8713722,  92.2090939,  88.1616053,  82.7479204,  76.4502572,  68.7375758,  61.1139403,  52.6468309,  44.8314322,  36.6811284,  28.7063681,
                 22.0547979,  16.0343829,  10.7247103,   6.8772130,   0.9850721,   0.8291899,   0.8599492,   0.7904044,   0.8280052,   0.7566749,   0.6843609,
                 0.7643879,   0.6695935)

E9_B5_EMC <- c(86.688445, 88.741387, 89.688724, 90.636225, 90.869651, 92.316289, 93.596330, 94.765031, 95.648527, 96.621095, 97.837670, 98.471075,
                 98.682277, 98.859771, 99.173808, 99.172768, 99.685292, 100.000000, 99.829100, 98.546997, 96.781438, 94.031037, 91.512222, 88.372931,
                 84.757299, 80.210847, 52.068559, 22.551218, 5.233762, 1.623246, 1.304931, 1.319632, 1.188602, 1.038374, 1.133804)

# Shift of 1.2 mm from first value + 10 mm of bolus thickness
E6_B10_EMC <- c(97.1592462, 99.0362011, 100.0000000, 99.7122102, 98.8348198, 97.0156208, 94.5788711, 90.5187083, 85.1245936, 78.0814212, 71.4583641,
                64.0491870, 55.9241157, 48.0409190, 39.9460654, 32.0993359, 24.4701782, 18.1210535, 12.6299152, 8.3552591, 5.3758281, 3.2856741,
                2.0683671, 1.3600422, 1.0452720, 0.9236638, 0.8619610, 0.8376305, 0.8173937, 0.7427992, 0.7156689, 0.6556364, 0.6554598,
                0.6849848, 0.6775564)

E9_B10_EMC <- c(91.269123, 93.260600, 94.148795, 95.224391, 95.980086, 97.299575, 98.657393, 99.086059, 99.293102, 99.599919, 99.868125, 100.000000,
                  99.653111, 98.831068, 97.377507, 94.710025, 92.226456, 89.867864, 86.789879, 82.407844, 77.087818, 71.801700, 65.895868, 60.413782,
                  54.371819, 47.428548, 18.495324, 4.023643, 1.626236, 1.355532, 1.426461, 1.226951, 1.271348, 1.098040, 1.186438)

#### DATAFRAME START
df_E <- data.frame(Prof_E,
                       pdp_E6_0mm,
                       pdp_E6_5mm,
                       pdp_E6_10mm,
                       pdp_9E_0mm,
                       pdp_9E_5mm,
                       pdp_9E_10mm,
                       E6_B0_EMC,
                       E6_B5_EMC,
                       E6_B10_EMC,
                       E9_B0_EMC,
                       E9_B5_EMC,
                       E9_B10_EMC
                       )

## ---------------- E6 BOLUS 0 mm
gama_values_E6_B0 <- calc_gamma_index(Prof_E, pdp_E6_0mm, E6_B0_EMC)
gama <- gama_values_E6_B0$gama
gama <- gama * 100

E6_B0 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E, y = pdp_E6_0mm, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E, y = E6_B0_EMC, color = "Sem Bólus"),
            linewidth = 0.6) + 
  geom_point(aes(x = Prof_E, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_E, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP elétrons 6 MeV: Medido x Cálculo ECB sem bólus',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_E6_B0
E6_B0


## ---------------- E6 BOLUS 5 mm
gama_values_E6_B5 <- calc_gamma_index(Prof_E, pdp_E6_5mm, E6_B5_EMC)
gama <- gama_values_E6_B5$gama
gama <- gama * 100

E6_B5 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E, y = pdp_E6_5mm, color = "Bólus 5 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E, y = E6_B5_EMC, color = "Bólus 5 mm"),
            linewidth = 0.6) + 
  geom_point(aes(x = Prof_E, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_E, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Bólus 5 mm" = "red",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP elétrons 6 MeV: Medido x Cálculo ECB para bólus 5 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_E6_B5
E6_B5

## ---------------- E6 BOLUS 10 mm
gama_values_E6_B10 <- calc_gamma_index(Prof_E, pdp_E6_10mm, E6_B10_EMC)
gama <- gama_values_E6_B10$gama
gama <- gama * 100

E6_B10 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E, y = pdp_E6_10mm, color = "Bólus 10 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E, y = E6_B10_EMC, color = "Bólus 10 mm"),
            linewidth = 0.6) + 
  geom_point(aes(x = Prof_E, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_E, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Bólus 10 mm" = "blue",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP elétrons 6 MeV: Medido x Cálculo ECB para bólus 10 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))


gama_values_E6_B10
E6_B10

## ---------------- E9 BOLUS 0 mm
gama_values_E9_B0 <- calc_gamma_index(Prof_E, pdp_9E_0mm, E9_B0_EMC)
gama <- gama_values_E9_B0$gama
gama <- gama * 100

E9_B0 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E, y = pdp_9E_0mm, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E, y = E9_B0_EMC, color = "Sem Bólus"),
            linewidth = 0.6) + 
  geom_point(aes(x = Prof_E, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_E, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP elétrons 9 MeV: Medido x Cálculo ECB sem bólus',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_E9_B0
E9_B0

## ---------------- E9 BOLUS 5 mm
gama_values_E9_B5 <- calc_gamma_index(Prof_E, pdp_9E_5mm, E9_B5_EMC)
gama <- gama_values_E9_B5$gama
gama <- gama * 100

E9_B5 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E, y = pdp_9E_5mm, color = "Bólus 5 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E, y = E9_B5_EMC, color = "Bólus 5 mm"),
            linewidth = 0.6) + 
  geom_point(aes(x = Prof_E, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_E, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Bólus 5 mm" = "red",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP elétrons 9 MeV: Medido x Cálculo ECB para bólus 5 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_E9_B5
E9_B5

## ---------------- E9 BOLUS 10 mm
gama_values_E9_B10 <- calc_gamma_index(Prof_E, pdp_9E_10mm, E9_B10_EMC)
gama <- (gama_values_E9_B10$gama)
gama <- gama * 100

E9_B10 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E, y = pdp_9E_10mm, color = "Bólus 10 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E, y = E9_B10_EMC, color = "Bólus 10 mm"),
            linewidth = 0.6) + 
  geom_point(aes(x = Prof_E, y = gama, color = "Indice Gama"),
             size = 1.1) +
  geom_line(aes(x = Prof_E, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Bólus 10 mm" = "blue",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP elétrons 9 MeV: Medido x Cálculo ECB para bólus 10 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_E9_B10
E9_B10

### With / Without Bolus E6 ----------------- ###
Bolus_E6 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E,
                 y = pdp_E6_0mm,color = "Sem Bólus"),
             size = 1.0) + 
  geom_point(aes(x = Prof_E,
                 y = pdp_E6_5mm, color = "Bólus 5 mm"),
             size = 1.0) + 
  geom_point(aes(x = Prof_E,
                 y = pdp_E6_10mm, color = "Bólus 10 mm"),
             size = 1.0) +
  
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Bólus 5 mm" = "red",
                                "Bólus 10 mm" = "blue")) +
  labs(title = 'PDP elétrons 6 MeV na água para as 3 configurações de bólus',
       y = 'Porcentagem de dose em profundidade [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda')

Bolus_E6

### With / Without Bolus E9 ----------------- ###
Bolus_E9 <- ggplot(df_E) +
  geom_point(aes(x = Prof_E,
                 y = pdp_9E_0mm,color = "Sem Bólus"),
             size = 1.0) + 
  geom_point(aes(x = Prof_E,
                 y = pdp_9E_5mm, color = "Bólus 5 mm"),
             size = 1.0) + 
  geom_point(aes(x = Prof_E,
                 y = pdp_9E_10mm, color = "Bólus 10 mm"),
             size = 1.0) +
  
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Bólus 5 mm" = "red",
                                "Bólus 10 mm" = "blue")) +
  labs(title = 'PDP elétrons 9 MeV na água para as 3 configurações de bólus',
       y = 'Porcentagem de dose em profundidade [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda')

Bolus_E9



# -- Electrons -- #
Prof_E_D <- Prof_E[0:15]
pdp_E6_0mm_D <- pdp_E6_0mm[0:15]
pdp_E6_5mm_D <- pdp_E6_5mm[0:15]
pdp_E6_10mm_D <- pdp_E6_10mm[0:15]
pdp_E9_0mm_D <- pdp_9E_0mm[0:15]
pdp_E9_5mm_D <- pdp_9E_5mm[0:15]
pdp_E9_10mm_D <- pdp_9E_10mm[0:15]
pdp_tps_E6_0mm_D <- E6_B0_EMC[0:15]
pdp_tps_E6_5mm_D <- E6_B5_EMC[0:15]
pdp_tps_E6_10mm_D <- E6_B10_EMC[0:15]
pdp_tps_E9_0mm_D <- E9_B0_EMC[0:15]
pdp_tps_E9_5mm_D <- E9_B5_EMC[0:15]
pdp_tps_E9_10mm_D <- E9_B10_EMC[0:15]

# Electrons Dataframe Initialization
df_E_D <- data.frame(Prof_E_D,
                     pdp_E6_0mm_D,
                     pdp_E6_5mm_D,
                     pdp_E6_10mm_D,
                     pdp_E9_0mm_D,
                     pdp_E9_5mm_D,
                     pdp_E9_10mm_D,
                     pdp_tps_E6_0mm_D,
                     pdp_tps_E6_5mm_D,
                     pdp_tps_E6_10mm_D,
                     pdp_tps_E9_0mm_D,
                     pdp_tps_E9_5mm_D,
                     pdp_tps_E9_10mm_D
                     )

### ------------------------- DETAIL: Measure versus EMC calculation 6 MeV ----------------- ###

E6_D <- ggplot(df_E_D) +
  
  geom_point(aes(x = Prof_E_D,
                 y = pdp_E6_0mm_D, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E_D,
                y = pdp_tps_E6_0mm_D, color = "Sem Bólus"),
            size = 0.7) +
  geom_point(aes(x = Prof_E_D,
                 y = pdp_E6_5mm_D, color = "Bólus 5 mm"),
             size = 1.5) +
  geom_line(aes(x = Prof_E_D,
                y = pdp_tps_E6_5mm_D, color = "Bólus 5 mm"),
            size = 0.7) +
  geom_point(aes(x = Prof_E_D,
                 y = pdp_E6_10mm_D, color = "Bólus 10 mm"),
             size = 1.5) +
  geom_line(aes(x = Prof_E_D,
                y = pdp_tps_E6_10mm_D, color = "Bólus 10 mm"),
            size = 0.7) +
  
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Bólus 5 mm" = "red",
                                "Bólus 10 mm" = "blue")) +
  labs(title = ' Detalhe 6 MeV: PDP Medida x PDP calculada com ECB',
       y = 'Porcentagem de dose em profundidade [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda')
E6_D 

### ------------------------- DETAIL: Measure versus EMC calculation 9 MeV ----------------- ###

E9_D <- ggplot(df_E_D) +
  
  geom_point(aes(x = Prof_E_D,
                 y = pdp_E9_0mm_D, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_E_D,
                y = pdp_tps_E9_0mm_D, color = "Sem Bólus"),
            size = 0.7) +
  geom_point(aes(x = Prof_E_D,
                 y = pdp_E9_5mm_D, color = "Bólus 5 mm"),
             size = 1.5) +
  geom_line(aes(x = Prof_E_D,
                y = pdp_tps_E9_5mm_D, color = "Bólus 5 mm"),
            size = 0.7) +
  geom_point(aes(x = Prof_E_D,
                 y = pdp_E9_10mm_D, color = "Bólus 10 mm"),
             size = 1.5) +
  geom_line(aes(x = Prof_E_D,
                y = pdp_tps_E9_10mm_D, color = "Bólus 10 mm"),
            size = 0.7) +
  
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Bólus 5 mm" = "red",
                                "Bólus 10 mm" = "blue")) +
  labs(title = ' Detalhe 9 MeV: PDP Medida x PDP calculada com ECB',
       y = 'Porcentagem de dose em profundidade [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda')
E9_D 

