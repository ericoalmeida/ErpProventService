unit TORDBUDGETPRODUCTS.Entity.Model;

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
  ormbr.mapping.attributes, 
  TSTOSINAPIPRODUCT.Entity.Model,
  TMNGUSER.Entity.Model, 
  TORDBUDGET.Entity.Model; 

type
  [Entity]
  [Table('TORDBUDGETPRODUCTS', '')]
  [PrimaryKey('COMPANYID, SEQUENCEPROD', NotInc, NoSort, False, 'Chave primária')]
  TTORDBUDGETPRODUCTS = class
  private
    { Private declarations } 
    FCOMPANYID: String;
    FSEQUENCEPROD: Integer;
    FBUDGETID: String;
    FPRODUCTID: String;
    FQTDE: Double;
    FUSERID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGUSER_0:  TTMNGUSER  ;
    FTORDBUDGET_1:  TTORDBUDGET  ;
    FTSTOSINAPIPRODUCT_2:  TTSTOSINAPIPRODUCT  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('COMPANYID', ftString, 64)]
    [ForeignKey('FK1_TORDBUDGETPRODUCTS', 'COMPANYID', 'TORDBUDGET', 'COMPANYID', Cascade, Cascade)]
    [ForeignKey('FK2_TORDBUDGETPRODUCTS', 'COMPANYID', 'TSTOSINAPIPRODUCT', 'COMPANYID', SetNull, SetNull)]
    [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COMPANYID: String read FCOMPANYID write FCOMPANYID;

    [Restrictions([NotNull])]
    [Column('SEQUENCEPROD', ftInteger)]
    [Dictionary('SEQUENCEPROD', 'Mensagem de validação', '', '', '', taCenter)]
    property SEQUENCEPROD: Integer read FSEQUENCEPROD write FSEQUENCEPROD;

    [Restrictions([NotNull])]
    [Column('BUDGETID', ftString, 64)]
    [Dictionary('BUDGETID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BUDGETID: String read FBUDGETID write FBUDGETID;

    [Restrictions([NotNull])]
    [Column('PRODUCTID', ftString, 64)]
    [Dictionary('PRODUCTID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRODUCTID: String read FPRODUCTID write FPRODUCTID;

    [Restrictions([NotNull])]
    [Column('QTDE', ftBCD)]
    [Dictionary('QTDE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property QTDE: Double read FQTDE write FQTDE;

    [Restrictions([NotNull])]
    [Column('USERID', ftString, 64)]
    [ForeignKey('FK3_TORDBUDGETPRODUCTS', 'USERID', 'TMNGUSER', 'CODE', SetNull, SetNull)]
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

    [Association(OneToOne,'USERID','TMNGUSER','CODE')]
    property TMNGUSER: TTMNGUSER read FTMNGUSER_0 write FTMNGUSER_0;

    [Association(OneToOne,'COMPANYID','TORDBUDGET','COMPANYID')]
    property TORDBUDGET: TTORDBUDGET read FTORDBUDGET_1 write FTORDBUDGET_1;

    [Association(OneToOne,'COMPANYID','TSTOSINAPIPRODUCT','COMPANYID')]
    property TSTOSINAPIPRODUCT: TTSTOSINAPIPRODUCT read FTSTOSINAPIPRODUCT_2 write FTSTOSINAPIPRODUCT_2;

  end;

implementation

constructor TTORDBUDGETPRODUCTS.Create;
begin
  FTMNGUSER_0 := TTMNGUSER.Create;
  FTORDBUDGET_1 := TTORDBUDGET.Create;
  FTSTOSINAPIPRODUCT_2 := TTSTOSINAPIPRODUCT.Create;
end;

destructor TTORDBUDGETPRODUCTS.Destroy;
begin
  if Assigned(FTMNGUSER_0) then
    FTMNGUSER_0.Free;

  if Assigned(FTORDBUDGET_1) then
    FTORDBUDGET_1.Free;

  if Assigned(FTSTOSINAPIPRODUCT_2) then
    FTSTOSINAPIPRODUCT_2.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TTORDBUDGETPRODUCTS)

end.
