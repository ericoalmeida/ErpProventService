unit ormbr.model.testservico;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  /// orm 
  ormbr.model.testunidmedida,
  ormbr.types.blob, 
  ormbr.types.lazy, 
  ormbr.types.mapping, 
  ormbr.types.nullable, 
  ormbr.mapping.classes, 
  ormbr.mapping.register, 
  ormbr.mapping.attributes; 

type
  [Entity]
  [Table('TESTSERVICO', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave prim�ria')]
  TTESTSERVICO = class
  private
    { Private declarations } 
    FCODIGO: String;
    FSERVICOID: Integer;
    FDESCRICAO: String;
    FUNIDMEDIDAID: String;
    FVALOR: Double;

    FTESTUNIDMEDIDA_0:  TTESTUNIDMEDIDA  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('SERVICOID', ftInteger)]
    [Dictionary('SERVICOID', 'Mensagem de valida��o', '', '', '', taCenter)]
    property SERVICOID: Integer read FSERVICOID write FSERVICOID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 155)]
    [Dictionary('DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;

    [Restrictions([NotNull])]
    [Column('UNIDMEDIDAID', ftString, 64)]
    [ForeignKey('FK1_TESTSERVICO', 'UNIDMEDIDAID', 'TESTUNIDMEDIDA', 'CODIGO', SetNull, SetNull)]
    [Dictionary('UNIDMEDIDAID', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property UNIDMEDIDAID: String read FUNIDMEDIDAID write FUNIDMEDIDAID;

    [Restrictions([NotNull])]
    [Column('VALOR', ftBCD)]
    [Dictionary('VALOR', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VALOR: Double read FVALOR write FVALOR;

    [Association(OneToOne,'UNIDMEDIDAID','TESTUNIDMEDIDA','CODIGO')]
    property TESTUNIDMEDIDA: TTESTUNIDMEDIDA read FTESTUNIDMEDIDA_0 write FTESTUNIDMEDIDA_0;

  end;

implementation

constructor TTESTSERVICO.Create;
begin
  FTESTUNIDMEDIDA_0 := TTESTUNIDMEDIDA.Create;
end;

destructor TTESTSERVICO.Destroy;
begin
  if Assigned(FTESTUNIDMEDIDA_0) then
    FTESTUNIDMEDIDA_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TTESTSERVICO)

end.
