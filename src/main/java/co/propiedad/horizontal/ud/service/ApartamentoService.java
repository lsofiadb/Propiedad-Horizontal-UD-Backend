package co.propiedad.horizontal.ud.service;

import co.propiedad.horizontal.ud.model.Apartamento;
import co.propiedad.horizontal.ud.repository.ApartamentoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApartamentoService {

    @Autowired
    private ApartamentoRepository apartamentoRepository;

    public List<Apartamento> findAll(){
        return apartamentoRepository.findAll();
    }

    public Apartamento findById(Long id){
        return apartamentoRepository.findById(id).get();
    }

    public void updateResponsable(Long k_numero, String tipo, Long idApartamento){
        apartamentoRepository.updateResponsable(k_numero, tipo, idApartamento);
    }
}
