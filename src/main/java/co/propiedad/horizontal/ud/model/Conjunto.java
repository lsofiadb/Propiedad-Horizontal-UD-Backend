package co.propiedad.horizontal.ud.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "conjunto")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Conjunto {

    @Id @Column(name = "K_CONJUNTO")
    private Long K_CONJUNTO;

    @Column(name = "N_NOMBRE_CONJUNTO")
    private String N_NOMBRE_CONJUNTO;

    @Column(name = "O_TELEFONO_CONJUNTO")
    private Long O_TELEFONO_CONJUNTO;

    @Column(name = "O_DIRECCION_CONJUNTO")
    private String O_DIRECCION_CONJUNTO;

    @Column(name = "DIA_OPORTUNO")
    private Date DIA_OPORTUNO;

    @Column(name = "V_MORA")
    private Long V_MORA;

    @Column(name = "ADMINISTRACION_BASE")
    private Double ADMINISTRACION_BASE;

    @Column(name = "Q_AREA_PRIVADA")
    private Long Q_AREA_PRIVADA;

    @Column(name = "DESCUENTO")
    private Double DESCUENTO;

}
