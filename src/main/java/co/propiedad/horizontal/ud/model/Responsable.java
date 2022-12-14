package co.propiedad.horizontal.ud.model;

import co.propiedad.horizontal.ud.model.pk.PersonaPK;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "responsable")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Responsable implements Serializable{

    @Id
    private Long FK_NUMERO_RESPONSABLE;
    @Id
    private Long FK_TIPO_RESPONSABLE;

    @Column(name = "O_EMAIL")
    private String O_EMAIL;

    @Column(name = "ES_PROPIETARIO")
    private Boolean ES_PROPIETARIO;

    @Column(name = "O_TEL_TRABAJO")
    private Long O_TEL_TRABAJO;

    @Column(name = "O_TEL_RESIDENCIA")
    private Long O_TEL_RESIDENCIA;

}