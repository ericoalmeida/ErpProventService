unit TSTOSINAPIPRODUCT.Entity.Model;

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
  TMNGUSER.Entity.Model;

type
  [Entity]
  [Table('TSTOSINAPIPRODUCT', '')]
  [PrimaryKey('COMPANYID, CODE', NotInc, NoSort, False, 'Chave primária')]
  TTSTOSINAPIPRODUCT = class
  private
    { Private declarations }
    FCOMPANYID: String;
    FCODE: String;
    FPRODUCTID: Integer;
    FCODE_SINAPI: String;
    FDESCRIPTION: String;
    FUNITMEASURE: String;
    FORIGINPRICE: String;
    FAVERAGEPRICE: Nullable<Double>;
    FAVERAGEPRICE_SINAPI: Double;
    FSTATUS: Integer;
    FUSERID: String;
    FCREATEDAT: TDateTime;
    FUPDATEDAT: TDateTime;

    FTMNGCOMPANY_0:  TTMNGCOMPANY  ;
    FTMNGUSER_1:  TTMNGUSER  ;
    function GETCODE: String;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    [Restrictions([NotNull])]
    [Column('COMPANYID', ftString, 64)]
    [ForeignKey('FK1_TSTOPRODUCT', 'COMPANYID', 'TMNGCOMPANY', 'CODE', SetNull, SetNull)]
    [Dictionary('COMPANYID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COMPANYID: String read FCOMPANYID write FCOMPANYID;

    [Restrictions([NotNull])]
    [Column('CODE', ftString, 64)]
    [Dictionary('CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE: String read GETCODE write FCODE;

    [Restrictions([NotNull])]
    [Column('PRODUCTID', ftInteger)]
    [Dictionary('PRODUCTID', 'Mensagem de validação', '', '', '', taCenter)]
    property PRODUCTID: Integer read FPRODUCTID write FPRODUCTID;

    [Column('CODE_SINAPI', ftString, 22)]
    [Dictionary('CODE_SINAPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CODE_SINAPI: String read FCODE_SINAPI write FCODE_SINAPI;

    [Restrictions([NotNull])]
    [Column('DESCRIPTION', ftString, 550)]
    [Dictionary('DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCRIPTION: String read FDESCRIPTION write FDESCRIPTION;

    [Restrictions([NotNull])]
    [Column('UNITMEASURE', ftString, 10)]
    [Dictionary('UNITMEASURE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UNITMEASURE: String read FUNITMEASURE write FUNITMEASURE;

    [Restrictions([NotNull])]
    [Column('ORIGINPRICE', ftString, 10)]
    [Dictionary('ORIGINPRICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORIGINPRICE: String read FORIGINPRICE write FORIGINPRICE;

    [Column('AVERAGEPRICE', ftBCD, 18, 4)]
    [Dictionary('AVERAGEPRICE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AVERAGEPRICE: Nullable<Double> read FAVERAGEPRICE write FAVERAGEPRICE;

    [Restrictions([NotNull])]
    [Column('AVERAGEPRICE_SINAPI', ftBCD, 18, 4)]
    [Dictionary('AVERAGEPRICE_SINAPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AVERAGEPRICE_SINAPI: Double read FAVERAGEPRICE_SINAPI write FAVERAGEPRICE_SINAPI;

    [Restrictions([NotNull])]
    [Column('STATUS', ftInteger)]
    [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taCenter)]
    property STATUS: Integer read FSTATUS write FSTATUS;

    [Restrictions([NotNull])]
    [Column('USERID', ftString, 64)]
    [ForeignKey('FK2_TSTOPRODUCT', 'USERID', 'TMNGUSER', 'CODE', SetNull, SetNull)]
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

    [Association(OneToOne,'USERID','TMNGUSER','CODE')]
    property TMNGUSER: TTMNGUSER read FTMNGUSER_1 write FTMNGUSER_1;

  end;

implementation

constructor TTSTOSINAPIPRODUCT.Create;
begin
  FTMNGCOMPANY_0 := TTMNGCOMPANY.Create;
  FTMNGUSER_1 := TTMNGUSER.Create;
end;

destructor TTSTOSINAPIPRODUCT.Destroy;
begin
  if Assigned(FTMNGCOMPANY_0) then
    FTMNGCOMPANY_0.Free;

  if Assigned(FTMNGUSER_1) then
    FTMNGUSER_1.Free;

  inherited;
end;

function TTSTOSINAPIPRODUCT.GETCODE: String;
begin
  if FCODE.IsEmpty then
  FCODE := TGUID.NewGuid.ToString;

  Result := FCODE;
end;

initialization
  TRegisterClass.RegisterEntity(TTSTOSINAPIPRODUCT)

end.
