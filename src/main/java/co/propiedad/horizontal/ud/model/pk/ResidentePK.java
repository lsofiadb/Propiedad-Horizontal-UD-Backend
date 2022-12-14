package co.propiedad.horizontal.ud.model.pk;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResidentePK implements Serializable {

    private Long FK_NUMERO_RESIDENTE;

    private String FK_TIPO_RESIDENTE;

}
