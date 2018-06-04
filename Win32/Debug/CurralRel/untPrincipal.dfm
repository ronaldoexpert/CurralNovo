object frmPrincipal: TfrmPrincipal
  Left = 398
  Top = 241
  Width = 386
  Height = 265
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rios - Curral Novo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 370
    Height = 186
    Align = alClient
    TabOrder = 0
    object btnRelProprietario: TBitBtn
      Left = 16
      Top = 16
      Width = 129
      Height = 41
      Caption = 'Propriet'#225'rio'
      TabOrder = 0
      OnClick = btnRelProprietarioClick
    end
    object btnRelAnimais: TBitBtn
      Left = 16
      Top = 72
      Width = 129
      Height = 41
      Caption = 'Animais'
      TabOrder = 1
    end
    object btnRelInseminacoes: TBitBtn
      Left = 208
      Top = 16
      Width = 129
      Height = 41
      Caption = 'Insemina'#231#245'es'
      TabOrder = 2
    end
    object btnGraficos: TBitBtn
      Left = 16
      Top = 136
      Width = 129
      Height = 41
      Caption = 'Gr'#225'ficos'
      TabOrder = 3
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 186
    Width = 370
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnFechar: TBitBtn
      Left = 256
      Top = 3
      Width = 81
      Height = 33
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
end
