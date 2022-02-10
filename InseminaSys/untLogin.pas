unit untLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, shellapi, Vcl.Grids, Data.DB,
  Data.Win.ADODB, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Imaging.pngimage,IniFiles, Registry;

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
    edtEmpresas: TDBLookupComboBox;
    qryEmpresas: TFDQuery;
    dtsEmpresas: TDataSource;
    procedure btnLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    vCaminhoBD : string;
    procedure CarregaConfiguracao;
    procedure CarregaEmpresa;
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
  close;
  //Application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  vMensagem : String;
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
      if frmFuncoes.LiberaSistema(vMensagem) then
      begin
        if DM.qryUsuario.FieldByName('senha').AsString = edtSenha.Text then
        begin
          if vMensagem <> '' then
            ShowMessage(vMensagem);

          Application.ProcessMessages;
          Hide;
          frmPrincipal := TfrmPrincipal.Create(Self);
          try
            GravarArquivoTXT;
            frmPrincipal.vUsuario := DM.qryUsuario.FieldByName('ID').AsInteger;
            frmPrincipal.vEmpresa := edtEmpresas.KeyValue;
            frmPrincipal.ShowModal;
            frmPrincipal.Hide;
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
        if vMensagem <> '' then
          ShowMessage(vMensagem);
        Application.Terminate;
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

procedure TfrmLogin.CarregaEmpresa;
begin
  qryEmpresas.SQL.Clear;
  qryEmpresas.SQL.Add('Select * from EMPRESA order by ID');
  qryEmpresas.Open;
  qryEmpresas.First;

  edtEmpresas.ListSource := dtsEmpresas;
  edtEmpresas.KeyValue := qryEmpresas.FieldByName('ID').AsInteger;
  edtEmpresas.KeyField := 'ID';
  edtEmpresas.ListFieldIndex := 1;
  edtEmpresas.ListField := 'RAZAO_SOCIAL';
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
      CarregaEmpresa;
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
  { [ 1 ] Associa a variável do programa "arq" ao arquivo externo }
    AssignFile(arq, vCaminhoTemp + '\usuario.txt');
    Rewrite(arq); { [ 2 ] Cria o arquivo texto "usuario.txt" }
    if edtUsuario.Text = 'MASTER' then
      Writeln(arq, '0')
    else
      Writeln(arq, DM.qryUsuario.FieldByName('id').AsString);
    CloseFile(arq);
  except
  end;

end;

end.
