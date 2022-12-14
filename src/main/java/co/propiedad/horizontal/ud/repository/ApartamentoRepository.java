package co.propiedad.horizontal.ud.repository;

import co.propiedad.horizontal.ud.model.Apartamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ApartamentoRepository extends JpaRepository<Apartamento, Long> {
    @Query(value = "UPDATE APARTAMENTO SET APARTAMENTO.FK_NUMERO_RESPONSABLE_A = ?1, APARTAMENTO.FK_TIPO_RESPONSABLE_A = ?2 WHERE APARTAMENTO.K_APARTAMENTO = ?3", nativeQuery = true)
    void updateResponsable(Long k_numero, String tipo, Long idApartamento);
}
