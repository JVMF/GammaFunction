library(ggplot2)

### ------------------------- DATA  ------------------------- ###

# Obtained from TrueBeam STx's PDDs measurements
Prof_Foton <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120)

# Without Bolus
pdp_x6_0mm <- c(42.097,  59.517,  70.425,  78.091,  84.606,  88.335,  91.571,  93.950,  96.033,  97.354,  98.413,  99.213,  99.570,  99.702,  99.934, 100.000,
                98.280,  96.065,  93.651,  91.237,  88.823,  86.409,  84.061,  81.713,  79.398,  77.149,  74.967,  72.784,  70.668,  68.585,  66.601,  64.616,
                62.731,  60.847,  59.061,  57.308,  55.622)

# 5mm Bolus
pdp_x6_5mm <- c(89.125,  91.558,  94.651,  96.653,  98.265,  99.084,  99.640,  99.902, 100.000,  99.935,  99.738,  99.509,  99.215,  98.823,  98.398,  98.038,
                95.651,  93.296,  90.876,  88.457,  86.004,  83.649,  81.262,  79.006,  76.750,  74.526,  72.400,  70.242,  68.182,  66.187,  64.192,  62.361,
                60.497,  58.666,  56.965,  55.232,  53.630)

# 10mm Bolus
pdp_x6_10mm <- c(99.903,  99.935, 100.000,  99.968,  99.806,  99.581, 99.290,  98.871,  98.452,  98.129,  97.613,  97.161,  96.710,  96.258,  95.710,  95.226,
                 92.839,  90.419,  88.032,  85.548,  83.194,  80.839,  78.548,  76.323,  74.097,  71.903,  69.839,  67.828,  65.806,  63.839, 61.935,  60.129,
                 58.323,  56.581,  54.903,  53.290,  51.742)

# Obtained from Eclipse AAA calculation
# Shift of 1.2 mm from first value (effective point of Diode detector: 1.2 mm +- 0.2 mm)
pdp_tps_AAA_0mm <- c(42.00286, 60.42525, 71.38655, 78.45235, 83.88115, 88.17796, 91.56522, 94.25369, 96.36703, 97.85329,
                     98.85268, 99.48643, 99.82275, 100.00000, 99.98604, 99.83693, 98.20654, 95.73432, 93.36000, 90.87499,
                     88.43638, 86.02810, 83.51482, 81.17115, 78.89639, 76.64822, 74.32030, 72.14927, 70.10103, 67.95150,
                     65.90968, 63.98510, 62.04842, 60.15777, 58.39935, 56.61901, 54.86490)

pdp_tps_AXB_0mm <- c(42.45432, 59.59892, 69.50901, 77.68991, 84.15415, 88.75667, 92.37534, 94.91412, 96.86296, 98.15309,
                     99.08290, 99.61100, 99.92682, 100.00000, 99.95407, 99.76855, 98.01800, 95.72883, 93.34349, 90.93422,
                     88.54565, 86.15080, 83.75295, 81.37040, 79.05033, 76.78871, 74.59141, 72.42917, 70.30538, 68.20578,
                     66.15267, 64.14420, 62.19963, 60.31212, 58.49034, 56.72471, 55.02069)

# Shift of 1.2 mm from first value + 5 mm of bolus thickness
pdp_tps_AAA_5mm <- c(88.85033, 92.07977, 94.66959, 96.63792, 98.02508, 98.97707, 99.59636, 99.90344, 100.00000, 99.94660,
                     99.79722, 99.59228, 99.31437, 98.97369, 98.56161, 98.11347, 95.63623, 93.25303, 90.76756, 88.31880,
                     85.90553, 83.37258, 80.98279, 78.71613, 76.45284, 74.12346, 71.96143, 69.91139, 67.75549, 65.72726,
                     63.80186, 61.86389, 59.98273, 58.22545, 56.44870, 54.69547, 53.07698)

