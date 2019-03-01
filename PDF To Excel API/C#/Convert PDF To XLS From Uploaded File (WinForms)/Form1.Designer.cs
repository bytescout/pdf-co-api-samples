namespace PdfToExcelFrom
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.txtCloudAPIKey = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.txtInputPDFFileName = new System.Windows.Forms.TextBox();
            this.btnSelectInputFile = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.cmbOutputAs = new System.Windows.Forms.ComboBox();
            this.btnConvert = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.cmbConvertTo = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(165, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "ByteScout Cloud API Key";
            // 
            // txtCloudAPIKey
            // 
            this.txtCloudAPIKey.Location = new System.Drawing.Point(184, 14);
            this.txtCloudAPIKey.Name = "txtCloudAPIKey";
            this.txtCloudAPIKey.Size = new System.Drawing.Size(353, 22);
            this.txtCloudAPIKey.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 51);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(96, 17);
            this.label2.TabIndex = 2;
            this.label2.Text = "Input PDF File";
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            this.openFileDialog1.FileOk += new System.ComponentModel.CancelEventHandler(this.openFileDialog1_FileOk);
            // 
            // txtInputPDFFileName
            // 
            this.txtInputPDFFileName.Location = new System.Drawing.Point(115, 48);
            this.txtInputPDFFileName.Name = "txtInputPDFFileName";
            this.txtInputPDFFileName.Size = new System.Drawing.Size(290, 22);
            this.txtInputPDFFileName.TabIndex = 3;
            // 
            // btnSelectInputFile
            // 
            this.btnSelectInputFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 7F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSelectInputFile.Location = new System.Drawing.Point(411, 46);
            this.btnSelectInputFile.Name = "btnSelectInputFile";
            this.btnSelectInputFile.Size = new System.Drawing.Size(126, 36);
            this.btnSelectInputFile.TabIndex = 4;
            this.btnSelectInputFile.Text = "Select input File";
            this.btnSelectInputFile.UseVisualStyleBackColor = true;
            this.btnSelectInputFile.Click += new System.EventHandler(this.btnSelectInputFile_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(13, 133);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(71, 17);
            this.label3.TabIndex = 5;
            this.label3.Text = "Output As";
            // 
            // cmbOutputAs
            // 
            this.cmbOutputAs.FormattingEnabled = true;
            this.cmbOutputAs.Items.AddRange(new object[] {
            "URL to output file",
            "inline content"});
            this.cmbOutputAs.Location = new System.Drawing.Point(107, 133);
            this.cmbOutputAs.Name = "cmbOutputAs";
            this.cmbOutputAs.Size = new System.Drawing.Size(430, 24);
            this.cmbOutputAs.TabIndex = 6;
            // 
            // btnConvert
            // 
            this.btnConvert.Location = new System.Drawing.Point(16, 176);
            this.btnConvert.Name = "btnConvert";
            this.btnConvert.Size = new System.Drawing.Size(194, 43);
            this.btnConvert.TabIndex = 7;
            this.btnConvert.Text = "Convert";
            this.btnConvert.UseVisualStyleBackColor = true;
            this.btnConvert.Click += new System.EventHandler(this.btnConvert_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(13, 93);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(78, 17);
            this.label4.TabIndex = 8;
            this.label4.Text = "Convert To";
            // 
            // cmbConvertTo
            // 
            this.cmbConvertTo.FormattingEnabled = true;
            this.cmbConvertTo.Items.AddRange(new object[] {
            "XLS",
            "XLSX"});
            this.cmbConvertTo.Location = new System.Drawing.Point(107, 93);
            this.cmbConvertTo.Name = "cmbConvertTo";
            this.cmbConvertTo.Size = new System.Drawing.Size(430, 24);
            this.cmbConvertTo.TabIndex = 9;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(554, 255);
            this.Controls.Add(this.cmbConvertTo);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.btnConvert);
            this.Controls.Add(this.cmbOutputAs);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnSelectInputFile);
            this.Controls.Add(this.txtInputPDFFileName);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtCloudAPIKey);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Cloud API: PDF to Excel Conversion";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtCloudAPIKey;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.TextBox txtInputPDFFileName;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox cmbOutputAs;
        private System.Windows.Forms.Button btnConvert;
        private System.Windows.Forms.Button btnSelectInputFile;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox cmbConvertTo;
    }
}

