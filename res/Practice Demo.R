library(tidyquant)
library(ggplot2)
library(dplyr)
library(writexl)

getSymbols("^GSPC", from = '2025-01-01', to = "2025-12-31",warnings = FALSE, auto.assign = TRUE)

# Clean extracted data for export
sp500 <- data.frame(`GSPC`)
colnames(sp500) <- names(`GSPC`)
sp500$Date = rownames(sp500)
sp500$Date = as.Date.character(sp500$Date)
rownames(sp500) <- NULL
sp500 <- sp500 %>%
  relocate(Date, .before = GSPC.Open)

# write_xlsx(sp500, "sp500.xlsx")

# Plot the trend
sp500 %>%
  ggplot(aes(Date, GSPC.Adjusted)) +
  geom_line() +
  labs(y = "Adjusted Price")

# Calculating the 1-day log returns
# Sample size
n <- length(sp500$GSPC.Adjusted)
# Log returns
LR <- log( sp500$GSPC.Adjusted[-1]/ sp500$GSPC.Adjusted[-n])

hist(LR, breaks = 50, xlab = "Log-Returns", probability = TRUE, 
     cex.axis = 1.5, cex.lab = 1.5, main = "1-Day Log-returns")
box()  




