package co.propiedad.horizontal.ud.repository;

import co.propiedad.horizontal.ud.model.Responsable;
import co.propiedad.horizontal.ud.model.pk.ResponsablePK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResponsableRepository extends JpaRepository<Responsable, ResponsablePK> {
}
