unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus, Vcl.ExtCtrls, Vcl.Menus, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Cadastro: TMenuItem;
    CadastrodeVeterinario: TMenuItem;
    CadastrodeAnimal: TMenuItem;
    CadastrodeCria: TMenuItem;
    CadastrodeServico: TMenuItem;
    CadastrodeProduto: TMenuItem;
    CadastrodeUsuario: TMenuItem;
    CadastrodeProdutor: TMenuItem;
    Sair1: TMenuItem;
    Movimentacao: TMenuItem;
    Inseminacao: TMenuItem;
    ConfirmaInseminacoes: TMenuItem;
    Relatorios: TMenuItem;
    Cadastrais: TMenuItem;
    Movimento: TMenuItem;
    CadastroTipoProdutor: TMenuItem;
    ToolBar1: TToolBar;
    btnSair: TBitBtn;
    btnCadProdutor: TBitBtn;
    btnCadAnimal: TBitBtn;
    btnCadCria: TBitBtn;
    btnInseminacao: TBitBtn;
    procedure Sair1Click(Sender: TObject);
    procedure CadastrodeVeterinarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CadastroTipoProdutorClick(Sender: TObject);
    procedure CadastrodeAnimalClick(Sender: TObject);
    procedure CadastrodeCriaClick(Sender: TObject);
    procedure CadastrodeServicoClick(Sender: TObject);
    procedure CadastrodeProdutoClick(Sender: TObject);
    procedure CadastrodeUsuarioClick(Sender: TObject);
    procedure CadastrodeProdutorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InseminacaoClick(Sender: TObject);
    procedure ConfirmaInseminacoesClick(Sender: TObject);
    procedure btnCadAnimalClick(Sender: TObject);
    procedure btnCadProdutorClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnCadCriaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vUsuario : Integer;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses untCadastroTipoProdutor, unstCadastroVeterinario, untCadastroAnimal,
  untCadastroCria, untCadastroProduto, untCadastroProdutor, untCadastroServico,
  untCadastroUsuario, untLogin, untInseminacao, untConfirmaInseminacao,
  untFuncoes;

procedure TfrmPrincipal.btnCadAnimalClick(Sender: TObject);
begin
  frmCadastroAnimal := TfrmCadastroAnimal.Create(Self);
  try
    frmCadastroAnimal.ShowModal;
  finally
    frmCadastroAnimal.Release;
  end;
end;

procedure TfrmPrincipal.btnCadCriaClick(Sender: TObject);
begin
  frmCadastroCria := TfrmCadastroCria.Create(Self);
  try
    frmCadastroCria.ShowModal;
  finally
    frmCadastroCria.Release;
  end;
end;

procedure TfrmPrincipal.btnCadProdutorClick(Sender: TObject);
begin
  frmCadastroVeterinario:= TfrmCadastroVeterinario.Create(Self);
  try
    frmCadastroVeterinario.vTipoCadastro := 'Produtor';
    frmCadastroVeterinario.ShowModal;
  finally
    frmCadastroVeterinario.Release;
  end;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente sair do sistema?', 'Curral Novo', MB_YESNO) = mrYes then
  BEGIN
    frmLogin.Close;
    close;
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
    frmCadastroVeterinario.vTipoCadastro := 'Produtor';
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

procedure TfrmPrincipal.CadastroTipoProdutorClick(Sender: TObject);
begin
  frmCadastroTipoProdutor := TfrmCadastroTipoProdutor.Create(Self);
  try
    frmCadastroTipoProdutor.ShowModal;
  finally
    frmCadastroTipoProdutor.Release;
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

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Sair1Click(Self);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  frmLogin.Hide;
  Caption := Caption + ' - ' + frmLogin.edtUsuario.Text + ' - Versao: ' + frmFuncoes.VersaoExe;
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

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente sair do sistema?', 'Curral Novo', MB_YESNO) = mrYes then
  BEGIN
    frmLogin.Close;
    close;
  END;
end;

end.
