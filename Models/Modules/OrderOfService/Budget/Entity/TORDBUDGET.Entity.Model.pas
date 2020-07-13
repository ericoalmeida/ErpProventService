unit TORDBUDGET.Entity.Model;

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
  [Table('TORDBUDGET', '')]
  [PrimaryKey('COMPANYID', NotInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave primária')]
  TTORDBUDGET = class
  private
    { Private declarations } 
    FCOMPANYID: String;
    FCODE: String;
    FBUDGETID: Integer;
    FDESCRIPTION: String;
    FEMISSIONDATE: TDateTime;
    FUSERID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGCOMPANY_0:  TTMNGCOMPANY  ;
    FTMNGUSER_1:  TTMNGUSER  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('COMPANYID', ftString, 64)]
    [ForeignKey('FK1_TORDBUDGET', 'COMPANYID', 'TMNGCOMPANY', 'CODE', SetNull, SetNull)]
    [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COMPANYID: String read FCOMPANYID write FCOMPANYID;

    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE: String read FCODE write FCODE;

    [Restrictions([NotNull])]
    [Column('BUDGETID', ftInteger)]
    [Dictionary('BUDGETID', 'Mensagem de validação', '', '', '', taCenter)]
    property BUDGETID: Integer read FBUDGETID write FBUDGETID;

    [Restrictions([NotNull])]
    [Column('DESCRIPTION', ftString, 155)]
    [Dictionary('DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRIPTION: String read FDESCRIPTION write FDESCRIPTION;

    [Restrictions([NotNull])]
    [Column('EMISSIONDATE', ftDateTime)]
    [Dictionary('EMISSIONDATE', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property EMISSIONDATE: TDateTime read FEMISSIONDATE write FEMISSIONDATE;

    [Restrictions([NotNull])]
    [Column('USERID', ftString, 64)]
    [ForeignKey('FK2_TORDBUDGET', 'USERID', 'TMNGUSER', 'CODE', SetNull, SetNull)]
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

constructor TTORDBUDGET.Create;
begin
  FTMNGCOMPANY_0 := TTMNGCOMPANY.Create;
  FTMNGUSER_1 := TTMNGUSER.Create;
end;

destructor TTORDBUDGET.Destroy;
begin
  if Assigned(FTMNGCOMPANY_0) then
    FTMNGCOMPANY_0.Free;

  if Assigned(FTMNGUSER_1) then
    FTMNGUSER_1.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TTORDBUDGET)

end.
