package co.propiedad.horizontal.ud.service;

import co.propiedad.horizontal.ud.model.Persona;
import co.propiedad.horizontal.ud.repository.PersonaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonaService {

    @Autowired
    private PersonaRepository personaRepository;

    public Persona save(Persona persona){
        return personaRepository.save(persona);
    }

}
