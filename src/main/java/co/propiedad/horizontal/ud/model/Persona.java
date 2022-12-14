package co.propiedad.horizontal.ud.model;

import co.propiedad.horizontal.ud.model.pk.PersonaPK;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "persona")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Persona {

    @EmbeddedId
    private PersonaPK personaPK;

    @Column(name = "N_NOMBRE")
    private String N_NOMBRE;

    @Column(name = "N_APELLIDO")
    private String N_APELLIDO;

    @Column(name = "O_TELEFONO")
    private Long O_TELEFONO;

    @Column(name = "I_GENERO")
    private String I_GENERO;

}