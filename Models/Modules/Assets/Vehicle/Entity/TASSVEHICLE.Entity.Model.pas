unit TASSVEHICLE.Entity.Model;

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
   ormbr.mapping.attributes,
   TMNGCOMPANY.Entity.Model,
   TMNGUSER.Entity.Model;

type

   [Entity]
   [Table('TASSVEHICLE', '')]
   [PrimaryKey('COMPANYID, CODE', NotInc, NoSort, False, 'Chave primária')]
   TTASSVEHICLE = class
   private
      { Private declarations }
      FCOMPANYID: String;
      FCODE: String;
      FVEHICLEID: Integer;
      FDESCRIPTION: String;
      FMODEL: String;
      FBRAND: String;
      FCATEGORY: String;
      FBOARD: nullable<String>;
      FSTATUS: Integer;
      FUSERID: String;
      FCREATEDAT: TDateTime;
      FUPDATEDAT: TDateTime;

      FTMNGCOMPANY_0: TTMNGCOMPANY;
      FTMNGUSER_1: TTMNGUSER;
      function GETCODE: String;
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      [Restrictions([NotNull])]
      [Column('COMPANYID', ftString, 64)]
      [ForeignKey('FK1_TASSVEHICLE', 'COMPANYID', 'TMNGCOMPANY', 'CODE',
        SetNull, SetNull)]
      [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property COMPANYID: String read FCOMPANYID write FCOMPANYID;

      [Restrictions([NotNull])]
      [Column('CODE', ftString, 64)]
      [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property CODE: String read GETCODE write FCODE;

      [Restrictions([NotNull])]
      [Column('VEHICLEID', ftInteger)]
      [Dictionary('VEHICLEID', 'Mensagem de validação', '', '', '', taCenter)]
      property VEHICLEID: Integer read FVEHICLEID write FVEHICLEID;

      [Restrictions([NotNull])]
      [Column('DESCRIPTION', ftString, 75)]
      [Dictionary('DESCRIPTION', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property DESCRIPTION: String read FDESCRIPTION write FDESCRIPTION;

      [Restrictions([NotNull])]
      [Column('MODEL', ftString, 65)]
      [Dictionary('MODEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property Model: String read FMODEL write FMODEL;

      [Restrictions([NotNull])]
      [Column('BRAND', ftString, 65)]
      [Dictionary('BRAND', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property BRAND: String read FBRAND write FBRAND;

      [Restrictions([NotNull])]
      [Column('CATEGORY', ftString, 65)]
      [Dictionary('CATEGORY', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property CATEGORY: String read FCATEGORY write FCATEGORY;

      [Column('BOARD', ftString, 18)]
      [Dictionary('BOARD', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property BOARD: nullable<String> read FBOARD write FBOARD;

      [Restrictions([NotNull])]
      [Column('STATUS', ftInteger)]
      [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taCenter)]
      property STATUS: Integer read FSTATUS write FSTATUS;

      [Restrictions([NotNull])]
      [Column('USERID', ftString, 64)]
      [ForeignKey('FK2_TASSVEHICLE', 'USERID', 'TMNGUSER', 'CODE',
        SetNull, SetNull)]
      [Dictionary('USERID', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property USERID: String read FUSERID write FUSERID;

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

      [Association(OneToOne, 'COMPANYID', 'TMNGCOMPANY', 'CODE')]
      property TMNGCOMPANY: TTMNGCOMPANY read FTMNGCOMPANY_0
        write FTMNGCOMPANY_0;

      [Association(OneToOne, 'USERID', 'TMNGUSER', 'CODE')]
      property TMNGUSER: TTMNGUSER read FTMNGUSER_1 write FTMNGUSER_1;

   end;

implementation

constructor TTASSVEHICLE.Create;
begin
   FTMNGCOMPANY_0 := TTMNGCOMPANY.Create;
   FTMNGUSER_1 := TTMNGUSER.Create;
end;

destructor TTASSVEHICLE.Destroy;
begin
   if Assigned(FTMNGCOMPANY_0) then
      FTMNGCOMPANY_0.Free;

   if Assigned(FTMNGUSER_1) then
      FTMNGUSER_1.Free;

   inherited;
end;

function TTASSVEHICLE.GETCODE: String;
begin
   if FCODE.IsEmpty then
      FCODE := TGUID.NewGuid.ToString;

   Result := FCODE;
end;

initialization

TRegisterClass.RegisterEntity(TTASSVEHICLE)

end.
