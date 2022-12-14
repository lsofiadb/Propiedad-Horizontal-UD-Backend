package co.propiedad.horizontal.ud.model;

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

    @Id
    private Long FK_NUMERO_RESIDENTE;
    @Id
    private Long FK_TIPO_RESIDENTE;

    @ManyToOne @JoinColumn(name = "FK_APARTAMENTO_R")
    private Apartamento apartamento;

}