pdp_tps_AXB_5mm <- c(87.95525, 91.05861, 93.97114, 96.06586, 97.66841, 98.70005, 99.42649, 99.80208, 100.00000, 99.99039,
                     99.88145, 99.65124, 99.37113, 99.02148, 98.64704, 98.23223, 95.98867, 93.59958, 91.20149, 88.80821,
                     86.42750, 84.02821, 81.65741, 79.33372, 77.08149, 74.87970, 72.72681, 70.59475, 68.50420, 66.44599,
                     64.44331, 62.49355, 60.61368, 58.78687, 57.02673, 55.31866, 53.66906)

# Shift of 1.2 mm from first value + 10 mm of bolus thickness
pdp_tps_AAA_10mm <- c(99.44808,  99.84058, 100.00000, 99.99823, 99.85432, 99.62367, 99.34540, 99.04091, 98.67145, 98.21777,
                      97.72397,  97.21358,  96.71856, 96.23052, 95.73004, 95.23073, 92.82743, 90.34427, 87.87990, 85.48020,
                      82.95785,  80.59493,  78.34994, 76.05912, 73.72971, 71.61950, 69.53215, 67.37948, 65.37488, 63.44764,
                      61.49732,  59.64447,  57.88831, 56.09703, 54.36351, 52.76337, 51.20657)

pdp_tps_AXB_10mm <- c(99.95325, 99.73021, 99.96585, 100.00000, 99.93407, 99.72553, 99.46415, 99.12079, 98.75576, 98.34458,
                      97.92552, 97.47653, 97.02965,  96.56297, 96.10142, 95.62326, 93.23729, 90.82327, 88.42339, 86.02558,
                      83.63863, 81.25932, 78.94078,  76.68219, 74.49119, 72.33027, 70.20451, 68.10975, 66.06169, 64.05767,
                      62.12028, 60.23783, 58.42643,  56.66856, 54.97477, 53.32982, 51.74364)

# Dataframe Initialization
df_x6 <- data.frame(Prof_Foton,
                    pdp_x6_0mm,
                    pdp_x6_5mm,
                    pdp_x6_10mm,
                    pdp_tps_AAA_0mm,
                    pdp_tps_AAA_5mm,
                    pdp_tps_AAA_10mm,
                    pdp_tps_AXB_0mm,
                    pdp_tps_AXB_5mm,
                    pdp_tps_AXB_10mm
                    )

### ------------------------- AAA 0 mm + Gamma  ------------------------- #####

gama_values_AAA_0 <- calc_gamma_index(Prof_Foton, pdp_x6_0mm, pdp_tps_AAA_0mm)
gama <- gama_values_AAA_0$gama
gama <- gama * 100

AAA_0 <- ggplot(df_x6) +
  geom_point(aes(x = Prof_Foton, y = pdp_x6_0mm, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton, y = pdp_tps_AAA_0mm, color = "Sem Bólus"),
            size = 0.6) + 
  geom_point(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
             size = 1.1) +
  geom_line(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
            size = 0.6) + 
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP fótons 6 MV: Medido x Cálculo AAA sem bólus',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1),
  ))

gama_values_AAA_0
AAA_0

### ------------------------- AXB 0 mm + Gamma  ------------------------- #####

gama_values_AXB_0 <- calc_gamma_index(Prof_Foton, pdp_x6_0mm, pdp_tps_AXB_0mm)
gama <- gama_values_AXB_0$gama
gama <- gama * 100

