unit TMNGCOMPANY.Entity.Model;

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
   TMNGDISTRICT.Entity.Model;

type

   [Entity]
   [Table('TMNGCOMPANY', '')]
   [PrimaryKey('CODE', NotInc, NoSort, False, 'Chave primária')]
   TTMNGCOMPANY = class
   private
      { Private declarations }
      FCODE: String;
      FCOMPANYID: Integer;
      FNAME: String;
      FFANCYNAME: String;
      FCPFCNPJ: String;
      FRGIE: nullable<String>;
      FADDRESS: String;
      FDISTRICTID: String;
      FPHONENUMBER: nullable<String>;
      FEMAIL: nullable<String>;
      FCREATEDAT: TDateTime;
      FUPDATEDAT: TDateTime;

      FTMNGDISTRICT_0: TTMNGDISTRICT;
      function GETCODE: String;
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      [Restrictions([NotNull])]
      [Column('CODE', ftString, 64)]
      [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property CODE: String read GETCODE write FCODE;

      [Restrictions([NotNull])]
      [Column('COMPANYID', ftInteger)]
      [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taCenter)]
      property COMPANYID: Integer read FCOMPANYID write FCOMPANYID;

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
      [ForeignKey('FK1_TMNGCOMPANY', 'DISTRICTID', 'TMNGDISTRICT', 'CODE',
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
      [Column('CREATEDAT', ftDateTime)]
      [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '',
        '!##/##/####;1;_', taCenter)]
      property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

      [Restrictions([NotNull])]
      [Column('UPDATEDAT', ftDateTime)]
      [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '',
        '!##/##/####;1;_', taCenter)]
      property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;

      [Association(OneToOne, 'DISTRICTID', 'TMNGDISTRICT', 'CODE')]
      property TMNGDISTRICT: TTMNGDISTRICT read FTMNGDISTRICT_0
        write FTMNGDISTRICT_0;

   end;

implementation

constructor TTMNGCOMPANY.Create;
begin
   FTMNGDISTRICT_0 := TTMNGDISTRICT.Create;
end;

destructor TTMNGCOMPANY.Destroy;
begin
   if Assigned(FTMNGDISTRICT_0) then
      FTMNGDISTRICT_0.Free;

   inherited;
end;

function TTMNGCOMPANY.GETCODE: String;
begin
   if FCODE.IsEmpty then
      FCODE := TGUID.NewGuid.ToString;

   Result := FCODE;
end;

initialization

TRegisterClass.RegisterEntity(TTMNGCOMPANY)

end.
