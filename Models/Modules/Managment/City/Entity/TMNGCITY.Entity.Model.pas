unit TMNGCITY.Entity.Model;

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
  TGERESTADO.Entity.Model;

type
  [Entity]
  [Table('TMNGCITY', '')]
  [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave primária')]
  TTMNGCITY = class
  private
    { Private declarations }
    FCODE: String;
    FCITYID: Integer;
    FNAME: String;
    FZIPCODE: String;
    FIBGECODE: Nullable<Integer>;
    FSTATEID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGSTATE_0:  TTMNGSTATE  ;
    function GETCODE: String;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE: String read GETCODE write FCODE;

    [Restrictions([NotNull])]
    [Column('CITYID', ftInteger)]
    [Dictionary('CITYID', 'Mensagem de validação', '', '', '', taCenter)]
    property CITYID: Integer read FCITYID write FCITYID;

    [Restrictions([NotNull])]
    [Column('NAME', ftString, 155)]
    [Dictionary('NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NAME: String read FNAME write FNAME;

    [Restrictions([NotNull])]
    [Column('ZIPCODE', ftString, 12)]
    [Dictionary('ZIPCODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ZIPCODE: String read FZIPCODE write FZIPCODE;

    [Column('IBGECODE', ftInteger)]
    [Dictionary('IBGECODE', 'Mensagem de validação', '', '', '', taCenter)]
    property IBGECODE: Nullable<Integer> read FIBGECODE write FIBGECODE;

    [Restrictions([NotNull])]
    [Column('STATEID', ftString, 64)]
    [ForeignKey('FK1_TMNGCITY', 'STATEID', 'TMNGSTATE', 'CODE', SetNull, SetNull)]
    [Dictionary('STATEID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STATEID: String read FSTATEID write FSTATEID;

    [Restrictions([NotNull])]
    [Column('CREATEDAT', ftDateTime)]
    [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

    [Restrictions([NotNull])]
    [Column('UPDATEDAT', ftDateTime)]
    [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;

    [Association(OneToOne,'STATEID','TMNGSTATE','CODE')]
    property TMNGSTATE: TTMNGSTATE read FTMNGSTATE_0 write FTMNGSTATE_0;

  end;

implementation

constructor TTMNGCITY.Create;
begin
  FTMNGSTATE_0 := TTMNGSTATE.Create;
end;

destructor TTMNGCITY.Destroy;
begin
  if Assigned(FTMNGSTATE_0) then
    FTMNGSTATE_0.Free;

  inherited;
end;

function TTMNGCITY.GETCODE: String;
begin
  if FCODE.IsEmpty then
   FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTMNGCITY)

end.
