unit ormbr.model.tgercidade;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  /// orm 
  ormbr.model.tgerestado,
  ormbr.types.blob, 
  ormbr.types.lazy, 
  ormbr.types.mapping, 
  ormbr.types.nullable, 
  ormbr.mapping.classes, 
  ormbr.mapping.register, 
  ormbr.mapping.attributes; 

type
  [Entity]
  [Table('TGERCIDADE', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTGERCIDADE = class
  private
    { Private declarations } 
    FCODIGO: String;
    FCIDADEID: Integer;
    FDESCRICAO: String;
    FESTADOID: String;

    FTGERESTADO_0:  TTGERESTADO  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('CIDADEID', ftInteger)]
    [Dictionary('CIDADEID', 'Mensagem de validação', '', '', '', taCenter)]
    property CIDADEID: Integer read FCIDADEID write FCIDADEID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 155)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;

    [Restrictions([NotNull])]
    [Column('ESTADOID', ftString, 64)]
    [ForeignKey('FK1_TGERCIDADE', 'ESTADOID', 'TGERESTADO', 'CODIGO', SetNull, SetNull)]
    [Dictionary('ESTADOID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ESTADOID: String read FESTADOID write FESTADOID;

    [Association(OneToOne,'ESTADOID','TGERESTADO','CODIGO')]
    property TGERESTADO: TTGERESTADO read FTGERESTADO_0 write FTGERESTADO_0;

  end;

implementation

constructor TTGERCIDADE.Create;
begin
  FTGERESTADO_0 := TTGERESTADO.Create;
end;

destructor TTGERCIDADE.Destroy;
begin
  if Assigned(FTGERESTADO_0) then
    FTGERESTADO_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TTGERCIDADE)

end.
