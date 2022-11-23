/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     22/11/2022 0:44:19                           */
/*==============================================================*/


drop index RELATIONSHIP_5_FK;

drop index AYUDA_SOCIAL_PK;

drop table AYUDA_SOCIAL;

drop index RELATIONSHIP_4_FK;

drop index RELATIONSHIP_2_FK;

drop index RELATIONSHIP_1_FK;

drop index FICHA_EXTRANJERO_PK;

drop table FICHA_EXTRANJERO;

drop index RELATIONSHIP_3_FK;

drop index INGRESO_PK;

drop table INGRESO;

drop index INMIGRANTE_PK;

drop table INMIGRANTE;

drop index OFICINA_MIGRACION_PK;

drop table OFICINA_MIGRACION;

drop index PERSONAL_PK;

drop table PERSONAL;

/*==============================================================*/
/* Table: AYUDA_SOCIAL                                          */
/*==============================================================*/
create table AYUDA_SOCIAL (
   ID_AYUDA_SOCIAL      SERIAL               not null,
   ID_FICHA             DECIMAL(7)           not null,
   FECHA_ORDEN_PAGO     DATE                 null,
   METODO_PAGO          VARCHAR(30)          null,
   MONTO_PAGO           DECIMAL(7,2)         null,
   constraint PK_AYUDA_SOCIAL primary key (ID_AYUDA_SOCIAL)
);

/*==============================================================*/
/* Index: AYUDA_SOCIAL_PK                                       */
/*==============================================================*/
create unique index AYUDA_SOCIAL_PK on AYUDA_SOCIAL (
ID_AYUDA_SOCIAL
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_5_FK on AYUDA_SOCIAL (
ID_FICHA
);

/*==============================================================*/
/* Table: FICHA_EXTRANJERO                                      */
/*==============================================================*/
create table FICHA_EXTRANJERO (
   ID_FICHA             DECIMAL(7)           not null,
   ID_PERSONAL          INT4                 not null,
   ID_OFICINA           INT4                 not null,
   ID_INMIGRANTE        INT4                 null,
   MOTIVO_SALIDA        VARCHAR(50)          null,
   OBJETIVO_ARRIBO      VARCHAR(50)          null,
   SITUACION_ECONOMICA  VARCHAR(20)          null,
   FECHA_TRAMITE        DATE                 null,
   constraint PK_FICHA_EXTRANJERO primary key (ID_FICHA)
);

/*==============================================================*/
/* Index: FICHA_EXTRANJERO_PK                                   */
/*==============================================================*/
create unique index FICHA_EXTRANJERO_PK on FICHA_EXTRANJERO (
ID_FICHA
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_1_FK on FICHA_EXTRANJERO (
ID_PERSONAL
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_2_FK on FICHA_EXTRANJERO (
ID_OFICINA
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_4_FK on FICHA_EXTRANJERO (
ID_INMIGRANTE
);

/*==============================================================*/
/* Table: INGRESO                                               */
/*==============================================================*/
create table INGRESO (
   ID_INGRESO           SERIAL               not null,
   ID_INMIGRANTE        INT4                 not null,
   FECHA_INGRESO        DATE                 null,
   FECHA_SALIDA_ORIGEN  DATE                 null,
   MEDIO_INGRESO        VARCHAR(30)          null,
   UNIDAD_CONTROL       VARCHAR(30)          null,
   CIUDAD_RESIDENCIA_ACTUAL VARCHAR(40)          null,
   TIEMPO_ESTADIA       DATE                 null,
   constraint PK_INGRESO primary key (ID_INGRESO)
);

/*==============================================================*/
/* Index: INGRESO_PK                                            */
/*==============================================================*/
create unique index INGRESO_PK on INGRESO (
ID_INGRESO
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_3_FK on INGRESO (
ID_INMIGRANTE
);

/*==============================================================*/
/* Table: INMIGRANTE                                            */
/*==============================================================*/
create table INMIGRANTE (
   ID_INMIGRANTE        SERIAL               not null,
   NOMBRE_INMIGRANTE    VARCHAR(60)          null,
   APELLIDO_INMIGRANTE  VARCHAR(60)          null,
   FECHA_NACIMIENTO_INMIGRANTE DATE                 null,
   NUMERO_PASAPORTE     VARCHAR(20)          null,
   PAIS_ORIGEN          VARCHAR(30)          null,
   TIPO_DNI             VARCHAR(30)          null,
   NUMERO_DNI           VARCHAR(20)          null,
   SEXO                 VARCHAR(1)           null,
   PROFESION            VARCHAR(30)          null,
   constraint PK_INMIGRANTE primary key (ID_INMIGRANTE)
);

/*==============================================================*/
/* Index: INMIGRANTE_PK                                         */
/*==============================================================*/
create unique index INMIGRANTE_PK on INMIGRANTE (
ID_INMIGRANTE
);

/*==============================================================*/
/* Table: OFICINA_MIGRACION                                     */
/*==============================================================*/
create table OFICINA_MIGRACION (
   ID_OFICINA           SERIAL               not null,
   PROVINCIA_OFICINA    VARCHAR(30)          null,
   CIUDAD_OFICINA       VARCHAR(30)          null,
   DIRECCION_OFICINA    VARCHAR(100)         null,
   constraint PK_OFICINA_MIGRACION primary key (ID_OFICINA)
);

/*==============================================================*/
/* Index: OFICINA_MIGRACION_PK                                  */
/*==============================================================*/
create unique index OFICINA_MIGRACION_PK on OFICINA_MIGRACION (
ID_OFICINA
);

/*==============================================================*/
/* Table: PERSONAL                                              */
/*==============================================================*/
create table PERSONAL (
   ID_PERSONAL          SERIAL               not null,
   NOMBRE_PERSONAL      VARCHAR(60)          null,
   APELLIDO_PERSONAL    VARCHAR(60)          null,
   TIPO_DOCUMENTO       VARCHAR(20)          null,
   NUMERO_DOCUMENTO     VARCHAR(20)          null,
   constraint PK_PERSONAL primary key (ID_PERSONAL)
);

/*==============================================================*/
/* Index: PERSONAL_PK                                           */
/*==============================================================*/
create unique index PERSONAL_PK on PERSONAL (
ID_PERSONAL
);

alter table AYUDA_SOCIAL
   add constraint FK_AYUDA_SO_RELATIONS_FICHA_EX foreign key (ID_FICHA)
      references FICHA_EXTRANJERO (ID_FICHA)
      on delete restrict on update restrict;

alter table FICHA_EXTRANJERO
   add constraint FK_FICHA_EX_RELATIONS_PERSONAL foreign key (ID_PERSONAL)
      references PERSONAL (ID_PERSONAL)
      on delete restrict on update restrict;

alter table FICHA_EXTRANJERO
   add constraint FK_FICHA_EX_RELATIONS_OFICINA_ foreign key (ID_OFICINA)
      references OFICINA_MIGRACION (ID_OFICINA)
      on delete restrict on update restrict;

alter table FICHA_EXTRANJERO
   add constraint FK_FICHA_EX_RELATIONS_INMIGRAN foreign key (ID_INMIGRANTE)
      references INMIGRANTE (ID_INMIGRANTE)
      on delete restrict on update restrict;

alter table INGRESO
   add constraint FK_INGRESO_RELATIONS_INMIGRAN foreign key (ID_INMIGRANTE)
      references INMIGRANTE (ID_INMIGRANTE)
      on delete restrict on update restrict;

