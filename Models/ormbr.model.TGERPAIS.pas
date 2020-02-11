unit ormbr.model.tgerpais;

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
  [Table('TGERPAIS', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTGERPAIS = class
  private
    { Private declarations } 
    FCODIGO: String;
    FPAISID: Integer;
    FDESCRICAO: String;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('PAISID', ftInteger)]
    [Dictionary('PAISID', 'Mensagem de validação', '', '', '', taCenter)]
    property PAISID: Integer read FPAISID write FPAISID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 60)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TTGERPAIS)

end.
