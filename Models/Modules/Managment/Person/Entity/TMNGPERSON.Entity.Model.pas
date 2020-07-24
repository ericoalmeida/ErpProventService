unit TMNGPERSON.Entity.Model;

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
   TMNGDISTRICT.Entity.Model,
   TMNGUSER.Entity.Model;

type

   [Entity]
   [Table('TMNGPERSON', '')]
   [PrimaryKey('COMPANYID, CODE', NotInc, NoSort, False, 'Chave primária')]
   TTMNGPERSON = class
   private
      { Private declarations }
      FCOMPANYID: String;
      FCODE: String;
      FPERSONID: Integer;
      FPERSONTYPE: Integer;
      FNAME: String;
      FFANCYNAME: String;
      FCPFCNPJ: String;
      FRGIE: nullable<String>;
      FADDRESS: String;
      FDISTRICTID: String;
      FPHONENUMBER: nullable<String>;
      FEMAIL: nullable<String>;
      FSTATUS: Integer;
      FUSERID: String;
      FCREATEDAT: TDateTime;
      FUPDATEDAT: TDateTime;

      FTMNGCOMPANY_0: TTMNGCOMPANY;
      FTMNGDISTRICT_1: TTMNGDISTRICT;
      FTMNGUSER_2: TTMNGUSER;
      function GETCODE: String;
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      [Restrictions([NotNull])]
      [Column('COMPANYID', ftString, 64)]
      [ForeignKey('FK1_TMNGPERSON', 'COMPANYID', 'TMNGCOMPANY', 'CODE',
        SetNull, SetNull)]
      [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property COMPANYID: String read FCOMPANYID write FCOMPANYID;

      [Restrictions([NotNull])]
      [Column('CODE', ftString, 64)]
      [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property CODE: String read GETCODE write FCODE;

      [Restrictions([NotNull])]
      [Column('PERSONID', ftInteger)]
      [Dictionary('PERSONID', 'Mensagem de validação', '', '', '', taCenter)]
      property PERSONID: Integer read FPERSONID write FPERSONID;

      [Restrictions([NotNull])]
      [Column('PERSONTYPE', ftInteger)]
      [Dictionary('PERSONTYPE', 'Mensagem de validação', '', '', '', taCenter)]
      property PERSONTYPE: Integer read FPERSONTYPE write FPERSONTYPE;

      [Restrictions([NotNull])]
      [Column('NAME', ftString, 190)]
      [Dictionary('NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property NAME: String read FNAME write FNAME;

      [Restrictions([NotNull])]
      [Column('FANCYNAME', ftString, 190)]
      [Dictionary('FANCYNAME', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property FANCYNAME: String read FFANCYNAME write FFANCYNAME;

      [Restrictions([NotNull])]
      [Column('CPFCNPJ', ftString, 14)]
      [Dictionary('CPFCNPJ', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property CPFCNPJ: String read FCPFCNPJ write FCPFCNPJ;

      [Column('RGIE', ftString, 12)]
      [Dictionary('RGIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property RGIE: nullable<String> read FRGIE write FRGIE;

      [Restrictions([NotNull])]
      [Column('ADDRESS', ftString, 185)]
      [Dictionary('ADDRESS', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property ADDRESS: String read FADDRESS write FADDRESS;

      [Restrictions([NotNull])]
      [Column('DISTRICTID', ftString, 64)]
      [ForeignKey('FK2_TMNGPERSON', 'DISTRICTID', 'TMNGDISTRICT', 'CODE',
        SetNull, SetNull)]
      [Dictionary('DISTRICTID', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property DISTRICTID: String read FDISTRICTID write FDISTRICTID;

      [Column('PHONENUMBER', ftString, 15)]
      [Dictionary('PHONENUMBER', 'Mensagem de validação', '', '', '',
        taLeftJustify)]
      property PHONENUMBER: nullable<String> read FPHONENUMBER
        write FPHONENUMBER;

      [Column('EMAIL', ftString, 185)]
      [Dictionary('EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property EMAIL: nullable<String> read FEMAIL write FEMAIL;

      [Restrictions([NotNull])]
      [Column('STATUS', ftInteger)]
      [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taCenter)]
      property STATUS: Integer read FSTATUS write FSTATUS;

      [Restrictions([NotNull])]
      [Column('USERID', ftString, 64)]
      [ForeignKey('FK3_TMNGPERSON', 'USERID', 'TMNGUSER', 'CODE',
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

      [Association(OneToOne, 'DISTRICTID', 'TMNGDISTRICT', 'CODE')]
      property TMNGDISTRICT: TTMNGDISTRICT read FTMNGDISTRICT_1
        write FTMNGDISTRICT_1;

      [Association(OneToOne, 'USERID', 'TMNGUSER', 'CODE')]
      property TMNGUSER: TTMNGUSER read FTMNGUSER_2 write FTMNGUSER_2;

   end;

implementation

constructor TTMNGPERSON.Create;
begin
   FTMNGCOMPANY_0 := TTMNGCOMPANY.Create;
   FTMNGDISTRICT_1 := TTMNGDISTRICT.Create;
   FTMNGUSER_2 := TTMNGUSER.Create;
end;

destructor TTMNGPERSON.Destroy;
begin
   if Assigned(FTMNGCOMPANY_0) then
      FTMNGCOMPANY_0.Free;

   if Assigned(FTMNGDISTRICT_1) then
      FTMNGDISTRICT_1.Free;

   if Assigned(FTMNGUSER_2) then
      FTMNGUSER_2.Free;

   inherited;
end;

function TTMNGPERSON.GETCODE: String;
begin
   if FCODE.IsEmpty then
      FCODE := TGUID.NewGuid.ToString;

   Result := FCODE;
end;

initialization

TRegisterClass.RegisterEntity(TTMNGPERSON)

end.
