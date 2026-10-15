class Equipo {
    var nombre 
    const nivelDeEnergiaBase
    const entrenador
    const tecnologiaComplementarias = []

    method nivelDeEnergiaBase() = nivelDeEnergiaBase 
    method NivelEnergiaComplementarias() = self.tecnologiaActiva().sum({t => t.valorEnergetico()})
    method energiaTotal() = self.nivelDeEnergiaBase() + self.NivelEnergiaComplementarias()
    method tecnologiaActiva() = tecnologiaComplementarias.filter({t => t.esActiva()}) 
    method agregarTecnologia(nuevaTecnologia){
        tecnologiaComplementarias.add(nuevaTecnologia)
    } 
    method entrenador() = entrenador 
    method adiccionales()
    method prestigioUniversal()
}

class Luminicos inherits Equipo{
    const nivelDeRadiacion
    const cristalesSolares = []

    method nivelDeRadiacion() = nivelDeRadiacion

    override method adiccionales(){
        if (self.nivelDeRadiacion() < 5000){
            return 0.10
        }
        else{
            return 1
        } 
    }                
    
    override method energiaTotal() = super() * self.adiccionales()

    override method prestigioUniversal()= cristalesSolares.size() >= 3  and self.entrenador().esEliteGalactico(self) and self.tecnologiaActiva().size() >= 1
      
}

class Sintetico inherits Equipo{
    const nivelDeProcesamiento
    const cantModulosActivos  
    const certificado

    method nivelDeProcesamiento() = nivelDeProcesamiento

    method cantModulosActivos() = cantModulosActivos
    method certificado() = certificado 
    override method adiccionales(){
        if (self.cantModulosActivos() > 5){
            return 0.80
        }
        else{
            return 1
        } 
    }
    override method energiaTotal() = super() * self.adiccionales()

    override method prestigioUniversal()=self.certificado() and self.cantModulosActivos() > 3 and tecnologiaComplementarias.all({t => t.esActiva()})
    
}

class Etericos inherits Equipo{
    const nivelDeDimesional
    const cantDePortalesAbiertos
    
    method nivelDeDimesional() =  nivelDeDimesional

    method cantDePortalesAbiertos() = cantDePortalesAbiertos
    override method prestigioUniversal()=self.nivelDeDimesional() > 75 and self.cantDePortalesAbiertos() >= 2 and self.tecnologiaActiva() >= 2 
    
}

class Entrenador{
    const nivelDePresion 
    const ciclosDeExp
    const estaEnSintonia
    var rolActual = guia 

    method estaEnSintonia() = estaEnSintonia 
    method ciclosDeExp() = ciclosDeExp 
    method nivelDePresion() = nivelDePresion.max(0).min(100)
    method CambiarRol(nuevoRol){
        if([estratega,arquitecto,guia].contains(nuevoRol)){
            rolActual = nuevoRol
        }
        else
            self.error("Rol no homologado por la FOZ") 
    }  
    method esEliteGalactico() = ciclosDeExp > 10 and rolActual.cumpleCondicion(self) 
}

object estratega{
    method cumpleCondicion(rol) = rol.nivelDePresion() > 80 
}

object arquitecto{
    method cumpleCondicion(rol) = rol.estaEnSintonia()

}

object guia{
   method cumpleCondicion(rol) =  true
}

class TecnologiasEspeciales{
    const nombre
    const valorEnergetico
    method valorEnergetico() = valorEnergetico
    method esActiva() = true  
}