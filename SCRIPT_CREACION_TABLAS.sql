/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     19-10-2017 1:06:36                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CAMION') and o.name = 'FK_CAMION_REFERENCE_USUARIO')
alter table CAMION
   drop constraint FK_CAMION_REFERENCE_USUARIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DIRECCION') and o.name = 'FK_DIRECCIO_SEC_DIREC_SECTOR')
alter table DIRECCION
   drop constraint FK_DIRECCIO_SEC_DIREC_SECTOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDEN') and o.name = 'FK_ORDEN_DIR1_ORD_DIRECCIO')
alter table ORDEN
   drop constraint FK_ORDEN_DIR1_ORD_DIRECCIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDEN') and o.name = 'FK_ORDEN_DIR2_ORD_DIRECCIO')
alter table ORDEN
   drop constraint FK_ORDEN_DIR2_ORD_DIRECCIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDEN') and o.name = 'FK_ORDEN_REL_CAM_O_CAMION')
alter table ORDEN
   drop constraint FK_ORDEN_REL_CAM_O_CAMION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDEN') and o.name = 'FK_ORDEN_USU_ORD_USUARIO')
alter table ORDEN
   drop constraint FK_ORDEN_USU_ORD_USUARIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USUARIO') and o.name = 'FK_USUARIO_REFERENCE_DIRECCIO')
alter table USUARIO
   drop constraint FK_USUARIO_REFERENCE_DIRECCIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USU_ROL') and o.name = 'FK_USU_ROL_USU_ROL_ROL')
alter table USU_ROL
   drop constraint FK_USU_ROL_USU_ROL_ROL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USU_ROL') and o.name = 'FK_USU_ROL_USU_ROL2_USUARIO')
alter table USU_ROL
   drop constraint FK_USU_ROL_USU_ROL2_USUARIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CAMION')
            and   type = 'U')
   drop table CAMION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DIRECCION')
            and   name  = 'SEC_DIREC_FK'
            and   indid > 0
            and   indid < 255)
   drop index DIRECCION.SEC_DIREC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIRECCION')
            and   type = 'U')
   drop table DIRECCION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDEN')
            and   name  = 'REL_CAM_ORD_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDEN.REL_CAM_ORD_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ORDEN')
            and   type = 'U')
   drop table ORDEN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ROL')
            and   type = 'U')
   drop table ROL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SECTOR')
            and   type = 'U')
   drop table SECTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USUARIO')
            and   type = 'U')
   drop table USUARIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USU_ROL')
            and   name  = 'USU_ROL_FK'
            and   indid > 0
            and   indid < 255)
   drop index USU_ROL.USU_ROL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USU_ROL')
            and   type = 'U')
   drop table USU_ROL
go

/*==============================================================*/
/* Table: CAMION                                                */
/*==============================================================*/
create table CAMION (
   PATENTE_CAMION       varchar(20)          not null,
   ID_USUARIO_RESPONSABLE int                  null,
   PESO_MAXIMO          int                  null,
   constraint PK_CAMION primary key (PATENTE_CAMION)
)
go

/*==============================================================*/
/* Table: DIRECCION                                             */
/*==============================================================*/
create table DIRECCION (
   ID_DIRECCION         int                  not null,
   ID_SECTOR            int                  null,
   NOMBRE_CALLE         varchar(200)         not null,
   NUMERO_CALLE         int                  null,
   ID_SECTOR_CALLE      int                  null,
   constraint PK_DIRECCION primary key (ID_DIRECCION)
)
go

/*==============================================================*/
/* Index: SEC_DIREC_FK                                          */
/*==============================================================*/




create nonclustered index SEC_DIREC_FK on DIRECCION (ID_SECTOR ASC)
go

/*==============================================================*/
/* Table: ORDEN                                                 */
/*==============================================================*/
create table ORDEN (
   ID_ORDEN             int                  not null,
   FECHA_SOLICITUD      datetime             not null,
   ID_USUARIO           int                  not null,
   ID_DIRECCION_1       int                  not null,
   ID_DIRECCION_2       int                  null,
   OBSERVACIONES        varchar(2000)        null,
   UBICACION_FOTO       varchar(5000)        null,
   FECHA_VISITA         datetime             null,
   PATENTE_CAMION       varchar(20)          null,
   PESO_ESTIMADO        int                  null,
   MONTO_PAGADO         int                  null,
   METODO_PAGO          varchar(200)         null,
   DESCUENTO            bit                  null,
   COMENTARIO_DESCUENTO varchar(2000)        null,
   OPERADOR             varchar(500)         null,
   constraint PK_ORDEN primary key (ID_ORDEN)
)
go

/*==============================================================*/
/* Index: REL_CAM_ORD_FK                                        */
/*==============================================================*/




create nonclustered index REL_CAM_ORD_FK on ORDEN (PATENTE_CAMION ASC)
go

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   ID_ROL               int                  not null,
   DESCRIPCION_ROL      varchar(50)          null,
   constraint PK_ROL primary key (ID_ROL)
)
go

/*==============================================================*/
/* Table: SECTOR                                                */
/*==============================================================*/
create table SECTOR (
   ID_SECTOR            int                  not null,
   NOMBRE_SECTOR        varchar(100)         not null,
   constraint PK_SECTOR primary key (ID_SECTOR)
)
go

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   ID_USUARIO           int                  identity,
   ID_DIRECCION         int                  null,
   RUT                  int                  not null,
   DV_RUT               varchar(1)           not null,
   NOMBRES              varchar(1024)        not null,
   APELLIDOS            varchar(1024)        not null,
   CORREO_ELECTRONICO   varchar(1024)        not null,
   CLAVE                varchar(1024)        not null,
   TELEFONO_FIJO        int                  null,
   TELEFONO_MOVIL       int                  null,
   constraint PK_USUARIO primary key (ID_USUARIO)
)
go

/*==============================================================*/
/* Table: USU_ROL                                               */
/*==============================================================*/
create table USU_ROL (
   ID_USUARIO           int                  null,
   ID_ROL               int                  null
)
go

/*==============================================================*/
/* Index: USU_ROL_FK                                            */
/*==============================================================*/




create nonclustered index USU_ROL_FK on USU_ROL (ID_ROL ASC)
go

alter table CAMION
   add constraint FK_CAMION_REFERENCE_USUARIO foreign key (ID_USUARIO_RESPONSABLE)
      references USUARIO (ID_USUARIO)
go

alter table DIRECCION
   add constraint FK_DIRECCIO_SEC_DIREC_SECTOR foreign key (ID_SECTOR)
      references SECTOR (ID_SECTOR)
go

alter table ORDEN
   add constraint FK_ORDEN_DIR1_ORD_DIRECCIO foreign key (ID_DIRECCION_1)
      references DIRECCION (ID_DIRECCION)
go

alter table ORDEN
   add constraint FK_ORDEN_DIR2_ORD_DIRECCIO foreign key (ID_DIRECCION_2)
      references DIRECCION (ID_DIRECCION)
go

alter table ORDEN
   add constraint FK_ORDEN_REL_CAM_O_CAMION foreign key (PATENTE_CAMION)
      references CAMION (PATENTE_CAMION)
go

alter table ORDEN
   add constraint FK_ORDEN_USU_ORD_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
go

alter table USUARIO
   add constraint FK_USUARIO_REFERENCE_DIRECCIO foreign key (ID_DIRECCION)
      references DIRECCION (ID_DIRECCION)
go

alter table USU_ROL
   add constraint FK_USU_ROL_USU_ROL_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
go

alter table USU_ROL
   add constraint FK_USU_ROL_USU_ROL2_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
go

