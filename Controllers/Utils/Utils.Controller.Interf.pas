unit Utils.Controller.Interf;

interface

type
   iUtilsController = interface
      ['{80A2C3E2-03AA-462A-B456-6E3FC4562F85}']
      function iff(AExpression: boolean; AWhenBeTrue: Integer;
        AWhenBeFalse: Integer): Integer; overload;
      function iff(AExpression: boolean; AWhenBeTrue: TDateTime;
        AWhenBeFalse: TDateTime): TDateTime; overload;
      function iff(AExpression: boolean; AWhenBeTrue: string;
        AWhenBeFalse: string): string; overload;
   end;

implementation

end.
