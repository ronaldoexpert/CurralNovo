object frmRelProprietario: TfrmRelProprietario
  Left = 381
  Top = 250
  Width = 412
  Height = 177
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio de Propriet'#225'rios'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 396
    Height = 139
    Align = alClient
    TabOrder = 0
    object lblProprietario: TLabel
      Left = 16
      Top = 16
      Width = 53
      Height = 13
      Caption = 'Propriet'#225'rio'
    end
    object btnImprimir: TBitBtn
      Left = 184
      Top = 89
      Width = 89
      Height = 33
      Caption = '&Imprimir'
      TabOrder = 0
    end
    object btnFechar: TBitBtn
      Left = 280
      Top = 89
      Width = 89
      Height = 33
      Caption = '&Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
    object edtCodProprietario: TEdit
      Left = 16
      Top = 32
      Width = 57
      Height = 21
      TabOrder = 2
    end
    object edtDescrProprietario: TEdit
      Left = 115
      Top = 32
      Width = 257
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object btnPesquisa: TBitBtn
      Left = 74
      Top = 31
      Width = 35
      Height = 22
      Caption = '@'
      TabOrder = 4
    end
  end
end
