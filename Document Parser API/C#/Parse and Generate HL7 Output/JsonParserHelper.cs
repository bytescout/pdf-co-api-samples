//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;

namespace HL7CreationFromJson
{
    class JsonParserHelper
    {
        /// <summary>
        /// Parse Json Fileds in class format
        /// </summary>
        public static JsonHL7Fields ParseJsonHL7Fields(string jsonData)
        {
            // Get Object data from input file
            JObject jsonObj = JObject.Parse(jsonData);

            var oRet = new JsonHL7Fields();

            oRet.LabName = Convert.ToString(jsonObj["fields"]["labName"]["value"]);

            oRet.PatientLastName = Convert.ToString(jsonObj["fields"]["patientLastName"]["value"]);
            oRet.PatientFirstName = Convert.ToString(jsonObj["fields"]["patientFirstName"]["value"]);
            oRet.PatientSSN = Convert.ToString(jsonObj["fields"]["patientSSN"]["value"]);
            oRet.PatientDOB = Convert.ToString(jsonObj["fields"]["patientDOB"]["value"]);
            oRet.PatientPhoneHome = Convert.ToString(jsonObj["fields"]["patientHomePhone"]["value"]);
            oRet.PatientPhoneWork = Convert.ToString(jsonObj["fields"]["patientWorkPhone"]["value"]);
            oRet.PatientAddress = Convert.ToString(jsonObj["fields"]["patientAddress"]["value"]);
            oRet.PatientChartNo = Convert.ToString(jsonObj["fields"]["patientChartNo"]["value"]);

            string patGenderMaleSelectedVal = Convert.ToString(jsonObj["fields"]["patientGenderMale"]["value"]);
            string patGenderFemaleSelectedVal = Convert.ToString(jsonObj["fields"]["patientGenderFemale"]["value"]);

            if (!string.IsNullOrEmpty(patGenderMaleSelectedVal))
            {
                oRet.PatientGender = "M";
            }
            else if (!string.IsNullOrEmpty(patGenderFemaleSelectedVal))
            {
                oRet.PatientGender = "F";
            }

            oRet.PhysicianName = Convert.ToString(jsonObj["fields"]["physicianName"]["value"]);
            oRet.PhysicianAccountNo = Convert.ToString(jsonObj["fields"]["physicianAccountName"]["value"]);
            oRet.PhysicianNpi = Convert.ToString(jsonObj["fields"]["physicianNPI"]["value"]);

            oRet.InsuranceName = Convert.ToString(jsonObj["fields"]["insuranceName"]["value"]);
            oRet.InsurancePolicy = Convert.ToString(jsonObj["fields"]["insurancePolicy"]["value"]);
            oRet.InsuranceGroup = Convert.ToString(jsonObj["fields"]["insuranceGroup"]["value"]);
            oRet.InsuredName = Convert.ToString(jsonObj["fields"]["insuredName"]["value"]);
            oRet.InsuredSSN = Convert.ToString(jsonObj["fields"]["insuredSSN"]["value"]);
            oRet.InsuredDob = Convert.ToString(jsonObj["fields"]["insuredDOB"]["value"]);

            string relToPatIsSelf = Convert.ToString(jsonObj["fields"]["relationToPatientIsSelf"]["value"]);
            string relToPatIsSpouse = Convert.ToString(jsonObj["fields"]["relationToPatientIsSpouse"]["value"]);
            string relToPatIsDependent = Convert.ToString(jsonObj["fields"]["relationToPatientIsDependent"]["value"]);

            if (!string.IsNullOrEmpty(relToPatIsSelf))
            {
                oRet.RelationToPatient = "Self";
            }
            else if (!string.IsNullOrEmpty(relToPatIsSpouse))
            {
                oRet.RelationToPatient = "Spouse";
            }
            else if (!string.IsNullOrEmpty(relToPatIsDependent))
            {
                oRet.RelationToPatient = "Dependent";
            }

            // Add Collection Date/Time
            string colDate = Convert.ToString(jsonObj["fields"]["collectionDate"]["value"]);
            string colTime = Convert.ToString(jsonObj["fields"]["collectionTime"]["value"]);
            string colTimeIsAm = Convert.ToString(jsonObj["fields"]["collectionTimeIsAM"]["value"]);
            string colTimeIsPm = Convert.ToString(jsonObj["fields"]["collectionTimeIsPM"]["value"]);

            string colTimeAmPm = "";
            if (!string.IsNullOrEmpty(colTimeIsAm))
            {
                colTimeAmPm = "AM";
            }
            else if (!string.IsNullOrEmpty(colTimeIsPm))
            {
                colTimeAmPm = "PM";
            }

            oRet.CollectionDateTime = $"{colDate} {colTime} {colTimeAmPm}";


            // Add ICD Codes
            string IcdCodes = Convert.ToString(jsonObj["fields"]["icD10DxCodes"]["value"]);
            if (!string.IsNullOrEmpty(IcdCodes))
            {
                var arrIcdCodes = IcdCodes.Split(',');

                foreach (var itmIcd in arrIcdCodes)
                {
                    oRet.Icd10Codes.Add(itmIcd.Trim());
                }
            }

            // Add Question/Answers
            string Ques_ClinicalHistoryIsRoutinePap = string.IsNullOrEmpty(Convert.ToString(jsonObj["fields"]["clinicalHistoryIsRoutinePap"]["value"])) ? "No" : "Yes";
            string Ques_ClinicalHistoryIsAbnormalBleeding = string.IsNullOrEmpty(Convert.ToString(jsonObj["fields"]["clinicalHistoryIsAbnormalBleeding"]["value"])) ? "No" : "Yes";

            oRet.QuestionAnswer.Add(new KeyValuePair<string, string>("Is Routine PAP?", Ques_ClinicalHistoryIsRoutinePap));
            oRet.QuestionAnswer.Add(new KeyValuePair<string, string>("Is Abnormal Bleeding?", Ques_ClinicalHistoryIsAbnormalBleeding));

            return oRet;
        }

    }
}
