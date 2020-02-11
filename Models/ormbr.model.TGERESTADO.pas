unit ormbr.model.tgerestado;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  /// orm 
  ormbr.model.tgerpais,
  ormbr.types.blob, 
  ormbr.types.lazy, 
  ormbr.types.mapping, 
  ormbr.types.nullable, 
  ormbr.mapping.classes, 
  ormbr.mapping.register, 
  ormbr.mapping.attributes; 

type
  [Entity]
  [Table('TGERESTADO', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTGERESTADO = class
  private
    { Private declarations } 
    FCODIGO: String;
    FESTADOID: Integer;
    FDESCRICAO: String;
    FPAISID: String;

    FTGERPAIS_0:  TTGERPAIS  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('ESTADOID', ftInteger)]
    [Dictionary('ESTADOID', 'Mensagem de validação', '', '', '', taCenter)]
    property ESTADOID: Integer read FESTADOID write FESTADOID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 90)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;

    [Restrictions([NotNull])]
    [Column('PAISID', ftString, 64)]
    [ForeignKey('FK1_TGERESTADO', 'PAISID', 'TGERPAIS', 'CODIGO', SetNull, SetNull)]
    [Dictionary('PAISID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PAISID: String read FPAISID write FPAISID;

    [Association(OneToOne,'PAISID','TGERPAIS','CODIGO')]
    property TGERPAIS: TTGERPAIS read FTGERPAIS_0 write FTGERPAIS_0;

  end;

implementation

constructor TTGERESTADO.Create;
begin
  FTGERPAIS_0 := TTGERPAIS.Create;
end;

destructor TTGERESTADO.Destroy;
begin
  if Assigned(FTGERPAIS_0) then
    FTGERPAIS_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TTGERESTADO)

end.
