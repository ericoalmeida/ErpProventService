unit TGERPAIS.Entity.Model;

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
  ormbr.mapping.attributes;

type
  [Entity]
  [Table('TMNGCOUNTRY', '')]
  [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave prim�ria')]
  TTMNGCOUNTRY = class
  private
    { Private declarations }
    FCODE: String;
    FCOUNTRYID: Integer;
    FNAME: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;
    function GETCODE: String;
  public
    { Public declarations }
    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CODE: String read GETCODE write FCODE;

    [Restrictions([NotNull])]
    [Column('COUNTRYID', ftInteger)]
    [Dictionary('COUNTRYID', 'Mensagem de valida��o', '', '', '', taCenter)]
    property COUNTRYID: Integer read FCOUNTRYID write FCOUNTRYID;

    [Restrictions([NotNull])]
    [Column('NAME', ftString, 60)]
    [Dictionary('NAME', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property NAME: String read FNAME write FNAME;

    [Restrictions([NotNull])]
    [Column('CREATEDAT', ftDateTime)]
    [Dictionary('CREATEDAT', 'Mensagem de valida��o', 'Now', '', '!##/##/####;1;_', taCenter)]
    property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

    [Restrictions([NotNull])]
    [Column('UPDATEDAT', ftDateTime)]
    [Dictionary('UPDATEDAT', 'Mensagem de valida��o', 'Now', '', '!##/##/####;1;_', taCenter)]
    property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;
  end;

implementation

{ TTMNGCOUNTRY }

function TTMNGCOUNTRY.GETCODE: String;
begin
  if FCODE.IsEmpty then
  FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTMNGCOUNTRY)

end.
