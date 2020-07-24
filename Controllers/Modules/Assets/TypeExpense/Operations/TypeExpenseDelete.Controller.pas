unit TypeExpenseDelete.Controller;

interface

uses TypeExpense.Controller.Interf, TASSTYPEEXPENSE.Entity.Model,
   TypeExpense.Model.Interf, Base.View.Interf;

type
   TTypeExpenseDeleteController = class(TInterfacedObject,
     iTypeExpenseDeleteController)
   private
      FMessageConfirm: iBaseMessageView;

      FTypeExpenseModel: iTypeExpenseModel;
      FSelectedRecord: TTASSTYPEEXPENSE;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iTypeExpenseDeleteController;

      function typeExpenseModel(AValue: iTypeExpenseModel)
        : iTypeExpenseDeleteController;
      function selectedRecord(AValue: TTASSTYPEEXPENSE)
        : iTypeExpenseDeleteController;

      procedure save;
   end;

implementation

{ TTypeExpenseDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TTypeExpenseDeleteController.Create;
begin
   FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
     (tmConfirmation);
end;

destructor TTypeExpenseDeleteController.Destroy;
begin

   inherited;
end;

function TTypeExpenseDeleteController.typeExpenseModel
  (AValue: iTypeExpenseModel): iTypeExpenseDeleteController;
begin
   Result := Self;
   FTypeExpenseModel := AValue;
end;

class function TTypeExpenseDeleteController.New: iTypeExpenseDeleteController;
begin
   Result := Self.Create;
end;

procedure TTypeExpenseDeleteController.save;
begin
   if FMessageConfirm.messages(Format('Deseja excluir o tipo %s ?',
     [FSelectedRecord.DESCRIPTION])).&end then
   begin

      try
         FTypeExpenseModel.DAO.Delete(FSelectedRecord);

      except
         on E: Exception do
            raise Exception.Create(Format('O tipo %s não pode ser excluído!',
              [FSelectedRecord.DESCRIPTION]));
      end;

   end;
end;

function TTypeExpenseDeleteController.selectedRecord(AValue: TTASSTYPEEXPENSE)
  : iTypeExpenseDeleteController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

end.
