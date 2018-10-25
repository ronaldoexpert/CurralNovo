unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, shellapi, Vcl.Grids, Data.DB,
  Data.Win.ADODB, Vcl.DBGrids;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    btnCadProdutor: TBitBtn;
    btnVeterinario: TBitBtn;
    btnCadAnimal: TBitBtn;
    btnCadCria: TBitBtn;
    btnInseminacao: TBitBtn;
    btnSair: TBitBtn;
    MainMenu1: TMainMenu;
    Cadastro: TMenuItem;
    CadastrodeVeterinario: TMenuItem;
    CadastrodeProdutor: TMenuItem;
    CadastrodeAnimal: TMenuItem;
    CadastrodeCria: TMenuItem;
    CadastrodeServico: TMenuItem;
    CadastrodeProduto: TMenuItem;
    CadastrodeUsuario: TMenuItem;
    Movimentacao: TMenuItem;
    Inseminacao: TMenuItem;
    ConfirmaInseminacoes: TMenuItem;
    MovimentaEstoque: TMenuItem;
    Relatorios: TMenuItem;
    Sair1: TMenuItem;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    OpenDialog2: TOpenDialog;
    BitBtn2: TBitBtn;
    Configurao: TMenuItem;
    N1: TMenuItem;
    SuporteOnline1: TMenuItem;
    eamViewer1: TMenuItem;
    Utilitrios: TMenuItem;
    AjustanomesProprietarios: TMenuItem;
    Empresa1: TMenuItem;
    CncelaInseminaes1: TMenuItem;
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadastrodeVeterinarioClick(Sender: TObject);
    procedure CadastrodeProdutorClick(Sender: TObject);
    procedure CadastrodeAnimalClick(Sender: TObject);
    procedure CadastrodeCriaClick(Sender: TObject);
    procedure CadastrodeServicoClick(Sender: TObject);
    procedure CadastrodeProdutoClick(Sender: TObject);
    procedure CadastrodeUsuarioClick(Sender: TObject);
    procedure InseminacaoClick(Sender: TObject);
    procedure ConfirmaInseminacoesClick(Sender: TObject);
    procedure MovimentaEstoqueClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RelatoriosClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure eamViewer1Click(Sender: TObject);
    procedure ConfiguraoClick(Sender: TObject);
    procedure AjustanomesProprietariosClick(Sender: TObject);
    procedure Empresa1Click(Sender: TObject);
    procedure CncelaInseminaes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vUsuario, vEmpresa : Integer;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses unstCadastroVeterinario, untCadastroCria,
  untCadastroProduto, untCadastroProdutor, untCadastroServico,
  untCadastroUsuario, untConfirmaInseminacao, untInseminacao,
  untMovimentaEstoque, untLogin, untFuncoes, untDM, untConfiguracao,
  untRelatorioGraficos, untCadastroAnimal, untCadastroEmpresa,
  untCancelaInseminacao;

procedure TfrmPrincipal.AjustanomesProprietariosClick(Sender: TObject);
var
  vNome : string;
begin
  frmFuncoes.ExecutaSQL('Select * from PRODUTOR ORDER BY ID', 'Abrir', dm.qryAuxiliar);
  dm.qryAuxiliar.First;
  while not dm.qryAuxiliar.Eof do
  begin
    vNome := AnsiUpperCase(dm.qryAuxiliar.FieldByName('nome').AsString);
    dm.qryAuxiliar.Edit;
    dm.qryAuxiliar.FieldByName('nome').AsString := vNome;
    dm.qryAuxiliar.Post;
    dm.qryAuxiliar.ApplyUpdates(-1);
    dm.qryAuxiliar.Next;
  end;
  ShowMessage('Fim.');
end;

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
VAR
  txtVolumes : TextFile;
  quebra : TStringList;
  vNomeProdutor, arq : string;
begin
  dm.qryAuxiliar.Close;
  dm.qryAuxiliar.SQL.Clear;
  dm.qryAuxiliar.SQL.Add('Select * from PRODUTOR ORDER BY NOME');
  dm.qryAuxiliar.Open;

  OpenDialog2.FileName  :=  '';
  OpenDialog2.Title := 'Selecione o arquivo';
  OpenDialog2.DefaultExt := '*.CSV';
  OpenDialog2.Filter := 'Arquivos CSV (*.CSV)|*.CSV|TXT (*.TXT)|*.TXT|Todos os Arquivos (*.*)|*.*';
  OpenDialog2.InitialDir := extractfilepath(application.exename);
// ==================================== ABRE PESQUISA DE ARQUIVO .CSV ===================================
  if OpenDialog2.Execute then
  begin
    AssignFile(txtVolumes, OpenDialog2.FileName);
    Reset(txtVolumes);
    quebra := TStringList.Create;
    while not Eoln(txtVolumes) do
    begin
      quebra.Clear;
      Readln(txtVolumes, arq);
      ExtractStrings([';'],[],pchar(arq),quebra);
      vNomeProdutor := quebra.Strings[0];

      dm.qryAuxiliar.Insert;
      dm.qryAuxiliar.FieldByName('id').AsInteger := frmFuncoes.AutoIncre('PRODUTOR', 'Novo');
      dm.qryAuxiliar.FieldByName('nome').AsString := vNomeProdutor;
      dm.qryAuxiliar.FieldByName('situacao').AsString := 'Ativo';
      dm.qryAuxiliar.FieldByName('TIPO').AsString := 'F';
      dm.qryAuxiliar.FieldByName('usuario').AsInteger := vUsuario;
      dm.qryAuxiliar.FieldByName('alteracao').AsDateTime := Date+Time;
      dm.qryAuxiliar.Post;
      frmFuncoes.AutoIncre('PRODUTOR', 'Gravar');
    end;
    CloseFile(txtVolumes);
  end;


