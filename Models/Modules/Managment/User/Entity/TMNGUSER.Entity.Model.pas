unit TMNGUSER.Entity.Model;

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
   ormbr.mapping.Classes,
   ormbr.mapping.register,
   ormbr.mapping.attributes;

type

   [Entity]
   [Table('TMNGUSER', '')]
   [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave primária')]
   TTMNGUSER = class
   private
      { Private declarations }
      FCODE: String;
      FUSERID: Integer;
      FNAME: String;
      FEMAIL: String;
      FUSERNAME: String;
      FKEYPASS: String;
      FSTATUS: Integer;
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
      [Column('USERID', ftInteger)]
      [Dictionary('USERID', 'Mensagem de validação', '', '', '', taCenter)]
      property USERID: Integer read FUSERID write FUSERID;

      [Restrictions([NotNull])]
      [Column('NAME', ftString, 95)]
      [Dictionary('NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property NAME: String read FNAME write FNAME;

      [Restrictions([NotNull])]
      [Column('EMAIL', ftString, 90)]
      [Dictionary('EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property EMAIL: String read FEMAIL write FEMAIL;

      [Restrictions([NotNull])]
      [Column('USERNAME', ftString, 30)]
      [Dictionary('USERNAME', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property USERNAME: String read FUSERNAME write FUSERNAME;

      [Restrictions([NotNull])]
      [Column('KEYPASS', ftString, 64)]
      [Dictionary('KEYPASS', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property KEYPASS: String read FKEYPASS write FKEYPASS;

      [Restrictions([NotNull])]
      [Column('STATUS', ftInteger)]
      [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taCenter)]
      property STATUS: Integer read FSTATUS write FSTATUS;

      [Restrictions([NotNull])]
      [Column('CREATEDAT', ftDateTime)]
      [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '',
        '!##/##/####;1;_', taCenter)]
      property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

      [Restrictions([NotNull])]
      [Column('UPDATEDAT', ftDateTime)]
      [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '',
        '!##/##/####;1;_', taCenter)]
      property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;
   end;

implementation

{ TTMNGUSER }

function TTMNGUSER.GETCODE: String;
begin
   if FCODE.IsEmpty then
      FCODE := TGUID.NewGuid.ToString;

   Result := FCODE;
end;

initialization

TRegisterClass.RegisterEntity(TTMNGUSER)

end.
