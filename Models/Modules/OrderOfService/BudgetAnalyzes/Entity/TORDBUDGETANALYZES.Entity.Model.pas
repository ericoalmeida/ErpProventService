unit TORDBUDGETANALYZES.Entity.Model;

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
  TMNGCOMPANY.Entity.Model, 
  TMNGPERSON.Entity.Model, 
  TORDBUDGET.Entity.Model,
  TSTOSINAPIPRODUCT.Entity.Model; 

type
  [Entity]
  [Table('TORDBUDGETANALYZES', '')]
  [PrimaryKey('COMPANYID, BUDGETID, PROVIDERSID, PRODUCTID', NotInc, NoSort, False, 'Chave primária')]
  TTORDBUDGETANALYZES = class
  private
    { Private declarations } 
    FCOMPANYID: String;
    FBUDGETID: String;
    FPROVIDERSID: String;
    FPRODUCTID: String;
    FPRICEUNITY: Nullable<Double>;
    FPRICETOTAL: Nullable<Double>;
    FUSERID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGCOMPANY_0:  TTMNGCOMPANY  ;
    FTMNGPERSON_1:  TTMNGPERSON  ;
    FTORDBUDGET_2:  TTORDBUDGET  ;
    FTSTOSINAPIPRODUCT_3:  TTSTOSINAPIPRODUCT  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('COMPANYID', ftString, 64)]
    [ForeignKey('FK_TORDBUDGETANALYZES_3', 'COMPANYID', 'TMNGPERSON', 'COMPANYID', SetNull, SetNull)]
    [ForeignKey('FK_TORDBUDGETANALYZES_2', 'COMPANYID', 'TORDBUDGET', 'COMPANYID', Cascade, Cascade)]
    [ForeignKey('FK_TORDBUDGETANALYZES_4', 'COMPANYID', 'TSTOSINAPIPRODUCT', 'COMPANYID', SetNull, SetNull)]
    [ForeignKey('FK_TORDBUDGETANALYZES_1', 'COMPANYID', 'TMNGCOMPANY', 'CODE', SetNull, SetNull)]
    [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COMPANYID: String read FCOMPANYID write FCOMPANYID;

    [Restrictions([NotNull])]
    [Column('BUDGETID', ftString, 64)]
    [Dictionary('BUDGETID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BUDGETID: String read FBUDGETID write FBUDGETID;

    [Restrictions([NotNull])]
    [Column('PROVIDERSID', ftString, 64)]
    [Dictionary('PROVIDERSID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PROVIDERSID: String read FPROVIDERSID write FPROVIDERSID;

    [Restrictions([NotNull])]
    [Column('PRODUCTID', ftString, 64)]
    [Dictionary('PRODUCTID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRODUCTID: String read FPRODUCTID write FPRODUCTID;

    [Column('PRICEUNITY', ftBCD)]
    [Dictionary('PRICEUNITY', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRICEUNITY: Nullable<Double> read FPRICEUNITY write FPRICEUNITY;

    [Column('PRICETOTAL', ftBCD)]
    [Dictionary('PRICETOTAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRICETOTAL: Nullable<Double> read FPRICETOTAL write FPRICETOTAL;

    [Restrictions([NotNull])]
    [Column('USERID', ftString, 64)]
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

    [Association(OneToOne,'COMPANYID','TMNGCOMPANY','CODE')]
    property TMNGCOMPANY: TTMNGCOMPANY read FTMNGCOMPANY_0 write FTMNGCOMPANY_0;

    [Association(OneToOne,'COMPANYID','TMNGPERSON','COMPANYID')]
    property TMNGPERSON: TTMNGPERSON read FTMNGPERSON_1 write FTMNGPERSON_1;

    [Association(OneToOne,'COMPANYID','TORDBUDGET','COMPANYID')]
    property TORDBUDGET: TTORDBUDGET read FTORDBUDGET_2 write FTORDBUDGET_2;

    [Association(OneToOne,'COMPANYID','TSTOSINAPIPRODUCT','COMPANYID')]
    property TSTOSINAPIPRODUCT: TTSTOSINAPIPRODUCT read FTSTOSINAPIPRODUCT_3 write FTSTOSINAPIPRODUCT_3;

  end;

implementation

constructor TTORDBUDGETANALYZES.Create;
begin
  FTMNGCOMPANY_0 := TTMNGCOMPANY.Create;
  FTMNGPERSON_1 := TTMNGPERSON.Create;
  FTORDBUDGET_2 := TTORDBUDGET.Create;
  FTSTOSINAPIPRODUCT_3 := TTSTOSINAPIPRODUCT.Create;
end;

destructor TTORDBUDGETANALYZES.Destroy;
begin
  if Assigned(FTMNGCOMPANY_0) then
    FTMNGCOMPANY_0.Free;

  if Assigned(FTMNGPERSON_1) then
    FTMNGPERSON_1.Free;

  if Assigned(FTORDBUDGET_2) then
    FTORDBUDGET_2.Free;

  if Assigned(FTSTOSINAPIPRODUCT_3) then
    FTSTOSINAPIPRODUCT_3.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TTORDBUDGETANALYZES)

end.
