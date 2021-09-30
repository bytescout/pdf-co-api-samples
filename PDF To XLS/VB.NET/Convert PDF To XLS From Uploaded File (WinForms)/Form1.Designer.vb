<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.cmbConvertTo = New System.Windows.Forms.ComboBox()
        Me.label4 = New System.Windows.Forms.Label()
        Me.btnConvert = New System.Windows.Forms.Button()
        Me.cmbOutputAs = New System.Windows.Forms.ComboBox()
        Me.label3 = New System.Windows.Forms.Label()
        Me.btnSelectInputFile = New System.Windows.Forms.Button()
        Me.txtInputPDFFileName = New System.Windows.Forms.TextBox()
        Me.label2 = New System.Windows.Forms.Label()
        Me.txtCloudAPIKey = New System.Windows.Forms.TextBox()
        Me.label1 = New System.Windows.Forms.Label()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.SuspendLayout()
        '
        'cmbConvertTo
        '
        Me.cmbConvertTo.FormattingEnabled = True
        Me.cmbConvertTo.Items.AddRange(New Object() {"XLS", "XLSX"})
        Me.cmbConvertTo.Location = New System.Drawing.Point(116, 101)
        Me.cmbConvertTo.Name = "cmbConvertTo"
        Me.cmbConvertTo.Size = New System.Drawing.Size(430, 24)
        Me.cmbConvertTo.TabIndex = 19
        '
        'label4
        '
        Me.label4.AutoSize = True
        Me.label4.Location = New System.Drawing.Point(22, 101)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(78, 17)
        Me.label4.TabIndex = 18
        Me.label4.Text = "Convert To"
        '
        'btnConvert
        '
        Me.btnConvert.Location = New System.Drawing.Point(25, 184)
        Me.btnConvert.Name = "btnConvert"
        Me.btnConvert.Size = New System.Drawing.Size(194, 43)
        Me.btnConvert.TabIndex = 17
        Me.btnConvert.Text = "Convert"
        Me.btnConvert.UseVisualStyleBackColor = True
        '
        'cmbOutputAs
        '
        Me.cmbOutputAs.FormattingEnabled = True
        Me.cmbOutputAs.Items.AddRange(New Object() {"URL to output file", "inline content"})
        Me.cmbOutputAs.Location = New System.Drawing.Point(116, 141)
        Me.cmbOutputAs.Name = "cmbOutputAs"
        Me.cmbOutputAs.Size = New System.Drawing.Size(430, 24)
        Me.cmbOutputAs.TabIndex = 16
        '
        'label3
        '
        Me.label3.AutoSize = True
        Me.label3.Location = New System.Drawing.Point(22, 141)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(71, 17)
        Me.label3.TabIndex = 15
        Me.label3.Text = "Output As"
        '
        'btnSelectInputFile
        '
        Me.btnSelectInputFile.Font = New System.Drawing.Font("Microsoft Sans Serif", 7.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnSelectInputFile.Location = New System.Drawing.Point(420, 54)
        Me.btnSelectInputFile.Name = "btnSelectInputFile"
        Me.btnSelectInputFile.Size = New System.Drawing.Size(126, 36)
        Me.btnSelectInputFile.TabIndex = 14
        Me.btnSelectInputFile.Text = "Select input File"
        Me.btnSelectInputFile.UseVisualStyleBackColor = True
        '
        'txtInputPDFFileName
        '
        Me.txtInputPDFFileName.Location = New System.Drawing.Point(124, 56)
        Me.txtInputPDFFileName.Name = "txtInputPDFFileName"
        Me.txtInputPDFFileName.Size = New System.Drawing.Size(290, 22)
        Me.txtInputPDFFileName.TabIndex = 13
        '
        'label2
        '
        Me.label2.AutoSize = True
        Me.label2.Location = New System.Drawing.Point(22, 59)
        Me.label2.Name = "label2"
        Me.label2.Size = New System.Drawing.Size(96, 17)
        Me.label2.TabIndex = 12
        Me.label2.Text = "Input PDF File"
        '
        'txtCloudAPIKey
        '
        Me.txtCloudAPIKey.Location = New System.Drawing.Point(193, 22)
        Me.txtCloudAPIKey.Name = "txtCloudAPIKey"
        Me.txtCloudAPIKey.Size = New System.Drawing.Size(353, 22)
        Me.txtCloudAPIKey.TabIndex = 11
        '
        'label1
        '
        Me.label1.AutoSize = True
        Me.label1.Location = New System.Drawing.Point(22, 21)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(165, 17)
        Me.label1.TabIndex = 10
        Me.label1.Text = "ByteScout Cloud API Key"
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(594, 251)
        Me.Controls.Add(Me.cmbConvertTo)
        Me.Controls.Add(Me.label4)
        Me.Controls.Add(Me.btnConvert)
        Me.Controls.Add(Me.cmbOutputAs)
        Me.Controls.Add(Me.label3)
        Me.Controls.Add(Me.btnSelectInputFile)
        Me.Controls.Add(Me.txtInputPDFFileName)
        Me.Controls.Add(Me.label2)
        Me.Controls.Add(Me.txtCloudAPIKey)
        Me.Controls.Add(Me.label1)
        Me.Name = "Form1"
        Me.Text = "Cloud API: PDF to Excel Conversion"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Private WithEvents cmbConvertTo As ComboBox
    Private WithEvents label4 As Label
    Private WithEvents btnConvert As Button
    Private WithEvents cmbOutputAs As ComboBox
    Private WithEvents label3 As Label
    Private WithEvents btnSelectInputFile As Button
    Private WithEvents txtInputPDFFileName As TextBox
    Private WithEvents label2 As Label
    Private WithEvents txtCloudAPIKey As TextBox
    Private WithEvents label1 As Label
    Friend WithEvents OpenFileDialog1 As OpenFileDialog
End Class
