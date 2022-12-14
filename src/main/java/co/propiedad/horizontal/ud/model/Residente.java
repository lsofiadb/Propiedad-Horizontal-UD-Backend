package co.propiedad.horizontal.ud.model;

import co.propiedad.horizontal.ud.model.pk.ResidentePK;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "residente")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Residente implements Serializable {

    @EmbeddedId
    private ResidentePK residentePK;

    @ManyToOne @JoinColumn(name = "FK_APARTAMENTO_R")
    private Apartamento apartamento;

}
