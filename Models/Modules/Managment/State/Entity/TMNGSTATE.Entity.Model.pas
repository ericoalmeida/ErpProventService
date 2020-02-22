unit TMNGSTATE.Entity.Model;


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
  TMNGCOUNTRY.Entity.Model;

type
  [Entity]
  [Table('TMNGSTATE', '')]
  [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave primária')]
  TTMNGSTATE = class
  private
    { Private declarations }
    FCODE: String;
    FSTATEID: Integer;
    FNAME: String;
    FINITIALS: String;
    FCOUNTRYID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGCOUNTRY_0:  TTMNGCOUNTRY  ;
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
    [Column('STATEID', ftInteger)]
    [Dictionary('STATEID', 'Mensagem de validação', '', '', '', taCenter)]
    property STATEID: Integer read FSTATEID write FSTATEID;

    [Restrictions([NotNull])]
    [Column('NAME', ftString, 90)]
    [Dictionary('NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NAME: String read FNAME write FNAME;

    [Restrictions([NotNull])]
    [Column('INITIALS', ftString, 2)]
    [Dictionary('INITIALS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INITIALS: String read FINITIALS write FINITIALS;

    [Restrictions([NotNull])]
    [Column('COUNTRYID', ftString, 64)]
    [ForeignKey('FK1_TMNGSTATE', 'COUNTRYID', 'TMNGCOUNTRY', 'CODE', SetNull, SetNull)]
    [Dictionary('COUNTRYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COUNTRYID: String read FCOUNTRYID write FCOUNTRYID;

    [Restrictions([NotNull])]
    [Column('CREATEDAT', ftDateTime)]
    [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

    [Restrictions([NotNull])]
    [Column('UPDATEDAT', ftDateTime)]
    [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;

    [Association(OneToOne,'COUNTRYID','TMNGCOUNTRY','CODE')]
    property TMNGCOUNTRY: TTMNGCOUNTRY read FTMNGCOUNTRY_0 write FTMNGCOUNTRY_0;

  end;

implementation

constructor TTMNGSTATE.Create;
begin
  FTMNGCOUNTRY_0 := TTMNGCOUNTRY.Create;
end;

destructor TTMNGSTATE.Destroy;
begin
  if Assigned(FTMNGCOUNTRY_0) then
    FTMNGCOUNTRY_0.Free;

  inherited;
end;

function TTMNGSTATE.GETCODE: String;
begin
  if FCODE.IsEmpty then
   FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTMNGSTATE)

end.
