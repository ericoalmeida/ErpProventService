unit ormbr.model.teqpmaquina;

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
  [Table('TEQPMAQUINA', '')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TTEQPMAQUINA = class
  private
    { Private declarations } 
    FCODIGO: String;
    FMAQUINAAID: Integer;
    FDESCRICAO: String;
    FHORIMETROATUAL: Nullable<Double>;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('CODIGO', ftString, 64)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODIGO: String read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('MAQUINAAID', ftInteger)]
    [Dictionary('MAQUINAAID', 'Mensagem de validação', '', '', '', taCenter)]
    property MAQUINAAID: Integer read FMAQUINAAID write FMAQUINAAID;

    [Restrictions([NotNull])]
    [Column('DESCRICAO', ftString, 122)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;

    [Column('HORIMETROATUAL', ftBCD)]
    [Dictionary('HORIMETROATUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property HORIMETROATUAL: Nullable<Double> read FHORIMETROATUAL write FHORIMETROATUAL;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TTEQPMAQUINA)

end.
