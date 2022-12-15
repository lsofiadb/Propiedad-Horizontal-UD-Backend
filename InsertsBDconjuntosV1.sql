insert into conjunto values (1,'conjunto1',123,'micalle12',15,0.2,0.3,5,0.2);

insert into apartamento values (101,1,null,null,30,1);
insert into apartamento values (102,1,null,null,30,1);

insert into persona values (1,'cc','daniel','carreño',1326547,'M');
insert into persona values (2,'cc','laura','dueñas',6549871,'F');
insert into persona values (3,'cc','sebastian','wilches',741852,'M');
insert into persona values (4,'cc','camilo','merino',951753,'M');
insert into persona values (5,'cc','sofia','bulla',46325,'F');
insert into persona values (6,'cc','jhoan','jimenez',4654987,'M');

insert into responsable values(1,'cc','correo1',1,7511,78985);
insert into responsable values(4,'cc','correo2',1,7896,25657);

insert into residente values(2,'cc',101);
insert into residente values(3,'cc',101);
insert into residente values(5,'cc',102);
insert into residente values(6,'cc',102);

insert into zona_comun values( 1,1,'salon','salon comunal',TO_DATE('00:12','HH24:MI'), TO_DATE('00:13','HH24:MI'),0,50,20  );
insert into zona_comun values( 2,1,'piscina','piscina privada',TO_DATE('00:12','HH24:MI'), TO_DATE('00:13','HH24:MI'),1,20,10  );


insert into parqueadero values(1,101,1);
insert into parqueadero values(2,102,2);

insert into cuenta_cobro values(1,101,'5/5/2022',1,2,2022 );
insert into cuenta_cobro values(2,102,'3/3/2022',0,3,2022 );

INSERT INTO reserva VALUES (1,1,1,'cc','1/1/2022','2/2/2022','3/3/2022',0);
INSERT INTO reserva VALUES (2,1,4,'cc','10/1/2022','12/1/2022','13/1/2022',1);

insert into pago values(1,1,600000,'3/3/2022','E' );
insert into pago values(2,2,600000,'6/5/2022','C' );

insert into concepto values(1,'alquiler','alquiler salon comunal');
insert into concepto values(2,'cuota ex','cuota extraordinaria');
insert into concepto values(3,'administracion','cuota administracion');

insert into detalle_por values(3,1);
insert into detalle_por values(3,2);


