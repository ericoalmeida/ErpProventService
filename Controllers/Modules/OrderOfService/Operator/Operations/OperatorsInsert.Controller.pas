unit OperatorsInsert.Controller;

interface

uses Operators.Controller.Interf, Operators.Model.Interf,
   TORDOPERATOR.Entity.Model,
   System.SysUtils;

type
   TOperatorInsertController = class(TInterfacedObject,
     iOperatorInsertController)
   private
      FOperatorModel: IOperatorModel;

      FCompanyId: string;
      FName: string;
      FStatus: Integer;
      FUserId: string;

      function getOperatorId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iOperatorInsertController;

      function operatorModel(AValue: IOperatorModel): iOperatorInsertController;

      function companyId(AValue: string): iOperatorInsertController;
      function name(AValue: string): iOperatorInsertController;
      function status(AValue: Integer): iOperatorInsertController;
      function userId(AValue: string): iOperatorInsertController;

      procedure save;
   end;

implementation

{ TOperatorInsertController }

function TOperatorInsertController.companyId(AValue: string)
  : iOperatorInsertController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TOperatorInsertController.Create;
begin

end;

destructor TOperatorInsertController.Destroy;
begin

   inherited;
end;

class function TOperatorInsertController.New: iOperatorInsertController;
begin
   Result := Self.Create;
end;

function TOperatorInsertController.getOperatorId: Integer;
begin
   if FOperatorModel.DAO.Find.Count <> 0 then
   begin
      Result := FOperatorModel.DAO.FindWhere('', 'OPERATORID desc')
        .Last.OPERATORID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TOperatorInsertController.name(AValue: string)
  : iOperatorInsertController;
begin
   Result := Self;
   FName := AValue;
end;

procedure TOperatorInsertController.save;
begin
   FOperatorModel.Entity(TTORDOPERATOR.Create);

   FOperatorModel.Entity.companyId := FCompanyId;
   FOperatorModel.Entity.OPERATORID := getOperatorId;
   FOperatorModel.Entity.name := FName;
   FOperatorModel.Entity.status := FStatus;
   FOperatorModel.Entity.userId := FUserId;
   FOperatorModel.Entity.CREATEDAT := Now;
   FOperatorModel.Entity.UPDATEDAT := Now;

   FOperatorModel.DAO.Insert(FOperatorModel.Entity);
end;

function TOperatorInsertController.status(AValue: Integer)
  : iOperatorInsertController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TOperatorInsertController.userId(AValue: string)
  : iOperatorInsertController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TOperatorInsertController.operatorModel(AValue: IOperatorModel)
  : iOperatorInsertController;
begin
   Result := Self;
   FOperatorModel := AValue;
end;

end.
