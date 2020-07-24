unit TypeExpenseInsert.Controller;

interface

uses TypeExpense.Controller.Interf, TypeExpense.Model.Interf,
   TASSTYPEEXPENSE.Entity.Model,
   System.SysUtils;

type
   TTypeExpenseInsertController = class(TInterfacedObject,
     iTypeExpenseInsertController)
   private
      FTypeExpenseModel: iTypeExpenseModel;

      FCompanyId: string;
      FDescription: string;
      FStatus: Integer;
      FUserId: string;

      function getTypeExpenseId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iTypeExpenseInsertController;

      function typeExpenseModel(AValue: iTypeExpenseModel)
        : iTypeExpenseInsertController;

      function companyId(AValue: string): iTypeExpenseInsertController;
      function description(AValue: string): iTypeExpenseInsertController;
      function status(AValue: Integer): iTypeExpenseInsertController;
      function userId(AValue: string): iTypeExpenseInsertController;

      procedure save;
   end;

implementation

{ TTypeExpenseInsertController }

function TTypeExpenseInsertController.companyId(AValue: string)
  : iTypeExpenseInsertController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TTypeExpenseInsertController.Create;
begin

end;

function TTypeExpenseInsertController.description(AValue: string)
  : iTypeExpenseInsertController;
begin
   Result := Self;
   FDescription := AValue;
end;

destructor TTypeExpenseInsertController.Destroy;
begin

   inherited;
end;

class function TTypeExpenseInsertController.New: iTypeExpenseInsertController;
begin
   Result := Self.Create;
end;

function TTypeExpenseInsertController.getTypeExpenseId: Integer;
begin
   if FTypeExpenseModel.DAO.Find.Count <> 0 then
   begin
      Result := FTypeExpenseModel.DAO.FindWhere(Format('COMPANYID = %s',
        [QuotedStr(FCompanyId)]), 'TYPEEXPENSEID desc').Last.TYPEEXPENSEID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

procedure TTypeExpenseInsertController.save;
begin
   FTypeExpenseModel.Entity(TTASSTYPEEXPENSE.Create);

   FTypeExpenseModel.Entity.companyId := FCompanyId;
   FTypeExpenseModel.Entity.TYPEEXPENSEID := getTypeExpenseId;
   FTypeExpenseModel.Entity.description := FDescription;
   FTypeExpenseModel.Entity.status := FStatus;
   FTypeExpenseModel.Entity.userId := FUserId;
   FTypeExpenseModel.Entity.CREATEDAT := Now;
   FTypeExpenseModel.Entity.UPDATEDAT := Now;

   FTypeExpenseModel.DAO.Insert(FTypeExpenseModel.Entity);
end;

function TTypeExpenseInsertController.status(AValue: Integer)
  : iTypeExpenseInsertController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TTypeExpenseInsertController.typeExpenseModel
  (AValue: iTypeExpenseModel): iTypeExpenseInsertController;
begin
   Result := Self;
   FTypeExpenseModel := AValue;
end;

function TTypeExpenseInsertController.userId(AValue: string)
  : iTypeExpenseInsertController;
begin
   Result := Self;
   FUserId := AValue;
end;

end.
