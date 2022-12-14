package co.propiedad.horizontal.ud.service;

import co.propiedad.horizontal.ud.model.Residente;
import co.propiedad.horizontal.ud.repository.ResidenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResidenteService {

    @Autowired
    private ResidenteRepository residenteRepository;

    public Residente save(Residente residente){
        return residenteRepository.save(residente);
    }

}
