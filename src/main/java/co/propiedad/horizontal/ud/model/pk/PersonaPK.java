package co.propiedad.horizontal.ud.model.pk;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class PersonaPK implements Serializable {

    private Long K_NUMERO;

    private String TIPO;

}
