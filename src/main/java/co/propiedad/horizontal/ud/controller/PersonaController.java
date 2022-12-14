package co.propiedad.horizontal.ud.controller;

import co.propiedad.horizontal.ud.model.Apartamento;
import co.propiedad.horizontal.ud.model.Persona;
import co.propiedad.horizontal.ud.model.Residente;
import co.propiedad.horizontal.ud.model.Responsable;
import co.propiedad.horizontal.ud.model.pk.PersonaPK;
import co.propiedad.horizontal.ud.model.pk.ResidentePK;
import co.propiedad.horizontal.ud.model.pk.ResponsablePK;
import co.propiedad.horizontal.ud.service.ApartamentoService;
import co.propiedad.horizontal.ud.service.PersonaService;
import co.propiedad.horizontal.ud.service.ResidenteService;
import co.propiedad.horizontal.ud.service.ResponsableService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/persona")
public class PersonaController {

    @Autowired
    private PersonaService personaService;

    @Autowired
    private ResidenteService residenteService;

    @Autowired
    private ResponsableService responsableService;

    @Autowired
    private ApartamentoService apartamentoService;

    @PostMapping("/save_persona_responsable")
    public Responsable saveResponsable(@RequestBody String data){

        //primero se guarda la persona...
        System.out.println("DATA");
        System.out.println(data);
        JSONObject jsonObject = new JSONObject(data);

        JSONObject personaJSON = jsonObject.getJSONObject("persona");
        System.out.println("persona");
        System.out.println(personaJSON);

        Persona persona = new Persona();
        PersonaPK personaPK = new PersonaPK();
        personaPK.setK_NUMERO(personaJSON.getLong("k_numero"));
        personaPK.setTIPO(personaJSON.getString("tipo"));
        persona.setPersonaPK(personaPK);
        persona.setN_NOMBRE(personaJSON.getString("n_nombre"));
        persona.setN_APELLIDO(personaJSON.getString("n_apellido"));
        persona.setO_TELEFONO(personaJSON.getLong("o_telefono"));
        persona.setI_GENERO(personaJSON.getString("i_genero"));

        personaService.save(persona);

        //luego se guarda el responsable...

        JSONObject responsableJSON = jsonObject.getJSONObject("responsable");
        Responsable responsable = new Responsable();
        ResponsablePK responsablePK = new ResponsablePK();
        responsablePK.setFK_NUMERO_RESPONSABLE(personaPK.getK_NUMERO());
        responsablePK.setFK_TIPO_RESPONSABLE(personaPK.getTIPO());
        responsable.setResponsablePK(responsablePK);
        responsable.setO_EMAIL(responsableJSON.getString("o_email"));
        responsable.setES_PROPIETARIO(responsableJSON.getBoolean("es_propietario"));
        responsable.setO_TEL_TRABAJO(responsableJSON.getLong("o_tel_trabajo"));
        responsable.setO_TEL_RESIDENCIA(responsableJSON.getLong("o_tel_residencia"));

        responsableService.save(responsable);

        //luego se hace el update a apartamento...
        Long idApartamento = jsonObject.getLong("apartamento");
        apartamentoService.updateResponsable(responsablePK.getFK_NUMERO_RESPONSABLE(), responsablePK.getFK_TIPO_RESPONSABLE(), idApartamento);

        return responsable;
    }

    @PostMapping("/save_persona_residente") //lista de residentes de un apartamento
    public Boolean savePersona(@RequestBody String data){

        //primero se guarda la persona...
        System.out.println("DATA");
        System.out.println(data);
        JSONObject jsonObject = new JSONObject(data);

        JSONArray personaJSONArray = jsonObject.getJSONArray("residentes");
        System.out.println("persona");
        System.out.println(personaJSONArray);

        for(int i = 0; i<personaJSONArray.length(); i++) {
            //crear la persona
            System.out.println("creando persona...");
            Persona persona = new Persona();
            Long k_numero = personaJSONArray.getJSONObject(i).getLong("k_numero");
            String tipo = personaJSONArray.getJSONObject(i).getString("tipo");
            PersonaPK personaPK = new PersonaPK();
            personaPK.setK_NUMERO(k_numero);
            personaPK.setTIPO(tipo);
            persona.setPersonaPK(personaPK);
            persona.setN_NOMBRE(personaJSONArray.getJSONObject(i).getString("n_nombre"));
            persona.setN_APELLIDO(personaJSONArray.getJSONObject(i).getString("n_apellido"));
            persona.setO_TELEFONO(personaJSONArray.getJSONObject(i).getLong("o_telefono"));
            persona.setI_GENERO(personaJSONArray.getJSONObject(i).getString("i_genero"));
            personaService.save(persona);
            System.out.println("creando residente...");
            //luego crear el residente
            Residente residente = new Residente();
            residente.setApartamento(apartamentoService.findById(jsonObject.getLong("k_apartamento")));
            ResidentePK residentePK = new ResidentePK();
            residentePK.setFK_NUMERO_RESIDENTE(k_numero);
            residentePK.setFK_TIPO_RESIDENTE(tipo);
            residente.setResidentePK(residentePK);
            residenteService.save(residente);
        }
        return true;
    }

}
