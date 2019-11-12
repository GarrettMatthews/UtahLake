## This is because there are some things that I have an easier time thinking through in Python than in R ##

import csv

with open("Data/meanyear_cat.csv","r") as data:
    reader = csv.reader(data)
    dat_list = list(reader)


print(dat_list)

dat_new = []
dat_new.append(dat_list[0])

print(len(dat_list[1]))

for i in range(len(dat_list)):
    if dat_list[i][7] == "Poison":
        dat_new.append(dat_list[i])

with open("Data/poisons.csv","w") as wr:
    writer = csv.writer(wr)
    writer.writerows(dat_new)

print(dat_new)