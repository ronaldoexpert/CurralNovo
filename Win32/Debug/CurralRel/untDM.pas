unit untDM;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr;

type
  TDM = class(TDataModule)
    sqlConnection: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
