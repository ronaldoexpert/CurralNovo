unit untDM;

interface

uses
  SysUtils, Classes, DB, SqlExpr, FMTBcd, DBClient, Provider, Data.DBXInterBase;

type
  TDM = class(TDataModule)
    sqlConnection: TSQLConnection;
    sqldtstProprietarios: TSQLDataSet;
    dtstprvdrProprietarios: TDataSetProvider;
    clntdtstProprietarios: TClientDataSet;
    dtsrcProprietarios: TDataSource;
    sqldtstPesquisa: TSQLDataSet;
    dtstprvdrPesquisa: TDataSetProvider;
    clntdtstPesquisa: TClientDataSet;
    dtsrcPesquisa: TDataSource;
    sqldtstAnimal: TSQLDataSet;
    dtstprvdrAnimal: TDataSetProvider;
    clntdtstAnimal: TClientDataSet;
    dtsrcAnimal: TDataSource;
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
