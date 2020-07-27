unit TORDBUDGETPROVIDERS.Entity.Model;

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
   TORDBUDGET.Entity.Model,
   TMNGPERSON.Entity.Model,
   TMNGUSER.Entity.Model;

type

   [Entity]
   [Table('TORDBUDGETPROVIDERS', '')]
   [PrimaryKey('COMPANYID, SEQUENCEPROVIDER', NotInc, NoSort, False, 'Chave primária')]
   TTORDBUDGETPROVIDERS = class
   private
      { Private declarations }
      FCOMPANYID: String;
      FSEQUENCEPROVIDER: Integer;
      FBUDGETID: String;
      FPROVIDERID: String;
      FUSERID: String;
      FCREATEDAT: TDateTime;
      FUPDATEDAT: TDateTime;

      FTMNGPERSON_0: TTMNGPERSON;
      FTMNGUSER_1: TTMNGUSER;
      FTORDBUDGET_2: TTORDBUDGET;
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      [Restrictions([NotNull])]
      [Column('COMPANYID', ftString, 64)]
      [ForeignKey('FK_TORDBUDGETPROVIDERS_1', 'COMPANYID', 'TMNGPERSON', 'COMPANYID', SetNull, SetNull)]
      [ForeignKey('FK11_TORDBUDGETPROVIDERS', 'COMPANYID', 'TORDBUDGET', 'COMPANYID', Cascade, Cascade)]
      [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property COMPANYID: String read FCOMPANYID write FCOMPANYID;

      [Restrictions([NotNull])]
      [Column('SEQUENCEPROVIDER', ftInteger)]
      [Dictionary('SEQUENCEPROVIDER', 'Mensagem de validação', '', '', '', taCenter)]
      property SEQUENCEPROVIDER: Integer read FSEQUENCEPROVIDER write FSEQUENCEPROVIDER;

      [Restrictions([NotNull])]
      [Column('BUDGETID', ftString, 64)]
      [Dictionary('BUDGETID', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property BUDGETID: String read FBUDGETID write FBUDGETID;

      [Restrictions([NotNull])]
      [Column('PROVIDERID', ftString, 64)]
      [Dictionary('PROVIDERID', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property PROVIDERID: String read FPROVIDERID write FPROVIDERID;

      [Restrictions([NotNull])]
      [Column('USERID', ftString, 64)]
      [ForeignKey('FK_TORDBUDGETPROVIDERS_2', 'USERID', 'TMNGUSER', 'CODE', SetNull, SetNull)]
      [Dictionary('USERID', 'Mensagem de validação', '', '', '', taLeftJustify)]
      property USERID: String read FUSERID write FUSERID;

      [Restrictions([NotNull])]
      [Column('CREATEDAT', ftDateTime)]
      [Dictionary('CREATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
      property CREATEDAT: TDateTime read FCREATEDAT write FCREATEDAT;

      [Restrictions([NotNull])]
      [Column('UPDATEDAT', ftDateTime)]
      [Dictionary('UPDATEDAT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
      property UPDATEDAT: TDateTime read FUPDATEDAT write FUPDATEDAT;

      [Association(OneToOne, 'COMPANYID', 'TMNGPERSON', 'COMPANYID')]
      property TMNGPERSON: TTMNGPERSON read FTMNGPERSON_0 write FTMNGPERSON_0;

      [Association(OneToOne, 'USERID', 'TMNGUSER', 'CODE')]
      property TMNGUSER: TTMNGUSER read FTMNGUSER_1 write FTMNGUSER_1;

      [Association(OneToOne, 'COMPANYID', 'TORDBUDGET', 'COMPANYID')]
      property TORDBUDGET: TTORDBUDGET read FTORDBUDGET_2 write FTORDBUDGET_2;

   end;

implementation

constructor TTORDBUDGETPROVIDERS.Create;
begin
   FTMNGPERSON_0 := TTMNGPERSON.Create;
   FTMNGUSER_1 := TTMNGUSER.Create;
   FTORDBUDGET_2 := TTORDBUDGET.Create;
end;

destructor TTORDBUDGETPROVIDERS.Destroy;
begin
   if Assigned(FTMNGPERSON_0) then
      FTMNGPERSON_0.Free;

   if Assigned(FTMNGUSER_1) then
      FTMNGUSER_1.Free;

   if Assigned(FTORDBUDGET_2) then
      FTORDBUDGET_2.Free;

   inherited;
end;

initialization

TRegisterClass.RegisterEntity(TTORDBUDGETPROVIDERS)

end.
