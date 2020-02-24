unit TASSTYPEEXPENSE.Entity.Model;

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
  [Table('TASSTYPEEXPENSE', '')]
  [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave primária')]
  TTASSTYPEEXPENSE = class
  private
    { Private declarations } 
    FCODE: String;
    FTYPEEXPENSEID: Integer;
    FDESCRIPTION: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;
    function GETCODE: String;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE: String read GETCODE write FCODE;

    [Restrictions([NotNull])]
    [Column('TYPEEXPENSEID', ftInteger)]
    [Dictionary('TYPEEXPENSEID', 'Mensagem de validação', '', '', '', taCenter)]
    property TYPEEXPENSEID: Integer read FTYPEEXPENSEID write FTYPEEXPENSEID;

    [Restrictions([NotNull])]
    [Column('DESCRIPTION', ftString, 95)]
    [Dictionary('DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRIPTION: String read FDESCRIPTION write FDESCRIPTION;

    [Restrictions([NotNull])]
    [Column('CREATEDAT', ftDateTime)]
    [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

    [Restrictions([NotNull])]
    [Column('UPDATEDAT', ftDateTime)]
    [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;
  end;

implementation

{ TTASSTYPEEXPENSE }

function TTASSTYPEEXPENSE.GETCODE: String;
begin
  if FCODE.IsEmpty then
   FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTASSTYPEEXPENSE)

end.
