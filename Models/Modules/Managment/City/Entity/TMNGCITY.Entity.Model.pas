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
  ormbr.mapping.Classes,
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
    FIBGECODE: Integer;
    FSTATEID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTGERESTADO_0: TTGERESTADO;
    function getCode: String;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE: String read getCode write FCODE;

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

    [Restrictions([NotNull])]
    [Column('IBGECODE', ftInteger)]
    [Dictionary('IBGECODE', 'Mensagem de validação', '', '', '', taCenter)]
    property IBGECODE: Integer read FIBGECODE write FIBGECODE;

    [Restrictions([NotNull])]
    [Column('STATEID', ftString, 64)]
    [ForeignKey('FK1_TMNGCITY', 'STATEID', 'TGERESTADO', 'CODIGO',
      SetNull, SetNull)]
    [Dictionary('STATEID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STATEID: String read FSTATEID write FSTATEID;

    [Restrictions([NotNull])]
    [Column('CREATEDAT', ftDateTime)]
    [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '',
      '!##/##/####;1;_', taCenter)]
    property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

    [Restrictions([NotNull])]
    [Column('UPDATEDAT', ftDateTime)]
    [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '',
      '!##/##/####;1;_', taCenter)]
    property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;

    [Association(OneToOne, 'STATEID', 'TGERESTADO', 'CODIGO')]
    property TGERESTADO: TTGERESTADO read FTGERESTADO_0 write FTGERESTADO_0;

  end;

implementation

constructor TTMNGCITY.Create;
begin
  FTGERESTADO_0 := TTGERESTADO.Create;
end;

destructor TTMNGCITY.Destroy;
begin
  if Assigned(FTGERESTADO_0) then
    FTGERESTADO_0.Free;

  inherited;
end;

function TTMNGCITY.getCode: String;
begin
  if FCODE.IsEmpty then
    FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization

TRegisterClass.RegisterEntity(TTMNGCITY)

end.
