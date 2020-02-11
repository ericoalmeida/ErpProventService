unit ormbr.model.tpagtipodespesa;

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
  [Table('TPAGTIPODESPESA', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave prim�ria')]
  TTPAGTIPODESPESA = class
  private
    { Private declarations } 
    FCODIGO: String;
    FTIPODESPESASID: Integer;
    FDESCRICAO: String;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('TIPODESPESASID', ftInteger)]
    [Dictionary('TIPODESPESASID', 'Mensagem de valida��o', '', '', '', taCenter)]
    property TIPODESPESASID: Integer read FTIPODESPESASID write FTIPODESPESASID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 155)]
    [Dictionary('DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TTPAGTIPODESPESA)

end.
