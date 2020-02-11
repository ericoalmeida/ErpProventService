unit ormbr.model.treccliente;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  /// orm 
  ormbr.model.tgerbairro,
  ormbr.model.tgercidade,
  ormbr.types.blob, 
  ormbr.types.lazy, 
  ormbr.types.mapping, 
  ormbr.types.nullable, 
  ormbr.mapping.classes, 
  ormbr.mapping.register, 
  ormbr.mapping.attributes; 

type
  [Entity]
  [Table('TRECCLIENTE', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTRECCLIENTE = class
  private
    { Private declarations } 
    FCODIGO: String;
    FCLIENTEID: Integer;
    FNOME: String;
    FCPF: String;
    FENDERECO: String;
    FBAIRROID: String;
    FCIDADEID: String;
    FCEP: String;
    FTELEFONE: Nullable<String>;
    FEMAIL: Nullable<String>;

    FTGERBAIRRO_0:  TTGERBAIRRO  ;
    FTGERCIDADE_1:  TTGERCIDADE  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('CLIENTEID', ftInteger)]
    [Dictionary('CLIENTEID', 'Mensagem de validação', '', '', '', taCenter)]
    property CLIENTEID: Integer read FCLIENTEID write FCLIENTEID;

    [Restrictions([NotNull])]
    [Column('NOME', ftString, 185)]
    [Dictionary('NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NOME: String read FNOME write FNOME;

    [Restrictions([NotNull])]
    [Column('CPF', ftString, 14)]
    [Dictionary('CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPF: String read FCPF write FCPF;

    [Restrictions([NotNull])]
    [Column('ENDERECO', ftString, 255)]
    [Dictionary('ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ENDERECO: String read FENDERECO write FENDERECO;

    [Restrictions([NotNull])]
    [Column('BAIRROID', ftString, 64)]
    [ForeignKey('FK1_TRECCLIENTE', 'BAIRROID', 'TGERBAIRRO', 'CODIGO', SetNull, SetNull)]
    [Dictionary('BAIRROID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BAIRROID: String read FBAIRROID write FBAIRROID;

    [Restrictions([NotNull])]
    [Column('CIDADEID', ftString, 64)]
    [ForeignKey('FK2_TRECCLIENTE', 'CIDADEID', 'TGERCIDADE', 'CODIGO', SetNull, SetNull)]
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

    [Association(OneToOne,'CIDADEID','TGERCIDADE','CODIGO')]
    property TGERCIDADE: TTGERCIDADE read FTGERCIDADE_1 write FTGERCIDADE_1;

  end;

implementation

constructor TTRECCLIENTE.Create;
begin
  FTGERBAIRRO_0 := TTGERBAIRRO.Create;
  FTGERCIDADE_1 := TTGERCIDADE.Create;
end;

destructor TTRECCLIENTE.Destroy;
begin
  if Assigned(FTGERBAIRRO_0) then
    FTGERBAIRRO_0.Free;

  if Assigned(FTGERCIDADE_1) then
    FTGERCIDADE_1.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TTRECCLIENTE)

end.