end;

procedure TfrmPrincipal.BitBtn2Click(Sender: TObject);
begin
  dm.qryAuxiliar.ApplyUpdates(-1);
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente sair do sistema?', 'Curral Novo', MB_YESNO) = mrYes then
  BEGIN
    Application.Terminate;
  END;
end;

procedure TfrmPrincipal.CadastrodeAnimalClick(Sender: TObject);
begin
  frmCadastroAnimal := TfrmCadastroAnimal.Create(Self);
  try
    frmCadastroAnimal.ShowModal;
  finally
    frmCadastroAnimal.Release;
  end;
end;

procedure TfrmPrincipal.CadastrodeCriaClick(Sender: TObject);
begin
  frmCadastroCria := TfrmCadastroCria.Create(Self);
  try
    frmCadastroCria.ShowModal;
  finally
    frmCadastroCria.Release;
  end;
end;

procedure TfrmPrincipal.CadastrodeProdutoClick(Sender: TObject);
begin
  frmCadastroProduto := TfrmCadastroProduto.Create(Self);
  try
    frmCadastroProduto.ShowModal;
  finally
    frmCadastroProduto.Release;
  end;
end;

procedure TfrmPrincipal.CadastrodeProdutorClick(Sender: TObject);
begin
  frmCadastroVeterinario:= TfrmCadastroVeterinario.Create(Self);
  try
    frmCadastroVeterinario.vTipoCadastro := 'Proprietario';
    frmCadastroVeterinario.ShowModal;
  finally
    frmCadastroVeterinario.Release;
  end;
end;

procedure TfrmPrincipal.CadastrodeServicoClick(Sender: TObject);
begin
  frmCadastroServico := TfrmCadastroServico.Create(Self);
  try
    frmCadastroServico.ShowModal;
  finally
    frmCadastroServico.Release;
  end;
end;

procedure TfrmPrincipal.CadastrodeUsuarioClick(Sender: TObject);
begin
  frmCadastroUsuario := TfrmCadastroUsuario.Create(Self);
  try
    frmCadastroUsuario.ShowModal;
  finally
    frmCadastroUsuario.Release;
  end;
end;

procedure TfrmPrincipal.CadastrodeVeterinarioClick(Sender: TObject);
begin
  frmCadastroVeterinario := TfrmCadastroVeterinario.Create(Self);
  try
    frmCadastroVeterinario.vTipoCadastro := 'Veterinario';
    frmCadastroVeterinario.ShowModal;
  finally
    frmCadastroVeterinario.Release;
  end;
end;

procedure TfrmPrincipal.CncelaInseminaes1Click(Sender: TObject);   //Versao 1.5.0 - 25/10/2018 - RS
begin
  frmCancelaInseminacao := TfrmCancelaInseminacao.Create(Self);   //Versao 1.5.0 - 25/10/2018 - RS
  try
    frmCancelaInseminacao.ShowModal;
  finally
    frmCancelaInseminacao.Release;
  end;
end;

procedure TfrmPrincipal.ConfiguraoClick(Sender: TObject);
begin
  frmConfiguracao := TfrmConfiguracao.Create(Self);
  try
    frmConfiguracao.ShowModal;
  finally
    frmConfiguracao.Release;
  end;
end;

procedure TfrmPrincipal.ConfirmaInseminacoesClick(Sender: TObject);
begin
  frmConfirmaInseminacao := TfrmConfirmaInseminacao.Create(Self);
  try
    frmConfirmaInseminacao.ShowModal;
  finally
    frmConfirmaInseminacao.Release;
  end;
end;

procedure TfrmPrincipal.eamViewer1Click(Sender: TObject);
begin
  ShellExecute(handle,'open',PChar('TeamViewerQS.exe'), '','',SW_SHOWNORMAL);
end;

procedure TfrmPrincipal.Empresa1Click(Sender: TObject);
begin
  frmCadastroEmpresa := TfrmCadastroEmpresa.Create(Self);
  try
    frmCadastroEmpresa.ShowModal;
  finally
    frmCadastroEmpresa.Release;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  btnSairClick(Self);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Caption := Caption + ' - ' + frmLogin.edtUsuario.Text + ' - Versao: ' + frmFuncoes.VersaoExe + ' (Beta)';
end;

procedure TfrmPrincipal.InseminacaoClick(Sender: TObject);
begin
  frmInseminacao := TfrmInseminacao.Create(Self);
  try
    frmInseminacao.ShowModal;
  finally
    frmInseminacao.Release;
  end;
end;

procedure TfrmPrincipal.MovimentaEstoqueClick(Sender: TObject);
begin
  frmMovimentaEstoque := TfrmMovimentaEstoque.Create(Self);
  try
    frmMovimentaEstoque.ShowModal;
  finally
    frmMovimentaEstoque.Release;
  end;
end;

procedure TfrmPrincipal.RelatoriosClick(Sender: TObject);
begin
  ShellExecute(handle,'open',PChar('ManagerReport.exe'), '','',SW_SHOWNORMAL);
end;

end.
