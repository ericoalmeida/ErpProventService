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
  ormbr.mapping.attributes;

type
  [Entity]
  [Table('TGERBAIRRO', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTGERBAIRRO = class
  private
    { Private declarations }
    FCODIGO: String;
    FBAIRROID: Integer;
    FDESCRICAO: String;
    FDATACADASTRO: TDateTime;
    FDATAATUALIZACAO: TDateTime;
    function getCodigo: String;
    function getDataCadastro: TDateTime;
    function getDataAtualizacao: TDateTime;
  public
    { Public declarations }
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read getCodigo write FCODIGO;

    [Restrictions([NotNull])]
    [Column('BAIRROID', ftInteger)]
    [Dictionary('BAIRROID', 'Mensagem de validação', '', '', '', taCenter)]
    property BAIRROID: Integer read FBAIRROID write FBAIRROID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 155)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;

    [Restrictions([NotNull])]
    [Column('DATACADASTRO', ftDateTime)]
    [Dictionary('DATACADASTRO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property DATACADASTRO: TDateTime read getDataCadastro write FDATACADASTRO;

    [Restrictions([NotNull])]
    [Column('DATAATUALIZACAO', ftDateTime)]
    [Dictionary('DATAATUALIZACAO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property DATAATUALIZACAO: TDateTime read getDataAtualizacao write FDATAATUALIZACAO;
  end;

implementation

{ TTGERBAIRRO }

function TTGERBAIRRO.getCodigo: String;
begin
  if FCODIGO.IsEmpty then
  FCODIGO := TGUID.NewGuid.ToString;

  Result := FCODIGO;
end;

function TTGERBAIRRO.getDataAtualizacao: TDateTime;
begin
  FDATAATUALIZACAO := Now;

  Result := FDATAATUALIZACAO;
end;

function TTGERBAIRRO.getDataCadastro: TDateTime;
begin
  if FDATACADASTRO = StrToDateTime('30/12/1899 00:00') then
  FDATACADASTRO := Now;

  Result := FDATACADASTRO;
end;

initialization
  TRegisterClass.RegisterEntity(TTGERBAIRRO)

end.
