/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     13/12/2022 5:35:06 p.m.                      */
/*==============================================================*/


alter table APARTAMENTO
   drop constraint FK_APARTAME_HAY_CONJUNTO;

alter table APARTAMENTO
   drop constraint FK_APARTAME_SE_HACE_C_RESPONSA;

alter table CUENTA_COBRO
   drop constraint FK_CUENTA_C_GENERA_APARTAME;

alter table DETALLE_POR
   drop constraint FK_DETALLE__DETALLE_P_CONCEPTO;

alter table DETALLE_POR
   drop constraint FK_DETALLE__DETALLE_P_CUENTA_C;

alter table PAGO
   drop constraint FK_PAGO_CONSIGNA_CUENTA_C;

alter table PARQUEADERO
   drop constraint FK_PARQUEAD_ASOCIA_APARTAME;

alter table RESERVA
   drop constraint FK_RESERVA_GESTIONA_ZONA_COM;

alter table RESERVA
   drop constraint FK_RESERVA_HACE_RESPONSA;

alter table RESIDENTE
   drop constraint FK_RESIDENT_RELA_4_PERSONA;

alter table RESIDENTE
   drop constraint FK_RESIDENT_VIVE_EN_APARTAME;

alter table RESPONSABLE
   drop constraint FK_RESPONSA_RELA_3_PERSONA;

alter table ZONA_COMUN
   drop constraint FK_ZONA_COM_TIENE_CONJUNTO;

drop index SE_HACE_CARGO_FK;

drop index HAY_FK;

drop table APARTAMENTO cascade constraints;

drop table CONCEPTO cascade constraints;

drop table CONJUNTO cascade constraints;

drop index GENERA_FK;

drop table CUENTA_COBRO cascade constraints;

drop index DETALLE_POR_FK;

drop index DETALLE_POR2_FK;

drop table DETALLE_POR cascade constraints;

drop index CONSIGNA_FK;

drop table PAGO cascade constraints;

drop index ASOCIA_FK;

drop table PARQUEADERO cascade constraints;

drop table PERSONA cascade constraints;

drop index GESTIONA_FK;

drop index HACE_FK;

drop table RESERVA cascade constraints;

drop index VIVE_EN_FK;

drop table RESIDENTE cascade constraints;

drop table RESPONSABLE cascade constraints;

drop index TIENE_FK;

drop table ZONA_COMUN cascade constraints;

/*==============================================================*/
/* Table: APARTAMENTO                                           */
/*==============================================================*/
create table APARTAMENTO 
(
   K_APARTAMENTO        NUMBER(5)            not null,
   FK_CONJUNTO_A        NUMBER               not null,
   FK_NUMERO_RESPONSABLE_A NUMBER(5),
   FK_TIPO_RESPONSABLE_A VARCHAR2(10),
   Q_TAMANIO_APARTAMENTO NUMBER(4)            not null,
   K_BLOQUE             NUMBER(5)            not null,
   constraint PK_APARTAMENTO primary key (K_APARTAMENTO)
);

/*==============================================================*/
/* Index: HAY_FK                                                */
/*==============================================================*/
create index HAY_FK on APARTAMENTO (
   FK_CONJUNTO_A ASC
);

/*==============================================================*/
/* Index: SE_HACE_CARGO_FK                                      */
/*==============================================================*/
create index SE_HACE_CARGO_FK on APARTAMENTO (
   FK_NUMERO_RESPONSABLE_A ASC,
   FK_TIPO_RESPONSABLE_A ASC
);

/*==============================================================*/
/* Table: CONCEPTO                                              */
/*==============================================================*/
create table CONCEPTO 
(
   K_CONCEPTO           NUMBER(5)            not null,
   N_NOMBRE_COMPLETO    VARCHAR2(15)         not null,
   DESC_CONCEPTO        VARCHAR2(30)         not null,
   constraint PK_CONCEPTO primary key (K_CONCEPTO)
);

/*==============================================================*/
/* Table: CONJUNTO                                              */
/*==============================================================*/
create table CONJUNTO 
(
   K_CONJUNTO           NUMBER               not null,
   N_NOMBRE_CONJUNTO    VARCHAR2(15)         not null,
   O_TELEFONO_CONJUNTO  NUMBER(7)            not null,
   O_DIRECCION_CONJUNTO VARCHAR2(15)         not null,
   DIA_OPORTUNO         DATE                 not null,
   V_MORA               NUMBER(3,2)          not null,
   ADMINISTRACION_BASE  NUMBER(4,3)          not null,
   Q_AREA_PRIVADA       NUMBER(3)            not null,
   DESCUENTO            NUMBER(3,2)          not null,
   constraint PK_CONJUNTO primary key (K_CONJUNTO)
);

