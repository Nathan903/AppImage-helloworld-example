print("hello")

# Change the scripts working directory to the script's own directory 
import os
abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

print("content of sometext.txt is:", open("sometext.txt").read())
