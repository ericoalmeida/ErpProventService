unit ormbr.model.tgerbairro;

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
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('BAIRROID', ftInteger)]
    [Dictionary('BAIRROID', 'Mensagem de validação', '', '', '', taCenter)]
    property BAIRROID: Integer read FBAIRROID write FBAIRROID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 155)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TTGERBAIRRO)

end.
