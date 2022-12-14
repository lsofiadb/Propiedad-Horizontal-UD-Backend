package co.propiedad.horizontal.ud.repository;

import co.propiedad.horizontal.ud.model.Apartamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ApartamentoRepository extends JpaRepository<Apartamento, Long> {
}