/*==============================================================*/
/* Table: CUENTA_COBRO                                          */
/*==============================================================*/
create table CUENTA_COBRO 
(
   K_CUENTA_COBRO       NUMBER(5)            not null,
   FK_APARTAMENTO_C     NUMBER(5)            not null,
   F_FECHA_CUENTA       DATE                 not null,
   I_ESTADO_CUENTA      VARCHAR2(5)          not null,
   PERIODO_MES          NUMBER(2)            not null,
   PERIODO_ANO          NUMBER(4)            not null,
   constraint PK_CUENTA_COBRO primary key (K_CUENTA_COBRO)
);

/*==============================================================*/
/* Index: GENERA_FK                                             */
/*==============================================================*/
create index GENERA_FK on CUENTA_COBRO (
   FK_APARTAMENTO_C ASC
);

/*==============================================================*/
/* Table: DETALLE_POR                                           */
/*==============================================================*/
create table DETALLE_POR 
(
   FK_CONCEPTO          NUMBER(5)            not null,
   FK_CUENTA_COBRO_DP   NUMBER(5)            not null,
   constraint PK_DETALLE_POR primary key (FK_CONCEPTO, FK_CUENTA_COBRO_DP)
);

/*==============================================================*/
/* Index: DETALLE_POR2_FK                                       */
/*==============================================================*/
create index DETALLE_POR2_FK on DETALLE_POR (
   FK_CUENTA_COBRO_DP ASC
);

