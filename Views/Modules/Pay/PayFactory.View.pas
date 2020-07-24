unit PayFactory.View;

interface

uses PayFactory.View.Interf, Base.View.Interf, Types.Views;

type
   TPayFactoryView = class(TInterfacedObject, iPayFactoryView)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iPayFactoryView;

      function showProgramOfListing(AValue: TTypeListingPrograms)
        : iBaseListView;
      function showProgramOfRegister(AValue: TTypeRegisterPrograms)
        : iBaseRegisterView;
      function showProgramOfSearch(AValue: TTypeSearchPrograms)
        : IBaseSearchView;

   end;

implementation

{ TPayFactoryView }

uses PAY0001AView, PAY0001BView, PAY0001CView;

constructor TPayFactoryView.Create;
begin

end;

destructor TPayFactoryView.Destroy;
begin

   inherited;
end;

class function TPayFactoryView.New: iPayFactoryView;
begin
   Result := Self.Create;
end;

function TPayFactoryView.showProgramOfListing(AValue: TTypeListingPrograms)
  : iBaseListView;
begin
   case AValue of
      tpPAY0001AView:
         Result := TFPAY0001AView.New;
   end;
end;

function TPayFactoryView.showProgramOfRegister(AValue: TTypeRegisterPrograms)
  : iBaseRegisterView;
begin
   case AValue of
      trPAY0001BView:
         Result := TFPAY0001BView.New;
   end;
end;

function TPayFactoryView.showProgramOfSearch(AValue: TTypeSearchPrograms)
  : IBaseSearchView;
begin
   case AValue of
      tsPAY0001CView:
         Result := TFPAY0001CView.New;
   end;
end;

end.
