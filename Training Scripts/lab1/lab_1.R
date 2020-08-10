x <- seq(1, 100, 0.1)
y <- seq(10, 1000, 0.1)
plot(runif(1000),runif(1000),main = "Pierwszy wykres")
x <- c(1,2,5,6) #c() jest to specjalna funckja do tworzenia wektora.
x[1]
x[2:3]
x>20 #sprawdzi kazdy element wektora czy jest wiekszy niz 20
x[x>20] #wypisze wszystkie elementy z wektora ktore sa wieksze niz 20.

x <- 120+25*rnorm(50)
mean(x)


#KORELACJA
a = 1
  x = 1:1000
eps = rnorm(1000)
y = x + a*eps
plot(x, y)
cor(x, y)

?rnorm



a=0
x=1:1000
eps=rnorm(1000)
y = x^2 + a^2*eps
plot(x, y)
cor(x, y)



a=0.1
x=seq(0,1,0.001)
eps=rnorm(1001)
y = ifelse(runif(1001)>0.5, 1, -1)*sqrt(1-x^2)+a*eps
plot(x, y)
cor(x, y)


a <- sample(0:1, 10000, rep =TRUE, prob = c(0.4,0.6)) #0/1 - orzel/reszka, 4 powtorzenia, zezwalamy na powtorzenia, prawdopodobienstwo 0.4,0.6
mean(a)

#Czyszczenie pamieci
rm(list=ls())

#Czytanie plikow CSV
met <- read.csv('resAg.csv', header=T)

#Czytanie pliku online
met<-read.table(file="http://biecek.pl/MOOC/dane/koty_ptaki.csv", sep=";", dec=",", header=TRUE)


#czytanie xls'a
piwa <- read_excel("Downloads/PiwaWyniki.xlsx", 2)
#przekazujemy zmienna piwa i kolumne Ocena
summary(piwa)


#Jak czytac zewnetrzne dane, do ktorych mamy dostep rpzez API
tsdtr210 <- getEurostatRCV("educ_iste")
head(tsdtr210, 3)
summary(tsdtr210)


#Typy zmiennych losowych
piwa$Tester <- as.factor(piwa$Tester)
piwa$Rodzaj <- as.factor(piwa$Rodzaj)

summary(piwa)


