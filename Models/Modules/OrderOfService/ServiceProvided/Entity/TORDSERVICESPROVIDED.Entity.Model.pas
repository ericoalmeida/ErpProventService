unit TORDSERVICESPROVIDED.Entity.Model;

interface

uses
  DB,
  Classes,
  SysUtils,
  Generics.Collections,

  /// orm
  TASSVEHICLE.Entity.Model,
  TORDSERVICE.Entity.Model,
  TMNGPERSON.Entity.Model,
  TORDOPERATOR.Entity.Model,
  TMNGCOMPANY.Entity.Model,
  TMNGUSER.Entity.Model,
  ormbr.types.blob,
  ormbr.types.lazy,
  ormbr.types.mapping,
  ormbr.types.nullable,
  ormbr.mapping.classes,
  ormbr.mapping.register,
  ormbr.mapping.attributes;

type
  [Entity]
  [Table('TORDSERVICESPROVIDED', '')]
  [PrimaryKey('COMPANYID, CODE', NotInc, NoSort, False, 'Chave primária')]
  TTORDSERVICESPROVIDED = class
  private
    { Private declarations }
    FCOMPANYID: String;
    FCODE: String;
    FSERVICEPROVIDEDID: Integer;
    FPROVIDEDAT: TDateTime;
    FCLIENTID: String;
    FOPERATORID: String;
    FMACHINEID: String;
    FSERVICEID: String;
    FTOTALKM: Nullable<Double>;
    FTOTALHOURS: Nullable<Integer>;
    FTOTAL: Double;
    FSTATUS: Integer;
    FUSERID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTASSVEHICLE_0:  TTASSVEHICLE  ;
    FTMNGCOMPANY_1:  TTMNGCOMPANY  ;
    FTMNGPERSON_2:  TTMNGPERSON  ;
    FTMNGUSER_3:  TTMNGUSER  ;
    FTORDOPERATOR_4:  TTORDOPERATOR  ;
    FTORDSERVICE_5:  TTORDSERVICE  ;
    function GETCODE: String;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('COMPANYID', ftString, 64)]
    [ForeignKey('FK0_TORDSERVICESPROVIDED', 'COMPANYID', 'TMNGCOMPANY', 'CODE', SetNull, SetNull)]
    [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COMPANYID: String read FCOMPANYID write FCOMPANYID;

    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE: String read GETCODE write FCODE;

    [Restrictions([NotNull])]
    [Column('SERVICEPROVIDEDID', ftInteger)]
    [Dictionary('SERVICEPROVIDEDID', 'Mensagem de validação', '', '', '', taCenter)]
    property SERVICEPROVIDEDID: Integer read FSERVICEPROVIDEDID write FSERVICEPROVIDEDID;

    [Restrictions([NotNull])]
    [Column('PROVIDEDAT', ftDateTime)]
    [Dictionary('PROVIDEDAT', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PROVIDEDAT: TDateTime read FPROVIDEDAT write FPROVIDEDAT;

    [Restrictions([NotNull])]
    [Column('CLIENTID', ftString, 64)]
    [ForeignKey('FK1_TORDSERVICESPROVIDED', 'COMPANYID, CLIENTID', 'TMNGPERSON', 'COMPANYID, CODE', SetNull, SetNull)]
    [Dictionary('CLIENTID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLIENTID: String read FCLIENTID write FCLIENTID;

    [Restrictions([NotNull])]
    [Column('OPERATORID', ftString, 64)]
    [ForeignKey('FK2_TORDSERVICESPROVIDED', 'COMPANYID, OPERATORID', 'TORDOPERATOR', 'COMPANYID, CODE', SetNull, SetNull)]
    [Dictionary('OPERATORID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OPERATORID: String read FOPERATORID write FOPERATORID;

    [Restrictions([NotNull])]
    [Column('MACHINEID', ftString, 64)]
    [ForeignKey('FK3_TORDSERVICESPROVIDED', 'COMPANYID, MACHINEID', 'TASSVEHICLE', 'COMPANYID, CODE', SetNull, SetNull)]
    [Dictionary('MACHINEID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MACHINEID: String read FMACHINEID write FMACHINEID;

    [Restrictions([NotNull])]
    [Column('SERVICEID', ftString, 64)]
    [ForeignKey('FK4_TORDSERVICESPROVIDED', 'COMPANYID, SERVICEID', 'TORDSERVICE', 'COMPANYID, CODE', SetNull, SetNull)]
    [Dictionary('SERVICEID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SERVICEID: String read FSERVICEID write FSERVICEID;

    [Column('TOTALKM', ftBCD)]
    [Dictionary('TOTALKM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOTALKM: Nullable<Double> read FTOTALKM write FTOTALKM;

    [Column('TOTALHOURS', ftInteger)]
    [Dictionary('TOTALHOURS', 'Mensagem de validação', '', '', '', taCenter)]
    property TOTALHOURS: Nullable<Integer> read FTOTALHOURS write FTOTALHOURS;

    [Restrictions([NotNull])]
    [Column('TOTAL', ftBCD)]
    [Dictionary('TOTAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOTAL: Double read FTOTAL write FTOTAL;

    [Restrictions([NotNull])]
    [Column('STATUS', ftInteger)]
    [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taCenter)]
    property STATUS: Integer read FSTATUS write FSTATUS;

    [Restrictions([NotNull])]
    [Column('USERID', ftString, 64)]
    [ForeignKey('FK5_TORDSERVICESPROVIDED', 'USERID', 'TMNGUSER', 'CODE', SetNull, SetNull)]
    [Dictionary('USERID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERID: String read FUSERID write FUSERID;

    [Restrictions([NotNull])]
    [Column('CREATEDAT', ftDateTime)]
    [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

    [Restrictions([NotNull])]
    [Column('UPDATEDAT', ftDateTime)]
    [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;

    [Association(OneToOne,'COMPANYID, MACHINEID','TASSVEHICLE','COMPANYID, CODE')]
    property TASSVEHICLE: TTASSVEHICLE read FTASSVEHICLE_0 write FTASSVEHICLE_0;

    [Association(OneToOne,'COMPANYID','TMNGCOMPANY','CODE')]
    property TMNGCOMPANY: TTMNGCOMPANY read FTMNGCOMPANY_1 write FTMNGCOMPANY_1;

    [Association(OneToOne,'COMPANYID, CLIENTID','TMNGPERSON','COMPANYID, CODE')]
    property TMNGPERSON: TTMNGPERSON read FTMNGPERSON_2 write FTMNGPERSON_2;

    [Association(OneToOne,'USERID','TMNGUSER','CODE')]
    property TMNGUSER: TTMNGUSER read FTMNGUSER_3 write FTMNGUSER_3;

    [Association(OneToOne,'COMPANYID, OPERATORID','TORDOPERATOR','COMPANYID, CODE')]
    property TORDOPERATOR: TTORDOPERATOR read FTORDOPERATOR_4 write FTORDOPERATOR_4;

    [Association(OneToOne,'COMPANYID, SERVICEID','TORDSERVICE','COMPANYID, CODE')]
    property TORDSERVICE: TTORDSERVICE read FTORDSERVICE_5 write FTORDSERVICE_5;

  end;

implementation

constructor TTORDSERVICESPROVIDED.Create;
begin
  FTASSVEHICLE_0 := TTASSVEHICLE.Create;
  FTMNGCOMPANY_1 := TTMNGCOMPANY.Create;
  FTMNGPERSON_2 := TTMNGPERSON.Create;
  FTMNGUSER_3 := TTMNGUSER.Create;
  FTORDOPERATOR_4 := TTORDOPERATOR.Create;
  FTORDSERVICE_5 := TTORDSERVICE.Create;
end;

destructor TTORDSERVICESPROVIDED.Destroy;
begin
  if Assigned(FTASSVEHICLE_0) then
    FTASSVEHICLE_0.Free;

  if Assigned(FTMNGCOMPANY_1) then
    FTMNGCOMPANY_1.Free;

  if Assigned(FTMNGPERSON_2) then
    FTMNGPERSON_2.Free;

  if Assigned(FTMNGUSER_3) then
    FTMNGUSER_3.Free;

  if Assigned(FTORDOPERATOR_4) then
    FTORDOPERATOR_4.Free;

  if Assigned(FTORDSERVICE_5) then
    FTORDSERVICE_5.Free;

  inherited;
end;

function TTORDSERVICESPROVIDED.GETCODE: String;
begin
  if FCODE.IsEmpty then
  FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTORDSERVICESPROVIDED)

end.


