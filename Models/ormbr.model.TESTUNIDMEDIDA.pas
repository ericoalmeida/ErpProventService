unit ormbr.model.testunidmedida;

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
  [Table('TESTUNIDMEDIDA', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave prim�ria')]
  TTESTUNIDMEDIDA = class
  private
    { Private declarations } 
    FCODIGO: String;
    FUNIDMEDIDAID: Integer;
    FDESCRICAO: String;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('UNIDMEDIDAID', ftInteger)]
    [Dictionary('UNIDMEDIDAID', 'Mensagem de valida��o', '', '', '', taCenter)]
    property UNIDMEDIDAID: Integer read FUNIDMEDIDAID write FUNIDMEDIDAID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 55)]
    [Dictionary('DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TTESTUNIDMEDIDA)

end.
