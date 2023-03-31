# Part 1 Palmer Penguins
## reference: https://allisonhorst.github.io/palmerpenguins/articles/examples.html

## libraries
install.packages("palmerpenguins")
library(palmerpenguins)
library(tidyverse)

## datasets (in-built)
data(package = 'palmerpenguins')
data(penguins)

## plotting without aesthetic mapping of species
ggplot(data = penguins,aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  scale_color_manual(values = c("darkorange","purple","cyan4")) +
  labs(title = "Penguin bill dimensions (omit species)",
       subtitle = "Palmer Station LTER",
       x = "Bill length (mm)",
       y = "Bill depth (mm)") +
  geom_smooth(method = "lm", se = FALSE, color = "gray50")

## plotting with species
ggplot(data = penguins,aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = species, shape = species), size = 3, alpha = 0.8) +
  scale_color_manual(values = c("darkorange","purple","cyan4")) +
  labs(title = "Penguin bill dimensions (omit species)",
       subtitle = "Palmer Station LTER",
       x = "Bill length (mm)",
       y = "Bill depth (mm)") +
  geom_smooth(method = "lm", se = FALSE, aes(color = species))

## break down with suggestions to include se = TRUE, etc.
## try facet_grid for species
## this is Simpson's paradox

# Part 2: COVID deaths (categorical, introduces data loading)
# reference: https://www.openintro.org/data/index.php?data=simpsons_paradox_covid

## read data
covid <- read_csv("simpsons_paradox_covid.csv")

## silly result
summary(covid)

## better
covid <- read_csv("simpsons_paradox_covid.csv", col_types = "fff")
summary(covid)

## base R - maybe omit
with(covid, table(vaccine_status, outcome))
with(covid, table(vaccine_status, outcome, age_group))

## tidyverse - a bit complex!
( simpleTabulation <- covid %>% count(vaccine_status, outcome) %>% 
  pivot_wider(names_from = "outcome", values_from = "n") %>%
  mutate(deathPerc = 100 * death / (death+survived)) )

## the pipe
VAX <- simpleTabulation %>% filter(vaccine_status == "vaccinated") %>% pull(deathPerc)
UNVAX <- simpleTabulation %>% filter(vaccine_status == "unvaccinated") %>% pull(deathPerc)

VAX/UNVAX
# vaxed 2.45 times more likely to die!!

## cross-tab to resolve Simpson's paradox
( crossTabulation <- covid %>% count(age_group, vaccine_status, outcome) %>%
  pivot_wider(names_from = "outcome", values_from = "n") %>%
  mutate(deathPerc = 100 * death / (death+survived)) )

VAX_young <- crossTabulation %>% filter(age_group == "under 50", vaccine_status == "vaccinated") %>% pull(deathPerc)
UNVAX_young <- crossTabulation %>% filter(age_group == "under 50", vaccine_status == "unvaccinated") %>% pull(deathPerc)

UNVAX_young/VAX_young
# unvaccinated young 1.39 times more likely to die!


VAX_old <- crossTabulation %>% filter(age_group == "50 +", vaccine_status == "vaccinated") %>% pull(deathPerc)
UNVAX_old <- crossTabulation %>% filter(age_group == "50 +", vaccine_status == "unvaccinated") %>% pull(deathPerc)

UNVAX_old/VAX_old
# unvaccinated old 3.54 times more likely to die!


## this is why we vaccinated old people first! and it's also why there were more unvaccinated young people
## whose overall mortality risk is lower - we could consider force of COVID-mortality across age with some scaling...


# Part 3: Sleep Data (showing failure of LM and superiority of Mixed Model)
# reference: https://psyteachr.github.io/stat-models-v1/introducing-linear-mixed-effects-models.html

## build in a pivot so make untidy version of source data
vignette("pivot")

# critical resource
sleepstudy %>%
  filter(Subject == "308") %>%
  ggplot(aes(x = Days, y = Reaction)) +
  geom_point() +
  scale_x_continuous(breaks = 0:9)

old <- theme_set(theme_bw()) # show them theme setting

ggplot(sleepstudy, aes(x = Days, y = Reaction)) +
  geom_point() +
  scale_x_continuous(breaks = 0:9) +
  facet_wrap(~Subject)

sleep2 <- sleepstudy %>%
  filter(Days >= 2) %>%
  mutate(days_deprived = Days - 2L)

sleep2 %>% head()

sleep2 %>%
  count(days_deprived, Days)

ggplot(sleep2, aes(x = days_deprived, y = Reaction)) +
  geom_point() +
  scale_x_continuous(breaks = 0:7) +
  #facet_wrap(~Subject) +
  labs(y = "Reaction Time", x = "Days deprived of sleep (0 = baseline)")

cp_model <- lm(Reaction ~ days_deprived, sleep2)

summary(cp_model)

coef(cp_model)

ggplot(sleep2, aes(x = days_deprived, y = Reaction)) +
  geom_abline(intercept = coef(cp_model)[1],
              slope = coef(cp_model)[2],
              color = 'blue') +
  geom_point() +
  scale_x_continuous(breaks = 0:7) +
  facet_wrap(~Subject) +
  labs(y = "Reaction Time", x = "Days deprived of sleep (0 = baseline)")

sleep2 %>% summary()

sleep2 %>% pull(Subject) %>% is.factor()

np_model <- lm(Reaction ~ days_deprived + Subject + days_deprived:Subject,
               data = sleep2)

summary(np_model)


all_intercepts <- c(coef(np_model)["(Intercept)"],
                    coef(np_model)[3:19] + coef(np_model)["(Intercept)"])

all_slopes  <- c(coef(np_model)["days_deprived"],
                 coef(np_model)[20:36] + coef(np_model)["days_deprived"])

ids <- sleep2 %>% pull(Subject) %>% levels() %>% factor()

# make a tibble with the data extracted above
np_coef <- tibble(Subject = ids,
                  intercept = all_intercepts,
                  slope = all_slopes)

np_coef


ggplot(sleep2, aes(x = days_deprived, y = Reaction)) +
  geom_abline(data = np_coef,
              mapping = aes(intercept = intercept,
                            slope = slope),
              color = 'blue') +
  geom_point() +
  scale_x_continuous(breaks = 0:7) +
  facet_wrap(~Subject) +
  labs(y = "Reaction Time", x = "Days deprived of sleep (0 = baseline)")

np_coef %>% pull(slope) %>% t.test()


pp_mod <- lmer(Reaction ~ days_deprived + (days_deprived | Subject), sleep2)

summary(pp_mod)

newdata <- crossing(
  Subject = sleep2 %>% pull(Subject) %>% levels() %>% factor(),
  days_deprived = 0:7)

head(newdata, 17)


newdata2 <- newdata %>%
  mutate(Reaction = predict(pp_mod, newdata))

ggplot(sleep2, aes(x = days_deprived, y = Reaction)) +
  geom_line(data = newdata2,
            color = 'blue') +
  geom_point() +
  scale_x_continuous(breaks = 0:7) +
  facet_wrap(~Subject) +
  labs(y = "Reaction Time", x = "Days deprived of sleep (0 = baseline)")

fixef(pp_mod)

# standard error of fixed effects
vcov(pp_mod) %>% diag() %>% sqrt()

tvals <- fixef(pp_mod) / sqrt(diag(vcov(pp_mod)))
tvals
2 * (1 - pnorm(abs(tvals)))

confint(pp_mod)

# random effects
sigma(pp_mod) # residual
# variance-covariance matrix for random factor Subject
VarCorr(pp_mod)[["Subject"]] # equivalently: VarCorr(pp_mod)[[1]]

theme_set(old)
