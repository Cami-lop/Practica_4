#################################################
# ejemplo11.R
# Laboratorio de Procesamiento de Información Meteorológica
# 2º cuatrimestre 2019
################################################# 

#ejemplo de uso de readBin writeBin

#1 Escribo y leo los contenidos de un archivo:
 
#creo una matriz en el workspace!
  a=rnorm(5)

#Creo el archivo
    fid = file('rnorm5.bin', 'wb')
 fid    
    writeBin(a, fid)
    close(fid)

   
        
#leo el archivo
        fid = file('rnorm5.bin',"rb")
          m5 = readBin(fid, numeric(),10)
            close(fid)
m5

##############################
ff = file('r5normal.bin','wt')
ff
writeBin(a,ff)