AXB_0 <- ggplot(df_x6) +
  geom_point(aes(x = Prof_Foton, y = pdp_x6_0mm, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton, y = pdp_tps_AXB_0mm, color = "Sem Bólus"),
            size = 0.6) + 
  geom_point(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP fótons 6 MV: Medido x Cálculo AXB sem bólus',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_AXB_0
AXB_0

### ------------------------- AAA 5 mm + Gamma  ------------------------- #####

gama_values_AAA_5 <- calc_gamma_index(Prof_Foton, pdp_x6_5mm, pdp_tps_AAA_5mm)
gama <- gama_values_AAA_5$gama
gama <- gama * 100

AAA_5 <- ggplot(df_x6) +
  geom_point(aes(x = Prof_Foton, y = pdp_x6_5mm, color = "Bólus 5 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton, y = pdp_tps_AAA_5mm, color = "Bólus 5 mm"),
            size = 0.6) + 
  geom_point(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
             size = 1.1) +
  geom_line(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
            size = 0.6) + 
  scale_color_manual(values = c("Bólus 5 mm" = "red",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP fótons 6 MV: Medido x Cálculo AAA para bólus 5 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1),
  ))

gama_values_AAA_5
AAA_5

### ------------------------- AXB 5 mm + Gamma  ------------------------- #####

gama_values_AXB_5 <- calc_gamma_index(Prof_Foton, pdp_x6_5mm, pdp_tps_AXB_5mm)
gama <- gama_values_AXB_5$gama
gama <- gama * 100

AXB_5 <- ggplot(df_x6) +
  geom_point(aes(x = Prof_Foton, y = pdp_x6_5mm, color = "Bólus 5 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton, y = pdp_tps_AXB_5mm, color = "Bólus 5 mm"),
            size = 0.6) + 
  geom_point(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Bólus 5 mm" = "red",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP fótons 6 MV: Medido x Cálculo AXB para bólus 5 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_AXB_5
AXB_5

### ------------------------- AAA 10 mm + Gamma  ------------------------- #####

gama_values_AAA_10 <- calc_gamma_index(Prof_Foton, pdp_x6_10mm, pdp_tps_AAA_10mm)
gama <- gama_values_AAA_10$gama
gama <- gama * 100

AAA_10 <- ggplot(df_x6) +
  geom_point(aes(x = Prof_Foton, y = pdp_x6_10mm, color = "Bólus 10 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton, y = pdp_tps_AAA_10mm, color = "Bólus 10 mm"),
            size = 0.6) + 
  geom_point(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Bólus 10 mm" = "blue",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP fótons 6 MV: Medido x Cálculo AAA para bólus 10 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_AAA_10
AAA_10

### ------------------------- AXB 10 mm + Gamma  ------------------------- #####

gama_values_AXB_10 <- calc_gamma_index(Prof_Foton, pdp_x6_10mm, pdp_tps_AXB_10mm)
gama <- gama_values_AXB_10$gama
gama <- gama * 100

AXB_10 <- ggplot(df_x6) +
  geom_point(aes(x = Prof_Foton, y = pdp_x6_10mm, color = "Bólus 10 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton, y = pdp_tps_AXB_10mm, color = "Bólus 10 mm"),
            size = 0.6) + 
  geom_point(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
             size = 1.1) + 
  geom_line(aes(x = Prof_Foton, y = gama, color = "Indice Gama"),
            linewidth = 0.6) + 
  scale_color_manual(values = c("Bólus 10 mm" = "blue",
                                "Indice Gama" = "green")) +
  labs(title = 'PDP fótons 6 MV: Medido x Cálculo AXB para bólus 10 mm',
       y = 'PDP [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda') +
  scale_y_continuous(sec.axis = sec_axis(trans = ~., name = "Indice Gama",
                                         breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1)))

gama_values_AXB_10
AXB_10

### With / Without Bolus ----------------- ###

Bolus_X6 <- ggplot(df_x6) +
  geom_point(aes(x = Prof_Foton,
                 y = pdp_x6_0mm,color = "Sem Bólus"),
             size = 1.0) + 
  geom_point(aes(x = Prof_Foton,
                 y = pdp_x6_5mm, color = "Bólus 5 mm"),
             size = 1.0) + 
  geom_point(aes(x = Prof_Foton,
                 y = pdp_x6_10mm, color = "Bólus 10 mm"),
             size = 1.0) +
  
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Bólus 5 mm" = "red",
                                "Bólus 10 mm" = "blue")) +
  labs(title = 'PDP fótons 6 MV na água para as 3 configurações de bólus',
       y = 'Porcentagem de dose em profundidade [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda')

Bolus_X6

### ---------- DETAILED GRAPHICS --------------- ###

Prof_Foton_D <- Prof_Foton[0:15]
pdp_x6_0mm_D <- pdp_x6_0mm[0:15]
pdp_x6_5mm_D <- pdp_x6_5mm[0:15]
pdp_x6_10mm_D <- pdp_x6_10mm[0:15]
pdp_tps_AAA_0mm_D <- pdp_tps_AAA_0mm[0:15]
pdp_tps_AAA_5mm_D <- pdp_tps_AAA_5mm[0:15]
pdp_tps_AAA_10mm_D <- pdp_tps_AAA_10mm[0:15]
pdp_tps_AXB_0mm_D <- pdp_tps_AXB_0mm[0:15]
pdp_tps_AXB_5mm_D <- pdp_tps_AXB_5mm[0:15]
pdp_tps_AXB_10mm_D <- pdp_tps_AXB_10mm[0:15]

# Photons Dataframe Initialization

df_Fotons_D <- data.frame(Prof_Foton_D,
                          pdp_x6_5mm_D,
                          pdp_x6_10mm_D,
                          pdp_tps_AAA_0mm_D,
                          pdp_tps_AAA_5mm_D,
                          pdp_tps_AAA_10mm_D,
                          pdp_tps_AXB_0mm_D,
                          pdp_tps_AXB_5mm_D,
                          pdp_tps_AXB_10mm_D
                          )

### ------------------------- DETAIL: Measure versus AAA calculation ----------------- ###

Fotons_AAAD <- ggplot(df_Fotons_D) +
  geom_point(aes(x = Prof_Foton_D, y = pdp_x6_0mm_D, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton_D, y = pdp_tps_AAA_0mm_D, color = "Sem Bólus"),
            size = 0.7) + 
  geom_point(aes(x = Prof_Foton_D, y = pdp_x6_5mm_D, color = "Bólus 5 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton_D, y = pdp_tps_AAA_5mm_D, color = "Bólus 5 mm"),
            size = 0.7) + 
  geom_point(aes(x = Prof_Foton_D, y = pdp_x6_10mm_D, color = "Bólus 10 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton_D, y = pdp_tps_AAA_10mm_D, color = "Bólus 10 mm"),
            size = 0.7) + 
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Bólus 5 mm" = "red",
                                "Bólus 10 mm" = "blue")) +
  labs(title = ' Detalhe: PDP Medida x PDP calculada com AAA',
       y = 'Porcentagem de dose em profundidade [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda')
 
Fotons_AAAD


### ------------------------- DETAIL: Measure versus AXB calculation ----------------- ###

Fotons_AXBD <- ggplot(df_Fotons_D) +
  geom_point(aes(x = Prof_Foton_D, y = pdp_x6_0mm_D, color = "Sem Bólus"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton_D, y = pdp_tps_AXB_0mm_D, color = "Sem Bólus"),
            size = 0.7) + 
  geom_point(aes(x = Prof_Foton_D, y = pdp_x6_5mm_D, color = "Bólus 5 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton_D, y = pdp_tps_AXB_5mm_D, color = "Bólus 5 mm"),
            size = 0.7) + 
  geom_point(aes(x = Prof_Foton_D, y = pdp_x6_10mm_D, color = "Bólus 10 mm"),
             size = 1.5) + 
  geom_line(aes(x = Prof_Foton_D, y = pdp_tps_AXB_10mm_D, color = "Bólus 10 mm"),
            size = 0.7) + 
  scale_color_manual(values = c("Sem Bólus" = "orange",
                                "Bólus 5 mm" = "red",
                                "Bólus 10 mm" = "blue")) +
  labs(title = ' Detalhe: PDP Medida x PDP calculada com AXB',
       y = 'Porcentagem de dose em profundidade [%]',
       x = 'Profundidade [mm]', 
       color = 'Legenda')

Fotons_AXBD



