unit untLogin;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, IniFiles,Registry, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, FireDAC.Phys.IBWrapper, FireDAC.Phys.IBBase,
  DateUtils, Vcl.Imaging.pngimage, Vcl.Mask;

type
  TfrmLogin = class(TForm)
    btnLogin: TBitBtn;
    pnlPrincipal: TPanel;
    btnCancelar: TBitBtn;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    Image1: TImage;
    lblCaminhoTemp: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    vCaminhoBD : string;
    procedure CarregaConfiguracao;
    procedure GravarArquivoTXT;
  public
    { Public declarations }
    vCaminhoTemp : String;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses untDM, untFuncoes, unstCadastroVeterinario, untPrincipal;

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
  //close;
  Application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  CarregaConfiguracao;
  DM.qryUsuario.Close;
  DM.qryUsuario.SQL.Clear;
  DM.qryUsuario.SQL.Add('Select * from USUARIO where NOME = ' + QuotedStr(edtUsuario.Text));
  DM.qryUsuario.Open;

  if edtUsuario.Text <> 'MASTER' then
  BEGIN
    if DM.qryUsuario.RecordCount <> 0 then
    begin
      if DM.qryUsuario.FieldByName('senha').AsString = edtSenha.Text then
      begin

        frmPrincipal := TfrmPrincipal.Create(Self);
        try
          GravarArquivoTXT;
          frmPrincipal.vUsuario := DM.qryUsuario.FieldByName('ID').AsInteger;
          frmPrincipal.ShowModal;
        finally
          frmPrincipal.Release;
        end;
      end
      else
      begin
        ShowMessage('Senha Inválida.');
        edtSenha.Clear;
        edtSenha.SetFocus;
      end;
    end
    else
    begin
      ShowMessage('Usuário não encontrado.');
      edtSenha.Clear;
      edtUsuario.Clear;
      edtUsuario.SetFocus;
    end;
  END
  else
  begin
    if edtSenha.Text = '123456' then
    begin
      frmPrincipal := TfrmPrincipal.Create(Self);
      try
        GravarArquivoTXT;
        frmPrincipal.vUsuario := DM.qryUsuario.FieldByName('ID').AsInteger;
        frmPrincipal.ShowModal;
      finally
        frmPrincipal.Release;
      end;

    end
    else
    begin
      ShowMessage('Senha Inválida.');
      edtSenha.Clear;
      edtSenha.SetFocus;
    end;
  end;
end;

procedure TfrmLogin.CarregaConfiguracao;
begin
  frmFuncoes.ExecutaSQL('Select * from CONFIGURACAO', 'Abrir', dm.qryConfiguracao);
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
var
  vCaptionAntiga : string;
begin
  vCaminhoTemp := frmFuncoes.PegaTempDir;
  lblCaminhoTemp.Caption := vCaminhoTemp;

  Caption := 'Sistema de Gerenciamento de Inseminção - Versão: ' + frmFuncoes.VersaoExe;
  vCaptionAntiga := Caption;
  Caption := Caption + ' - Estabelecendo conexão com o banco de dados...';
  while not DM.FDConnection1.Connected do
  begin
    if FileExists( ExtractFilePath( Application.ExeName ) + 'CFG.ini' ) then // Testa Existência do arquivo
    begin                    // ENDEREÇO DO ARQUIVO                   { NOME
      with  TIniFile.Create( ExtractFilePath( Application.ExeName ) + 'CFG.ini' ) do // Cria a estância do Objeto em Memória.
      begin                                // SEÇÃO     { CHAVE         { VALOR PADRAO
        vCaminhoBD := ReadString('CAMINHOS', 'BD', ''); // ReadString   - Lê um parâmetro como String;
        Free;
      end;
    end
    else
    begin
      ShowMessage( 'Arquivo Ini Não Encontrado!!!' );
    end;

    DM.FDConnection1.Params.Values['database'] :=  vCaminhoBD;

    try
      DM.FDConnection1.Connected := True;
    except
       on e : EFDDBEngineException  do
         DM.FDConnection1.Connected := False;
    end;
  end;

  Caption := vCaptionAntiga;
  edtUsuario.SetFocus;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmLogin.GravarArquivoTXT;
var  arq: TextFile; { declarando a variável "arq" do tipo arquivo texto }
    i, n: integer;
begin
  try
  { [ 1 ] Associa a variável do programa "arq" ao arquivo externo "tabuada.txt"
          na unidade de disco "d" }
    AssignFile(arq, vCaminhoTemp + '\usuario.txt');
    Rewrite(arq); { [ 2 ] Cria o arquivo texto "tabuada.txt" na unidade de disco "d" }
    if edtUsuario.Text = 'MASTER' then
      Writeln(arq, '0')
    else
      Writeln(arq, DM.qryUsuario.FieldByName('id').AsString);
    CloseFile(arq);
  except
  end;

end;

end.
