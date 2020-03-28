unit TORDSERVICE.Entity.Model;

interface

uses
  DB,
  Classes,
  SysUtils,
  Generics.Collections,

  /// orm
  ormbr.types.blob,
  ormbr.types.lazy,
  ormbr.types.mapping,
  ormbr.types.nullable,
  ormbr.mapping.classes,
  ormbr.mapping.register,
  ormbr.mapping.attributes,
  TMNGCOMPANY.Entity.Model,
  TMNGUSER.Entity.Model;

type
  [Entity]
  [Table('TORDSERVICE', '')]
  [PrimaryKey('COMPANYID, CODE', NotInc, NoSort, False, 'Chave primária')]
  TTORDSERVICE = class
  private
    { Private declarations }
    FCOMPANYID: String;
    FCODE: String;
    FSERVICEID: Integer;
    FDESCRIPTION: String;
    FPAYMENTTYPE: Integer;
    FPRICE: Double;
    FSTATUS: Integer;
    FUSERID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGCOMPANY_0:  TTMNGCOMPANY  ;
    FTMNGUSER_1:  TTMNGUSER  ;
    function GETCODE: String;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('COMPANYID', ftString, 64)]
    [ForeignKey('FK1_TORDSERVICE', 'COMPANYID', 'TMNGCOMPANY', 'CODE', SetNull, SetNull)]
    [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COMPANYID: String read FCOMPANYID write FCOMPANYID;

    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE: String read GETCODE write FCODE;

    [Restrictions([NotNull])]
    [Column('SERVICEID', ftInteger)]
    [Dictionary('SERVICEID', 'Mensagem de validação', '', '', '', taCenter)]
    property SERVICEID: Integer read FSERVICEID write FSERVICEID;

    [Restrictions([NotNull])]
    [Column('DESCRIPTION', ftString, 95)]
    [Dictionary('DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRIPTION: String read FDESCRIPTION write FDESCRIPTION;

    [Restrictions([NotNull])]
    [Column('PAYMENTTYPE', ftInteger)]
    [Dictionary('PAYMENTTYPE', 'Mensagem de validação', '', '', '', taCenter)]
    property PAYMENTTYPE: Integer read FPAYMENTTYPE write FPAYMENTTYPE;

    [Restrictions([NotNull])]
    [Column('PRICE', ftBCD, 18, 4)]
    [Dictionary('PRICE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRICE: Double read FPRICE write FPRICE;

    [Restrictions([NotNull])]
    [Column('STATUS', ftInteger)]
    [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taCenter)]
    property STATUS: Integer read FSTATUS write FSTATUS;

    [Restrictions([NotNull])]
    [Column('USERID', ftString, 64)]
    [ForeignKey('FK2_TORDSERVICE', 'USERID', 'TMNGUSER', 'CODE', SetNull, SetNull)]
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

    [Association(OneToOne,'COMPANYID','TMNGCOMPANY','CODE')]
    property TMNGCOMPANY: TTMNGCOMPANY read FTMNGCOMPANY_0 write FTMNGCOMPANY_0;

    [Association(OneToOne,'USERID','TMNGUSER','CODE')]
    property TMNGUSER: TTMNGUSER read FTMNGUSER_1 write FTMNGUSER_1;

  end;

implementation

constructor TTORDSERVICE.Create;
begin
  FTMNGCOMPANY_0 := TTMNGCOMPANY.Create;
  FTMNGUSER_1 := TTMNGUSER.Create;
end;

destructor TTORDSERVICE.Destroy;
begin
  if Assigned(FTMNGCOMPANY_0) then
    FTMNGCOMPANY_0.Free;

  if Assigned(FTMNGUSER_1) then
    FTMNGUSER_1.Free;

  inherited;
end;

function TTORDSERVICE.GETCODE: String;
begin
  if FCODE.IsEmpty then
  FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTORDSERVICE)

end.
