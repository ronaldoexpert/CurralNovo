unit untPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IniFiles, Registry, Dialogs, SUIButton, StdCtrls, ExtCtrls, DBCtrls, SUIDBCtrls,
  UCrpeClasses, UCrpe32, Buttons;

type
  TfrmPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    btnRelProprietario: TBitBtn;
    btnRelAnimais: TBitBtn;
    btnRelInseminacoes: TBitBtn;
    btnGraficos: TBitBtn;
    btnFechar: TBitBtn;
    pnlRodape: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnRelProprietarioClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    function LeRegWin(root: HKey; chave, valor: string): string;
    procedure GravaRegWin;
  public
    { Public declarations }
    vCaminhoBD : string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses untDM, untRelProprietarios;

{$R *.dfm}

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  vRede, vUser, vEmpresa,vEstrut, vUnidade : string;
begin
  if FileExists( ExtractFilePath( Application.ExeName ) + 'cfg.ini' ) then // Testa Existência do arquivo
  begin                    { ENDEREÇO DO ARQUIVO }                  { NOME }
    with  TIniFile.Create( ExtractFilePath( Application.ExeName ) + 'cfg.ini' ) do // Cria a estância do Objeto em Memória.
    begin                                { SEÇÃO }    { CHAVE }        { VALOR PADRAO}
      vCaminhoBD          := ReadString(  'CAMINHOS', 'BD'    , ''); // ReadString   - Lê um parâmetro como String;
      Free;
    end;
  end
  else
  begin
    ShowMessage( 'Arquivo Ini Não Encontrado!!!' );
  end;
  if vCaminhoBD <> '' then
    DM.sqlConnection.Params.Values['database'] :=  vCaminhoBD;

end;

procedure TfrmPrincipal.GravaRegWin;
var
 reg: TRegistry;
 ins: boolean;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  ins:=True;
  reg.OpenKey('Software\ODBC\ODBC.INI\CURRAL', True);
  if reg.ValueExists('Dbname') then
          if Reg.ReadString('Dbname') = vCaminhoBD then
                  ins:=False;
  if ins then
          reg.WriteString('Dbname', vCaminhoBD);
  reg.CloseKey;
  reg.Free;

end;

function TfrmPrincipal.LeRegWin(root: HKey; chave, valor: string): string;
var
   reg: TRegistry;
   ret: string;
begin
  ret:='';
  reg:=TRegistry.Create;
  reg.RootKey:=root;
  if reg.OpenKey(chave, False) then
          if reg.ValueExists(valor) then
                  ret:=Reg.ReadString(valor);
  reg.CloseKey;
  reg.Free;
  LeRegWin:=ret;

end;

procedure TfrmPrincipal.btnRelProprietarioClick(Sender: TObject);
begin
  GravaRegWin;
  frmRelProprietario := TfrmRelProprietario.Create(Self);
  try
    frmRelProprietario.ShowModal;
  finally
    frmRelProprietario.Release;
  end;
end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
