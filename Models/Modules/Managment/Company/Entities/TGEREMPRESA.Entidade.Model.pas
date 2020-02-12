unit TGEREMPRESA.Entidade.Model;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  /// orm 
  ormbr.model.tgerbairro,
  ormbr.types.blob, 
  ormbr.types.lazy, 
  ormbr.types.mapping, 
  ormbr.types.nullable, 
  ormbr.mapping.classes, 
  ormbr.mapping.register, 
  ormbr.mapping.attributes; 

type
  [Entity]
  [Table('TGEREMPRESA', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTGEREMPRESA = class
  private
    { Private declarations } 
    FCODIGO: String;
    FEMPRESAID: Integer;
    FPREFEITURA: String;
    FCNPJ: String;
    FSECRETARIA: String;
    FENDERECO: String;
    FBAIRROID: String;
    FCIDADEID: String;
    FCEP: String;
    FTELEFONE: Nullable<String>;
    FEMAIL: Nullable<String>;

    FTGERBAIRRO_0:  TTGERBAIRRO  ;
    function getCODIGO: String;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read getCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('EMPRESAID', ftInteger)]
    [Dictionary('EMPRESAID', 'Mensagem de validação', '', '', '', taCenter)]
    property EMPRESAID: Integer read FEMPRESAID write FEMPRESAID;

    [Restrictions([NotNull])]
    [Column('PREFEITURA', ftString, 185)]
    [Dictionary('PREFEITURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PREFEITURA: String read FPREFEITURA write FPREFEITURA;

    [Restrictions([NotNull])]
    [Column('CNPJ', ftString, 14)]
    [Dictionary('CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNPJ: String read FCNPJ write FCNPJ;

    [Restrictions([NotNull])]
    [Column('SECRETARIA', ftString, 185)]
    [Dictionary('SECRETARIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SECRETARIA: String read FSECRETARIA write FSECRETARIA;

    [Restrictions([NotNull])]
    [Column('ENDERECO', ftString, 255)]
    [Dictionary('ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ENDERECO: String read FENDERECO write FENDERECO;

    [Restrictions([NotNull])]
    [Column('BAIRROID', ftString, 64)]
    [ForeignKey('FK1_TGEREMPRESA', 'BAIRROID', 'TGERBAIRRO', 'CODIGO', SetNull, SetNull)]
    [Dictionary('BAIRROID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BAIRROID: String read FBAIRROID write FBAIRROID;

    [Restrictions([NotNull])]
    [Column('CIDADEID', ftString, 64)]
    [Dictionary('CIDADEID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIDADEID: String read FCIDADEID write FCIDADEID;

    [Restrictions([NotNull])]
    [Column('CEP', ftString, 8)]
    [Dictionary('CEP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP: String read FCEP write FCEP;

    [Column('TELEFONE', ftString, 185)]
    [Dictionary('TELEFONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TELEFONE: Nullable<String> read FTELEFONE write FTELEFONE;

    [Column('EMAIL', ftString, 185)]
    [Dictionary('EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EMAIL: Nullable<String> read FEMAIL write FEMAIL;

    [Association(OneToOne,'BAIRROID','TGERBAIRRO','CODIGO')]
    property TGERBAIRRO: TTGERBAIRRO read FTGERBAIRRO_0 write FTGERBAIRRO_0;

  end;

implementation

constructor TTGEREMPRESA.Create;
begin
  FTGERBAIRRO_0 := TTGERBAIRRO.Create;
end;

destructor TTGEREMPRESA.Destroy;
begin
  if Assigned(FTGERBAIRRO_0) then
    FTGERBAIRRO_0.Free;

  inherited;
end;

function TTGEREMPRESA.getCODIGO: String;
begin
  Result := FCODIGO;
end;

initialization
  TRegisterClass.RegisterEntity(TTGEREMPRESA)

end.
