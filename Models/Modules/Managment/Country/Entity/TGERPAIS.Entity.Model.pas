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
  ormbr.mapping.Classes,
  ormbr.mapping.register,
  ormbr.mapping.attributes;

type

  [Entity]
  [Table('TGERPAIS', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTGERPAIS = class
  private
    { Private declarations }
    FCODIGO: String;
    FPAISID: Integer;
    FDESCRICAO: String;
    FDATACADASTRO: TDateTime;
    FDATAATUALIZACAO: TDateTime;
    function getCodigo: String;
    function getDataCadastro: TDateTime;
  public
    { Public declarations }
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read getCodigo write FCODIGO;

    [Restrictions([NotNull])]
    [Column('PAISID', ftInteger)]
    [Dictionary('PAISID', 'Mensagem de validação', '', '', '', taCenter)]
    property PAISID: Integer read FPAISID write FPAISID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 60)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;

    [Restrictions([NotNull])]
    [Column('DATACADASTRO', ftDateTime)]
    [Dictionary('DATACADASTRO', 'Mensagem de validação', 'Now', '',
      '!##/##/####;1;_', taCenter)]
    property DATACADASTRO: TDateTime read getDataCadastro write FDATACADASTRO;

    [Restrictions([NotNull])]
    [Column('DATAATUALIZACAO', ftDateTime)]
    [Dictionary('DATAATUALIZACAO', 'Mensagem de validação', 'Now', '',
      '!##/##/####;1;_', taCenter)]
    property DATAATUALIZACAO: TDateTime read FDATAATUALIZACAO
      write FDATAATUALIZACAO;
  end;

implementation

{ TTGERPAIS }

function TTGERPAIS.getCodigo: String;
begin
  if FCODIGO.IsEmpty then
    FCODIGO := TGUID.NewGuid.ToString;

  Result := FCODIGO;
end;

function TTGERPAIS.getDataCadastro: TDateTime;
begin
  if FDATACADASTRO = StrToDateTime('30/12/1899 00:00') then
  FDATACADASTRO := Now;

  Result := FDATACADASTRO;
end;

initialization

TRegisterClass.RegisterEntity(TTGERPAIS)

end.
