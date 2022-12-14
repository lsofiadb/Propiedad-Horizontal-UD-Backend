package co.propiedad.horizontal.ud.service;

import co.propiedad.horizontal.ud.model.Responsable;
import co.propiedad.horizontal.ud.repository.ResponsableRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResponsableService {

    @Autowired
    private ResponsableRepository responsableRepository;

    public Responsable save(Responsable responsable){
        return responsableRepository.save(responsable);
    }

}
