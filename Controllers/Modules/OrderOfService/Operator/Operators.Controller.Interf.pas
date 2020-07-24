unit Operators.Controller.Interf;

interface

uses Operators.Model.Interf, TORDOPERATOR.Entity.Model;

type
   iOperatorInsertController = interface;
   iOperatorUpdateController = interface;
   iOperatorDeleteController = interface;
   iOperatorDuplicateController = interface;

   iOperatorController = interface
      function find(AValue: string): iOperatorController;
      function findById(AValue: string): iOperatorController;

      function insert: iOperatorInsertController;
      function update: iOperatorUpdateController;
      function delete: iOperatorDeleteController;
      function duplicate: iOperatorDuplicateController;

      function code: string;
      function operatorId: string;
      function name: string;
      function status: Integer;
      function createdAt: string;
      function updatedAt: string;
   end;

   iOperatorInsertController = interface
      function operatorModel(AValue: IOperatorModel): iOperatorInsertController;

      function companyId(AValue: string): iOperatorInsertController;
      function name(AValue: string): iOperatorInsertController;
      function status(AValue: Integer): iOperatorInsertController;
      function userId(AValue: string): iOperatorInsertController;

      procedure save;
   end;

   iOperatorUpdateController = interface
      function operatorModel(AValue: IOperatorModel): iOperatorUpdateController;
      function selectedRecord(AValue: TTORDOPERATOR): iOperatorUpdateController;

      function companyId(AValue: string): iOperatorUpdateController;
      function name(AValue: string): iOperatorUpdateController;
      function status(AValue: Integer): iOperatorUpdateController;
      function userId(AValue: string): iOperatorUpdateController;

      procedure save;
   end;

   iOperatorDeleteController = interface
      function operatorModel(AValue: IOperatorModel): iOperatorDeleteController;
      function selectedRecord(AValue: TTORDOPERATOR): iOperatorDeleteController;

      procedure save;
   end;

   iOperatorDuplicateController = interface
      function operatorModel(AValue: IOperatorModel)
        : iOperatorDuplicateController;

      function companyId(AValue: string): iOperatorDuplicateController;
      function name(AValue: string): iOperatorDuplicateController;
      function status(AValue: Integer): iOperatorDuplicateController;
      function userId(AValue: string): iOperatorDuplicateController;

      procedure save;
   end;

implementation

end.
