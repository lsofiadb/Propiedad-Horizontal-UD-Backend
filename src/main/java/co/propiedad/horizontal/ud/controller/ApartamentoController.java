package co.propiedad.horizontal.ud.controller;

import co.propiedad.horizontal.ud.model.Apartamento;
import co.propiedad.horizontal.ud.service.ApartamentoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/apartamento")
public class ApartamentoController {

    @Autowired
    private ApartamentoService apartamentoService;

    @GetMapping("/findAll")
    public List<Apartamento> findAll(){
        return apartamentoService.findAll();
    }
}
