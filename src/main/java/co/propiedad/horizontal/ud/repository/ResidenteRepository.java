package co.propiedad.horizontal.ud.repository;

import co.propiedad.horizontal.ud.model.Residente;
import co.propiedad.horizontal.ud.model.pk.ResidentePK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResidenteRepository  extends JpaRepository<Residente, ResidentePK>{
}