/*==============================================================*/
/* Index: DETALLE_POR_FK                                        */
/*==============================================================*/
create index DETALLE_POR_FK on DETALLE_POR (
   FK_CONCEPTO ASC
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO 
(
   K_PAGO               NUMBER(5)            not null,
   FK_CUENTA_COBRO_P    NUMBER(5)            not null,
   V_VALOR_PAGADO       NUMBER(8,2)          not null,
   F_FECHA_PAGO         DATE                 not null,
   F_FORMA_PAGO         VARCHAR2(2)          not null,
   constraint PK_PAGO primary key (K_PAGO)
);

/*==============================================================*/
/* Index: CONSIGNA_FK                                           */
/*==============================================================*/
create index CONSIGNA_FK on PAGO (
   FK_CUENTA_COBRO_P ASC
);

/*==============================================================*/
/* Table: PARQUEADERO                                           */
/*==============================================================*/
create table PARQUEADERO 
(
   K_PARQUEADERO        NUMBER(5)            not null,
   FK_APARTAMENTO_P     NUMBER(5),
   O_NUMERO             NUMBER(4)            not null,
   constraint PK_PARQUEADERO primary key (K_PARQUEADERO)
);

/*==============================================================*/
/* Index: ASOCIA_FK                                             */
/*==============================================================*/
create index ASOCIA_FK on PARQUEADERO (
   FK_APARTAMENTO_P ASC
);

/*==============================================================*/
/* Table: PERSONA                                               */
/*==============================================================*/
create table PERSONA 
(
   K_NUMERO             NUMBER(5)            not null,
   TIPO                 VARCHAR2(10)         not null,
   N_NOMBRE             VARCHAR2(15),
   N_APELLIDO           VARCHAR2(15),
   O_TELEFONO           NUMBER(10),
   I_GENERO             VARCHAR2(1),
   constraint PK_PERSONA primary key (K_NUMERO, TIPO)
);

/*==============================================================*/
/* Table: RESERVA                                               */
/*==============================================================*/
create table RESERVA 
(
   K_RESERVA            NUMBER(5)            not null,
   FK_ZONA_COMUN_R      NUMBER(5)            not null,
   FK_NUMERO_RESPONSABLE_RESERVA NUMBER(5)            not null,
   FK_TIPO_RESPONSABLE_RESERVA VARCHAR2(10)         not null,
   F_FECHA_RESERVA      DATE                 not null,
   F_FECHA_INCIAL       DATE                 not null,
   F_FECHA_FINAL        DATE                 not null,
   I_ESTADO             SMALLINT             not null,
   constraint PK_RESERVA primary key (K_RESERVA)
);

/*==============================================================*/
/* Index: HACE_FK                                               */
/*==============================================================*/
create index HACE_FK on RESERVA (
   FK_NUMERO_RESPONSABLE_RESERVA ASC,
   FK_TIPO_RESPONSABLE_RESERVA ASC
);

/*==============================================================*/
/* Index: GESTIONA_FK                                           */
/*==============================================================*/
create index GESTIONA_FK on RESERVA (
   FK_ZONA_COMUN_R ASC
);

/*==============================================================*/
/* Table: RESIDENTE                                             */
/*==============================================================*/
create table RESIDENTE 
(
   FK_NUMERO_RESIDENTE  NUMBER(5)            not null,
   FK_TIPO_RESIDENTE    VARCHAR2(10)         not null,
   FK_APARTAMENTO_R     NUMBER(5)            not null,
   constraint PK_RESIDENTE primary key (FK_NUMERO_RESIDENTE, FK_TIPO_RESIDENTE)
);

/*==============================================================*/
/* Index: VIVE_EN_FK                                            */
/*==============================================================*/
create index VIVE_EN_FK on RESIDENTE (
   FK_APARTAMENTO_R ASC
);

/*==============================================================*/
/* Table: RESPONSABLE                                           */
/*==============================================================*/
create table RESPONSABLE 
(
   FK_NUMERO_RESPONSABLE NUMBER(5)            not null,
   FK_TIPO_RESPONSABLE  VARCHAR2(10)         not null,
   O_EMAIL              VARCHAR2(50)         not null,
   ES_PROPIETARIO       SMALLINT             not null,
   O_TEL_TRABAJO        NUMBER(7)            not null,
   O_TEL_RESIDENCIA     NUMBER(7)            not null,
   constraint PK_RESPONSABLE primary key (FK_NUMERO_RESPONSABLE, FK_TIPO_RESPONSABLE)
);

/*==============================================================*/
/* Table: ZONA_COMUN                                            */
/*==============================================================*/
create table ZONA_COMUN 
(
   K_ZONA_COMUN         NUMBER(5)            not null,
   FK_CONJUNTO_ZC       NUMBER               not null,
   N_NOMBRE_ZONA_COMUN  VARCHAR2(15)         not null,
   DESC_TIPO_ZONA       VARCHAR2(30)         not null,
   HORA_ABRIERTO        DATE,
   HORA_CERRADO         DATE,
   I_ESTADO_MANTEMINIEMTO SMALLINT,
   V_COSTO_HORA         NUMBER(6,2),
   Q_AFORO              NUMBER(3),
   constraint PK_ZONA_COMUN primary key (K_ZONA_COMUN)
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create index TIENE_FK on ZONA_COMUN (
   FK_CONJUNTO_ZC ASC
);

alter table APARTAMENTO
   add constraint FK_APARTAME_HAY_CONJUNTO foreign key (FK_CONJUNTO_A)
      references CONJUNTO (K_CONJUNTO);

alter table APARTAMENTO
   add constraint FK_APARTAME_SE_HACE_C_RESPONSA foreign key (FK_NUMERO_RESPONSABLE_A, FK_TIPO_RESPONSABLE_A)
      references RESPONSABLE (FK_NUMERO_RESPONSABLE, FK_TIPO_RESPONSABLE);

alter table CUENTA_COBRO
   add constraint FK_CUENTA_C_GENERA_APARTAME foreign key (FK_APARTAMENTO_C)
      references APARTAMENTO (K_APARTAMENTO);

alter table DETALLE_POR
   add constraint FK_DETALLE__DETALLE_P_CONCEPTO foreign key (FK_CONCEPTO)
      references CONCEPTO (K_CONCEPTO);

alter table DETALLE_POR
   add constraint FK_DETALLE__DETALLE_P_CUENTA_C foreign key (FK_CUENTA_COBRO_DP)
      references CUENTA_COBRO (K_CUENTA_COBRO);

alter table PAGO
   add constraint FK_PAGO_CONSIGNA_CUENTA_C foreign key (FK_CUENTA_COBRO_P)
      references CUENTA_COBRO (K_CUENTA_COBRO);

alter table PARQUEADERO
   add constraint FK_PARQUEAD_ASOCIA_APARTAME foreign key (FK_APARTAMENTO_P)
      references APARTAMENTO (K_APARTAMENTO);

alter table RESERVA
   add constraint FK_RESERVA_GESTIONA_ZONA_COM foreign key (FK_ZONA_COMUN_R)
      references ZONA_COMUN (K_ZONA_COMUN);

alter table RESERVA
   add constraint FK_RESERVA_HACE_RESPONSA foreign key (FK_NUMERO_RESPONSABLE_RESERVA, FK_TIPO_RESPONSABLE_RESERVA)
      references RESPONSABLE (FK_NUMERO_RESPONSABLE, FK_TIPO_RESPONSABLE);

alter table RESIDENTE
   add constraint FK_RESIDENT_RELA_4_PERSONA foreign key (FK_NUMERO_RESIDENTE, FK_TIPO_RESIDENTE)
      references PERSONA (K_NUMERO, TIPO);

alter table RESIDENTE
   add constraint FK_RESIDENT_VIVE_EN_APARTAME foreign key (FK_APARTAMENTO_R)
      references APARTAMENTO (K_APARTAMENTO);

alter table RESPONSABLE
   add constraint FK_RESPONSA_RELA_3_PERSONA foreign key (FK_NUMERO_RESPONSABLE, FK_TIPO_RESPONSABLE)
      references PERSONA (K_NUMERO, TIPO);

alter table ZONA_COMUN
   add constraint FK_ZONA_COM_TIENE_CONJUNTO foreign key (FK_CONJUNTO_ZC)
      references CONJUNTO (K_CONJUNTO);

