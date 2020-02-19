unit TGERBAIRRO.Entity.Model;

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
  TMNGCITY.Entity.Model;

type
  [Entity]
  [Table('TMNGDISTRICT', '')]
  [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave primária')]
  TTMNGDISTRICT = class
  private
    { Private declarations }
    FCODE: String;
    FDISTRICTID: Integer;
    FDESCRIPTION: String;
    FCITYID: String;
    FZIPCODE: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGCITY_0:  TTMNGCITY  ;
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
    [Column('DISTRICTID', ftInteger)]
    [Dictionary('DISTRICTID', 'Mensagem de validação', '', '', '', taCenter)]
    property DISTRICTID: Integer read FDISTRICTID write FDISTRICTID;

    [Restrictions([NotNull])]
    [Column('DESCRIPTION', ftString, 155)]
    [Dictionary('DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRIPTION: String read FDESCRIPTION write FDESCRIPTION;

    [Restrictions([NotNull])]
    [Column('CITYID', ftString, 64)]
    [ForeignKey('FK1_TMNGDISTRICT', 'CITYID', 'TMNGCITY', 'CODE', SetNull, SetNull)]
    [Dictionary('CITYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CITYID: String read FCITYID write FCITYID;

    [Restrictions([NotNull])]
    [Column('ZIPCODE', ftString, 12)]
    [Dictionary('ZIPCODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ZIPCODE: String read FZIPCODE write FZIPCODE;

    [Restrictions([NotNull])]
    [Column('CREATEDAT', ftDateTime)]
    [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

    [Restrictions([NotNull])]
    [Column('UPDATEDAT', ftDateTime)]
    [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;

    [Association(OneToOne,'CITYID','TMNGCITY','CODE')]
    property TMNGCITY: TTMNGCITY read FTMNGCITY_0 write FTMNGCITY_0;

  end;

implementation

constructor TTMNGDISTRICT.Create;
begin
  FTMNGCITY_0 := TTMNGCITY.Create;
end;

destructor TTMNGDISTRICT.Destroy;
begin
  if Assigned(FTMNGCITY_0) then
    FTMNGCITY_0.Free;

  inherited;
end;

function TTMNGDISTRICT.GETCODE: String;
begin
  if FCODE.IsEmpty then
   FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTMNGDISTRICT)

end.


