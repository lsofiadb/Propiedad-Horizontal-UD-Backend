package co.propiedad.horizontal.ud.repository;

import co.propiedad.horizontal.ud.model.Persona;
import co.propiedad.horizontal.ud.model.pk.PersonaPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonaRepository extends JpaRepository<Persona, PersonaPK> {
}
