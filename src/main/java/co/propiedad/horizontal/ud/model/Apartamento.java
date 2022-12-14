package co.propiedad.horizontal.ud.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "apartamento")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Apartamento {

    @Id @Column(name = "K_APARTAMENTO")
    private Long K_APARTAMENTO;

    @ManyToOne @JoinColumn(name = "FK_CONJUNTO_A")
    private Conjunto conjunto;

    @Column(name = "FK_NUMERO_RESPONSABLE_A")
    private Long FK_NUMERO_RESPONSABLE_A;

    @Column(name = "FK_TIPO_RESPONSABLE_A")
    private String FK_TIPO_RESPONSABLE_A;

    @Column(name = "Q_TAMANIO_APARTAMENTO")
    private Long Q_TAMANIO_APARTAMENTO;

    @Column(name = "K_BLOQUE")
    private Long K_BLOQUE;

}
