## How to parse and generate hl7 output for src in C# with ByteScout Document Parser SDK

### Learn in simple ways: How to parse and generate hl7 output for src in C#

These source code samples are listed and grouped by their programming language and functions they use. ByteScout Document Parser SDK was designed to assist src in C#. ByteScout Document Parser SDK is the robost offline data extraction platform for template based data extraction and processing. Supports high load with millions of documents as input. Templates can be quickly created and updated with no special technical knowledge required.

This simple and easy to understand sample source code in C# for ByteScout Document Parser SDK contains different functions and options you should do calling the API to implement src.  This sample code in C# is all you need. Just copy-paste it to the code editor, then add a reference to ByteScout Document Parser SDK and you are ready to try it! You can use these C# sample examples in one or many applications.

Our website provides free trial version of ByteScout Document Parser SDK that gives source code samples to assist with your C# project.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=ByteScout%20Document%20Parser%20SDK%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=ByteScout%20Document%20Parser%20SDK%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore SDK Docs](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Documentation](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=MG5FfTWWSVE](https://www.youtube.com/watch?v=MG5FfTWWSVE)




<!-- code block begin -->

##### **Component.cs:**
    
```
using System;
using System.Collections.Generic;

/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public class Component : MessageElement
    {
        internal List<SubComponent> SubComponentList { get; set; }

        public bool IsSubComponentized { get; set; } = false;

        private bool isDelimiter = false;

        public Component(HL7Encoding encoding, bool isDelimiter = false)
        {
            this.isDelimiter = isDelimiter;
            this.SubComponentList = new List<SubComponent>();
            this.Encoding = encoding;
        }
        public Component(string pValue, HL7Encoding encoding)
        {
            this.SubComponentList = new List<SubComponent>();
            this.Encoding = encoding;
            this.Value = pValue;
        }

        protected override void ProcessValue()
        {
            List<string> allSubComponents;
            
            if (this.isDelimiter)
                allSubComponents = new List<string>(new [] {this.Value});
            else
                allSubComponents = MessageHelper.SplitString(_value, this.Encoding.SubComponentDelimiter);

            if (allSubComponents.Count > 1)
            {
                this.IsSubComponentized = true;
            }

            this.SubComponentList = new List<SubComponent>();

            foreach (string strSubComponent in allSubComponents)
            {
                SubComponent subComponent = new SubComponent(this.Encoding.Decode(strSubComponent), this.Encoding);
                SubComponentList.Add(subComponent);
            }
        }

        public SubComponent SubComponents(int position)
        {
            position = position - 1;
            SubComponent sub = null;

            try
            {
                sub = SubComponentList[position];
            }
            catch (Exception ex)
            {
                throw new HL7Exception("SubComponent not availalbe Error-" + ex.Message);
            }

            return sub;
        }

        public List<SubComponent> SubComponents()
        {
            return SubComponentList;
        }
    }

    internal class ComponentCollection : List<Component>
    {
        /// <summary>
        /// Component indexer
        /// </summary>
        internal new Component this[int index]
        {
            get
            {
                Component component = null;

                if (index < base.Count)
                    component = base[index];

                return component;
            }
            set
            {
                base[index] = value;
            }
        }

        /// <summary>
        /// Add Component at next position
        /// </summary>
        /// <param name="component">Component</param>
        internal new void Add(Component component)
        {
            base.Add(component);
        }

        /// <summary>
        /// Add component at specific position
        /// </summary>
        /// <param name="component">Component</param>
        /// <param name="position">Position</param>
        internal void Add(Component component, int position)
        {
            int listCount = base.Count;
            position = position - 1;

            if (position < listCount)
            {
                base[position] = component;
            }
            else
            {
                for (int comIndex = listCount; comIndex < position; comIndex++)
                {
                    Component blankComponent = new Component(component.Encoding);
                    blankComponent.Value = string.Empty;
                    base.Add(blankComponent);
                }

                base.Add(component);
            }
        }
    }
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **Encoding.cs:**
    
```
using System;
using System.Globalization;
using System.Text;

/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public class HL7Encoding
    {
        public string AllDelimiters { get; private set; } = @"|^~\&";
        public char FieldDelimiter { get; set; } = '|'; // \F\
        public char ComponentDelimiter { get; set; } = '^'; // \S\
        public char RepeatDelimiter { get; set; } = '~';  // \R\
        public char EscapeCharacter { get; set; } = '\\'; // \E\
        public char SubComponentDelimiter { get; set; } = '&'; // \T\
        public string SegmentDelimiter { get; set; } = "\r";
        public string PresentButNull { get; set; } = "\"\"";

        public HL7Encoding()
        {
        }

        public void EvaluateDelimiters(string delimiters)
        {
            this.FieldDelimiter = delimiters[0];
            this.ComponentDelimiter = delimiters[1];
            this.RepeatDelimiter = delimiters[2];
            this.EscapeCharacter = delimiters[3];
            this.SubComponentDelimiter = delimiters[4];
        }

        public void EvaluateSegmentDelimiter(string message)
        {
            string[] delimiters = new[] { "\r\n", "\n\r", "\r", "\n" };

            foreach (var delim in delimiters)
            {
                if (message.Contains(delim))
                {
                    this.SegmentDelimiter = delim;
                    return;
                }
            }

            throw new HL7Exception("Segment delimiter not found in message", HL7Exception.BAD_MESSAGE);
        }

        // Encoding methods based on https://github.com/elomagic/hl7inspector

        public  string Encode(string val)
        {
            if (val == null)
                return PresentButNull;

            if (string.IsNullOrWhiteSpace(val))
                return val;

            var sb = new StringBuilder();

            for (int i = 0; i < val.Length; i++) 
            {
                char c = val[i];

                if (c == this.ComponentDelimiter) {
                    sb.Append(this.EscapeCharacter);
                    sb.Append("S");
                    sb.Append(this.EscapeCharacter);
                } 
                else if (c == this.EscapeCharacter) {
                    sb.Append(this.EscapeCharacter);
                    sb.Append("E");
                    sb.Append(this.EscapeCharacter);
                } 
                else if (c == this.FieldDelimiter) {
                    sb.Append(this.EscapeCharacter);
                    sb.Append("F");
                    sb.Append(this.EscapeCharacter);
                } 
                else if (c == this.RepeatDelimiter) {
                    sb.Append(this.EscapeCharacter);
                    sb.Append("R");
                    sb.Append(this.EscapeCharacter);
                } 
                else if (c == this.SubComponentDelimiter) {
                    sb.Append(this.EscapeCharacter);
                    sb.Append("T");
                    sb.Append(this.EscapeCharacter);
                } 
                else if(c < 32) {
                    string v = string.Format("{0:X2}",(int)c);
                    if ((v.Length | 2) != 0) 
                        v = "0" + v;

                    sb.Append(this.EscapeCharacter);
                    sb.Append("X");
                    sb.Append(v);
                    sb.Append(this.EscapeCharacter);
                } 
                else {
                    sb.Append(c);
                }
            }

            return sb.ToString();
        }

        public string Decode(string encodedValue)
        {
            if (string.IsNullOrWhiteSpace(encodedValue))
                return encodedValue;

            var result = new StringBuilder();

            for (int i = 0; i < encodedValue.Length; i++)
            {
                char c = encodedValue[i];

                if (c != this.EscapeCharacter)
                {
                    result.Append(c);
                    continue;
                }

                i++;
                int li = encodedValue.IndexOf(this.EscapeCharacter, i);

                if (li == -1)
                    throw new HL7Exception("Invalid escape sequence in HL7 string");

                string seq = encodedValue.Substring(i, li-i);
                i = li;

                if (seq.Length == 0)
                    continue;
            
                switch (seq)
                {
                    case "H": // Start higlighting
                        result.Append("<B>");
                        break;
                    case "N": // normal text (end highlighting)
                        result.Append("</B>");
                        break;
                    case "F": // field separator
                        result.Append(this.FieldDelimiter);
                        break;
                    case "S": // component separator
                        result.Append(this.ComponentDelimiter);
                        break;
                    case "T": // subcomponent separator
                        result.Append(this.SubComponentDelimiter);
                        break;
                    case "R": // repetition separator
                        result.Append(this.RepeatDelimiter);
                        break;
                    case "E": // escape character
                        result.Append(this.EscapeCharacter);
                        break;
                    case ".br":
                        result.Append("<BR>");
                        break;
                    default:
                        if (seq.StartsWith("X"))
                            result.Append(((char)int.Parse(seq.Substring(1), NumberStyles.AllowHexSpecifier)));
                        else
                            result.Append(seq);
                        break;
                }
            }

            return result.ToString();
        }
    }
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **Field.cs:**
    
```
using System;
using System.Collections.Generic;
using System.Linq;

/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public class Field : MessageElement
    {
        private List<Field> _RepetitionList;

        internal ComponentCollection ComponentList { get; set; }

        public bool IsComponentized { get; set; } = false;
        public bool HasRepetitions { get; set; } = false;
        public bool IsDelimiters { get; set; } = false;

        internal List<Field> RepeatitionList
        {
            get
            {
                if (_RepetitionList == null)
                    _RepetitionList = new List<Field>();
                return _RepetitionList;
            }
            set
            {
                _RepetitionList = value;
            }
        }

        protected override void ProcessValue()
        {
            if (this.IsDelimiters)  // Special case for the delimiters fields (MSH)
            {
                var subcomponent = new SubComponent(_value, this.Encoding);

                this.ComponentList = new ComponentCollection();
                Component component = new Component(this.Encoding, true);

                component.SubComponentList.Add(subcomponent);

                this.ComponentList.Add(component);
                return;
            }

            this.HasRepetitions = _value.Contains(this.Encoding.RepeatDelimiter);

            if (this.HasRepetitions)
            {
                _RepetitionList = new List<Field>();
                List<string> individualFields = MessageHelper.SplitString(_value, this.Encoding.RepeatDelimiter);

                for (int index = 0; index < individualFields.Count; index++)
                {
                    Field field = new Field(individualFields[index], this.Encoding);
                    _RepetitionList.Add(field);
                }
            }
            else
            {
                List<string> allComponents = MessageHelper.SplitString(_value, this.Encoding.ComponentDelimiter);

                this.ComponentList = new ComponentCollection();

                foreach (string strComponent in allComponents)
                {
                    Component component = new Component(this.Encoding);
                    component.Value = strComponent;
                    this.ComponentList.Add(component);
                }

                this.IsComponentized = this.ComponentList.Count > 1;
            }
        }

        public Field(HL7Encoding encoding)
        {
            this.ComponentList = new ComponentCollection();
            this.Encoding = encoding;
        }

        public Field(string value, HL7Encoding encoding)
        {
            this.ComponentList = new ComponentCollection();
            this.Encoding = encoding;
            this.Value = value;
        }

        public bool AddNewComponent(Component com)
        {
            try
            {
                this.ComponentList.Add(com);
                return true;
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Unable to add new component Error - " + ex.Message);
            }
        }

        public bool AddNewComponent(Component component, int position)
        {
            try
            {
                this.ComponentList.Add(component, position);
                return true;
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Unable to add new component Error - " + ex.Message);
            }
        }

        public Component Components(int position)
        {
            position = position - 1;
            Component com = null;

            try
            {
                com = ComponentList[position];
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Component not available Error - " + ex.Message);
            }

            return com;
        }

        public List<Component> Components()
        {
            return ComponentList;
        }

        public List<Field> Repetitions()
        {
            if (this.HasRepetitions)
            {
                return _RepetitionList;
            }
            return null;
        }

        public Field Repetitions(int repeatitionNumber)
        {
            if (this.HasRepetitions)
            {
                return _RepetitionList[repeatitionNumber - 1];
            }
            return null;
        }
    }

    internal class FieldCollection : List<Field>
    {
        internal new Field this[int index]
        {
            get
            {
                Field field = null;

                if (index < base.Count)
                    field = base[index];

                return field;
            }
            set
            {
                base[index] = value;
            }
        }

        /// <summary>
        /// add field at next position
        /// </summary>
        /// <param name="field">Field</param>
        internal new void Add(Field field)
        {
            base.Add(field);
        }

        /// <summary>
        /// Add field at specific position
        /// </summary>
        /// <param name="field">Field</param>
        /// <param name="position">position</param>
        internal void Add(Field field, int position)
        {
            int listCount = base.Count;

            if (position < listCount)
            {
                base[position] = field;
            }
            else
            {
                for (int fieldIndex = listCount; fieldIndex < position; fieldIndex++)
                {
                    Field blankField = new Field(string.Empty, field.Encoding);
                    base.Add(blankField);
                }
                
                base.Add(field);
            }
        }
    }
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **HL7Exception.cs:**
    
```
using System;

/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public class HL7Exception : Exception
    {
        public const string REQUIRED_FIELD_MISSING = "Validation Error - Required field missing in message";
        public const string UNSUPPORTED_MESSAGE_TYPE = "Validation Error - Message Type Not Supported by this Implementation";
        public const string BAD_MESSAGE = "Validation Error - Bad Message";
        public const string PARSING_ERROR = "Parseing Error";
        public const string SERIALIZATION_ERROR = "Serialization Error";        
        
        public string ErrorCode { get; set; }

        public HL7Exception(string message) : base(message)
        {
        }

        public HL7Exception(string message, string Code) : base(message)
        {
            ErrorCode = Code;
        }

        public override string ToString()
        {
            return ErrorCode + " : " + Message;
        }
    }
}
```

<!-- code block end -->    

<!-- code block begin -->

##### **Message.cs:**
    
```
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public class Message
    {
        private List<string> allSegments = null;
        internal Dictionary<string, List<Segment>> SegmentList { get; set;} = new Dictionary<string, List<Segment>>();

        public string HL7Message { get; set; }
        public string Version { get; set; }
        public string MessageStructure { get; set; }
        public string MessageControlID { get; set; }
        public string ProcessingID { get; set; }
        public short SegmentCount { get; set; }
        public HL7Encoding Encoding { get; set; } = new HL7Encoding();

        public Message()
        {
        }

        public Message(string strMessage)
        {
            HL7Message = strMessage;
        }

        public override bool Equals(object obj)
        {
            if (obj is Message)
                return this.Equals((obj as Message).HL7Message);

            if (obj is string)
            {
                var arr1 = MessageHelper.SplitString(this.HL7Message, this.Encoding.SegmentDelimiter, StringSplitOptions.RemoveEmptyEntries);
                var arr2 = MessageHelper.SplitString(obj as string, this.Encoding.SegmentDelimiter, StringSplitOptions.RemoveEmptyEntries);

                return arr1.SequenceEqual(arr2);
            }

            return false;
        }

        public override int GetHashCode()
        {
            return this.HL7Message.GetHashCode();
        }

        /// <summary>
        /// Parse the HL7 message in text format, throws HL7Exception if error occurs
        /// </summary>
        /// <returns>boolean</returns>
        public bool ParseMessage()
        {
            bool isValid = false;
            bool isParsed = false;

            try
            {
                isValid = this.validateMessage();
            }
            catch (HL7Exception ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Unhandled Exception in validation - " + ex.Message, HL7Exception.BAD_MESSAGE);
            }

            if (isValid)
            {
                try
                {
                    if (this.allSegments == null || this.allSegments.Count <= 0)
                        this.allSegments = MessageHelper.SplitMessage(HL7Message);

                    short SegSeqNo = 0;

                    foreach (string strSegment in this.allSegments)
                    {
                        if (string.IsNullOrWhiteSpace(strSegment))
                            continue;

                        Segment newSegment = new Segment(this.Encoding);
                        string segmentName = strSegment.Substring(0, 3);
                        newSegment.Name = segmentName;
                        newSegment.Value = strSegment;
                        newSegment.SequenceNo = SegSeqNo++;

                        this.AddNewSegment(newSegment);
                    }

                    this.SegmentCount = SegSeqNo;

                    string strSerializedMessage = string.Empty;

                    try
                    {
                        strSerializedMessage = this.SerializeMessage(false); 
                    }
                    catch (HL7Exception ex)
                    {
                        throw new HL7Exception("Failed to serialize parsed message with error - " + ex.Message, HL7Exception.PARSING_ERROR);
                    }

                    if (!string.IsNullOrEmpty(strSerializedMessage))
                    {
                        if (this.Equals(strSerializedMessage))
                            isParsed = true;
                    }
                    else
                    {
                        throw new HL7Exception("Unable to serialize to original message - ", HL7Exception.PARSING_ERROR);
                    }
                }
                catch (Exception ex)
                {
                    throw new HL7Exception("Failed to parse the message with error - " + ex.Message, HL7Exception.PARSING_ERROR);
                }
            }
            
            return isParsed;
        }

        /// <summary>
        /// Serialize the message in text format
        /// </summary>
        /// <param name="validate">Validate the message before serializing</param>
        /// <returns>string with HL7 message</returns>
        public string SerializeMessage(bool validate)
        {
            if (validate && !this.validateMessage())
                throw new HL7Exception("Failed to validate the updated message", HL7Exception.BAD_MESSAGE);

            var strMessage = new StringBuilder();
            string currentSegName = string.Empty;
            List<Segment> _segListOrdered = getAllSegmentsInOrder();

            try
            {
                try
                {
                    foreach (Segment seg in _segListOrdered)
                    {
                        currentSegName = seg.Name;
                        strMessage.Append(seg.Name).Append(Encoding.FieldDelimiter);

                        int startField = currentSegName == "MSH" ? 1 : 0;

                        for (int i = startField; i<seg.FieldList.Count; i++)
                        {
                            if (i > startField)
                                strMessage.Append(Encoding.FieldDelimiter);

                            var field = seg.FieldList[i];

                            if (field.IsDelimiters)
                            {
                                strMessage.Append(field.Value);
                                continue;
                            }

                            if (field.HasRepetitions)
                            {
                                for (int j = 0; j < field.RepeatitionList.Count; j++)
                                {
                                    if (j > 0)
                                        strMessage.Append(Encoding.RepeatDelimiter);

                                    serializeField(field.RepeatitionList[j], strMessage);
                                }
                            }
                            else
                                serializeField(field, strMessage);
                        }
                        
                        strMessage.Append(Encoding.SegmentDelimiter);
                    }
                }
                catch (Exception ex)
                {
                    if (currentSegName == "MSH")
                        throw new HL7Exception("Failed to serialize the MSH segment with error - " + ex.Message, HL7Exception.SERIALIZATION_ERROR);
                    else 
                        throw;
                }

                return strMessage.ToString();
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Failed to serialize the message with error - " + ex.Message, HL7Exception.SERIALIZATION_ERROR);
            }
        }

        /// <summary>
        /// Get the Value of specific Field/Component/SubCpomponent, throws error if field/component index is not valid
        /// </summary>
        /// <param name="strValueFormat">Field/Component position in format SEGMENTNAME.FieldIndex.ComponentIndex.SubComponentIndex example PID.5.2</param>
        /// <returns>Value of specified field/component/subcomponent</returns>
        public string GetValue(string strValueFormat)
        {
            bool isValid = false;

            string segmentName = string.Empty;
            int fieldIndex = 0;
            int componentIndex = 0;
            int subComponentIndex = 0;
            int comCount = 0;
            string strValue = string.Empty;

            List<string> allComponents = MessageHelper.SplitString(strValueFormat, new char[] { '.' });
            comCount = allComponents.Count;

            isValid = validateValueFormat(allComponents);

            if (isValid)
            {
                segmentName = allComponents[0];

                if (SegmentList.ContainsKey(segmentName))
                {
                    if (comCount == 4)
                    {
                        Int32.TryParse(allComponents[1], out fieldIndex);
                        Int32.TryParse(allComponents[2], out componentIndex);
                        Int32.TryParse(allComponents[3], out subComponentIndex);

                        try
                        {
                            strValue = SegmentList[segmentName].First().FieldList[fieldIndex - 1].ComponentList[componentIndex - 1].SubComponentList[subComponentIndex - 1].Value;
                        }
                        catch (Exception ex)
                        {
                            throw new HL7Exception("SubComponent not available - " + strValueFormat + " Error: " + ex.Message);
                        }
                    }
                    else if (comCount == 3)
                    {
                        Int32.TryParse(allComponents[1], out fieldIndex);
                        Int32.TryParse(allComponents[2], out componentIndex);

                        try
                        {
                            strValue = SegmentList[segmentName].First().FieldList[fieldIndex - 1].ComponentList[componentIndex - 1].Value;
                        }
                        catch (Exception ex)
                        {
                            throw new HL7Exception("Component not available - " + strValueFormat + " Error: " + ex.Message);
                        }
                    }
                    else if (comCount == 2)
                    {
                        Int32.TryParse(allComponents[1], out fieldIndex);

                        try
                        {
                            strValue = SegmentList[segmentName].First().FieldList[fieldIndex - 1].Value;
                        }
                        catch (Exception ex)
                        {
                            throw new HL7Exception("Field not available - " + strValueFormat + " Error: " + ex.Message);
                        }
                    }
                    else
                    {
                        try
                        {
                            strValue = SegmentList[segmentName].First().Value;
                        }
                        catch (Exception ex)
                        {
                            throw new HL7Exception("Segment value not available - " + strValueFormat + " Error: " + ex.Message);
                        }
                    }
                }
                else
                {
                    throw new HL7Exception("Segment name not available: " + strValueFormat);
                }
            }
            else
            {
                throw new HL7Exception("Request format is not valid: " + strValueFormat);
            }

            return strValue;
        }

        /// <summary>
        /// Sets the Value of specific Field/Component/SubCpomponent, throws error if field/component index is not valid
        /// </summary>
        /// <param name="strValueFormat">Field/Component position in format SEGMENTNAME.FieldIndex.ComponentIndex.SubComponentIndex example PID.5.2</param>
        /// <param name="strValue">Value for the specified field/component</param>
        /// <returns>boolean</returns>
        public bool SetValue(string strValueFormat, string strValue)
        {
            bool isValid = false;
            bool isSet = false;

            string segmentName = string.Empty;
            int fieldIndex = 0;
            int componentIndex = 0;
            int subComponentIndex = 0;
            int comCount = 0;

            List<string> AllComponents = MessageHelper.SplitString(strValueFormat, new char[] { '.' });
            comCount = AllComponents.Count;

            isValid = validateValueFormat(AllComponents);

            if (isValid)
            {
                segmentName = AllComponents[0];
                if (SegmentList.ContainsKey(segmentName))
                {
                    if (comCount == 4)
                    {
                        Int32.TryParse(AllComponents[1], out fieldIndex);
                        Int32.TryParse(AllComponents[2], out componentIndex);
                        Int32.TryParse(AllComponents[3], out subComponentIndex);

                        try
                        {
                            SegmentList[segmentName].First().FieldList[fieldIndex - 1].ComponentList[componentIndex - 1].SubComponentList[subComponentIndex - 1].Value = strValue;
                            isSet = true;
                        }
                        catch (Exception ex)
                        {
                            throw new HL7Exception("SubComponent not available - " + strValueFormat + " Error: " + ex.Message);
                        }
                    }
                    else if (comCount == 3)
                    {
                        Int32.TryParse(AllComponents[1], out fieldIndex);
                        Int32.TryParse(AllComponents[2], out componentIndex);

                        try
                        {
                            SegmentList[segmentName].First().FieldList[fieldIndex - 1].ComponentList[componentIndex - 1].Value = strValue;
                            isSet = true;
                        }
                        catch (Exception ex)
                        {
                            throw new HL7Exception("Component not available - " + strValueFormat + " Error: " + ex.Message);
                        }
                    }
                    else if (comCount == 2)
                    {
                        Int32.TryParse(AllComponents[1], out fieldIndex);
                        try
                        {
                            SegmentList[segmentName].First().FieldList[fieldIndex - 1].Value = strValue;
                            isSet = true;
                        }
                        catch (Exception ex)
                        {
                            throw new HL7Exception("Field not available - " + strValueFormat + " Error: " + ex.Message);
                        }
                    }
                    else
                    {
                        throw new HL7Exception("Cannot overwrite a segment value");
                    }
                }
                else
                    throw new HL7Exception("Segment name not available");
            }
            else
                throw new HL7Exception("Request format is not valid");

            return isSet;
        }

        /// <summary>
        /// check if specified field has components
        /// </summary>
        /// <param name="strValueFormat">Field/Component position in format SEGMENTNAME.FieldIndex.ComponentIndex.SubComponentIndex example PID.5.2</param>
        /// <returns>boolean</returns>
        public bool IsComponentized(string strValueFormat)
        {
            bool isComponentized = false;
            bool isValid = false;

            string segmentName = string.Empty;
            int fieldIndex = 0;
            int comCount = 0;

            List<string> AllComponents = MessageHelper.SplitString(strValueFormat, new char[] { '.' });
            comCount = AllComponents.Count;

            isValid = validateValueFormat(AllComponents);

            if (isValid)
            {
                segmentName = AllComponents[0];
                if (comCount >= 2)
                {
                    try
                    {
                        Int32.TryParse(AllComponents[1], out fieldIndex);

                        isComponentized = SegmentList[segmentName].First().FieldList[fieldIndex - 1].IsComponentized;
                    }
                    catch (Exception ex)
                    {
                        throw new HL7Exception("Field not available - " + strValueFormat + " Error: " + ex.Message);
                    }
                }
                else
                    throw new HL7Exception("Field not identified in request");
            }
            else
                throw new HL7Exception("Request format is not valid");

            return isComponentized;
        }

        /// <summary>
        /// check if specified fields has repeatitions
        /// </summary>
        /// <param name="strValueFormat">Field/Component position in format SEGMENTNAME.FieldIndex.ComponentIndex.SubComponentIndex example PID.5.2</param>
        /// <returns>boolean</returns>
        public bool HasRepetitions(string strValueFormat)
        {
            bool hasRepetitions = false;
            bool isValid = false;

            string segmentName = string.Empty;
            int fieldIndex = 0;
            int comCount = 0;

            List<string> AllComponents = MessageHelper.SplitString(strValueFormat, new char[] { '.' });
            comCount = AllComponents.Count;

            isValid = validateValueFormat(AllComponents);

            if (isValid)
            {
                segmentName = AllComponents[0];
                if (comCount >= 2)
                {
                    try
                    {
                        Int32.TryParse(AllComponents[1], out fieldIndex);

                        hasRepetitions = SegmentList[segmentName].First().FieldList[fieldIndex - 1].HasRepetitions;
                    }
                    catch (Exception ex)
                    {
                        throw new HL7Exception("Field not available - " + strValueFormat + " Error: " + ex.Message);
                    }
                }
                else
                    throw new HL7Exception("Field not identified in request");
            }
            else
                throw new HL7Exception("Request format is not valid");

            return hasRepetitions;
        }

        /// <summary>
        /// check if specified component has sub components
        /// </summary>
        /// <param name="strValueFormat">Field/Component position in format SEGMENTNAME.FieldIndex.ComponentIndex.SubComponentIndex example PID.5.2</param>
        /// <returns>boolean</returns>
        public bool IsSubComponentized(string strValueFormat)
        {
            bool isSubComponentized = false;
            bool isValid = false;

            string segmentName = string.Empty;
            int fieldIndex = 0;
            int componentIndex = 0;
            int comCount = 0;

            List<string> AllComponents = MessageHelper.SplitString(strValueFormat, new char[] { '.' });
            comCount = AllComponents.Count;

            isValid = validateValueFormat(AllComponents);

            if (isValid)
            {
                segmentName = AllComponents[0];

                if (comCount >= 3)
                {
                    try
                    {
                        Int32.TryParse(AllComponents[1], out fieldIndex);
                        Int32.TryParse(AllComponents[2], out componentIndex);
                        isSubComponentized = SegmentList[segmentName].First().FieldList[fieldIndex - 1].ComponentList[componentIndex - 1].IsSubComponentized;
                    }
                    catch (Exception ex)
                    {
                        throw new HL7Exception("Component not available - " + strValueFormat + " Error: " + ex.Message);
                    }
                }
                else
                    throw new HL7Exception("Component not identified in request");
            }
            else
                throw new HL7Exception("Request format is not valid");

            return isSubComponentized;
        }

        /// <summary>
        /// Builds the acknowledgement message for this message
        /// </summary>
        /// <returns>An ACK message if success, otherwise null</returns>
        public Message GetACK()
        {
            return this.createAckMessage("AA", false, null);
        }

        /// <summary>
        /// Builds a negative ack for this message
        /// </summary>
        /// <param name="code">ack code like AR, AE</param>
        /// <param name="errMsg">Error message to be sent with NACK</param>
        /// <returns>A NACK message if success, otherwise null</returns>
        public Message GetNACK(string code, string errMsg)
        {
            return this.createAckMessage(code, true, errMsg);
        }

        /// <summary>
        /// Adds a segemnt to the message
        /// </summary>
        /// <param name="newSegment">Segment to be appended to the end of the message</param>
        /// <returns>True if added sucessfully, otherwise false</returns>
        public bool AddNewSegment(Segment newSegment)
        {
            try
            {
                newSegment.SequenceNo = SegmentCount++;

                if (!SegmentList.ContainsKey(newSegment.Name))
                    SegmentList[newSegment.Name] = new List<Segment>();

                SegmentList[newSegment.Name].Add(newSegment);
                return true;
            }
            catch (Exception ex)
            {
                SegmentCount--;
                throw new HL7Exception("Unable to add new segment. Error - " + ex.Message);
            }
        }

        /// <summary>
        /// Removes a segment from the message
        /// </summary>
        /// <param name="segmentName">Segment to be removed/param>
        /// <param name="index">Zero-based index of the sement to be removed, in case of multiple. Default is 0.</param>
        /// <returns>True if found and removed sucessfully, otherwise false</returns>
        public bool RemoveSegment(string segmentName, int index = 0) 
        {
            try
            {
                if (!SegmentList.ContainsKey(segmentName))
                    return false;

                var list = SegmentList[segmentName];
                if (list.Count <= index)
                    return false;

                list.RemoveAt(index);
                return true;
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Unable to add remove segment. Error - " + ex.Message);
            }
        }

        public List<Segment> Segments()
        {
            return getAllSegmentsInOrder();
        }

        public List<Segment> Segments(string segmentName)
        {
            return getAllSegmentsInOrder().FindAll(o=> o.Name.Equals(segmentName));
        }

        public Segment DefaultSegment(string segmentName)
        {
            return getAllSegmentsInOrder().First(o => o.Name.Equals(segmentName));
        }

        /// <summary>
        /// Addsthe header segment to a new message
        /// </summary>
        /// <param name="sendingApplication">Sending application name</param>
        /// <param name="sendingFacility">Sending facility name</param>
        /// <param name="receivingApplication">Receiving application name</param>
        /// <param name="receivingFacility">Receiving facility name</param>
        /// <param name="security">Security features. Can be null.</param>
        /// <param name="messageType">Message type ^ trigger event</param>
        /// <param name="messageControlID">Message control unique ID</param>
        /// <param name="processingID">Processing ID ^ processing mode</param>
        /// <param name="version">HL7 message version (2.x)</param>
        public void AddSegmentMSH(string sendingApplication, string sendingFacility, string receivingApplication, string receivingFacility,
            string security, string messageType, string messageControlID, string processingID, string version)
        {
                var dateString = MessageHelper.LongDateWithFractionOfSecond(DateTime.Now);
                var delim = this.Encoding.FieldDelimiter;

                string response = "MSH" + this.Encoding.AllDelimiters + delim + sendingApplication + delim + sendingFacility + delim 
                    + receivingApplication + delim + receivingFacility + delim
                    + dateString + delim + (security ?? string.Empty) + delim + messageType + delim + messageControlID + delim 
                    + processingID + delim + version + this.Encoding.SegmentDelimiter;

                var message = new Message(response);
                message.ParseMessage();
                this.AddNewSegment(message.DefaultSegment("MSH"));
        }

        /// <summary>
        /// Serialize to MLLP escaped byte array
        /// </summary>
        /// <param name="validate">Optional. Validate the message before serializing</param>
        /// <returns>MLLP escaped byte array</returns>
        public byte[] GetMLLP(bool validate = false)
        {
            string hl7 = this.SerializeMessage(validate);

            return MessageHelper.GetMLLP(hl7);
        }
        
        /// <summary>
        /// Builds an ACK or NACK message for this message
        /// </summary>
        /// <param name="code">ack code like AA, AR, AE</param>
        /// <param name="isNack">true for generating a NACK message, otherwise false</param>
        /// <param name="errMsg">error message to be sent with NACK</param>
        /// <returns>An ACK or NACK message if success, otherwise null</returns>
        private Message createAckMessage(string code, bool isNack, string errMsg)
        {
            var response = new StringBuilder();

            if (this.MessageStructure != "ACK")
            {
                var dateString = MessageHelper.LongDateWithFractionOfSecond(DateTime.Now);
                var msh = this.SegmentList["MSH"].First();
                var delim = this.Encoding.FieldDelimiter;
                
                response.Append("MSH").Append(this.Encoding.AllDelimiters).Append(delim).Append(msh.FieldList[4].Value).Append(delim).Append(msh.FieldList[5].Value).Append(delim)
                    .Append(msh.FieldList[2].Value).Append(delim).Append(msh.FieldList[3].Value).Append(delim)
                    .Append(dateString).Append(delim).Append(delim).Append("ACK").Append(delim).Append(this.MessageControlID).Append(delim)
                    .Append(this.ProcessingID).Append(delim).Append(this.Version).Append(this.Encoding.SegmentDelimiter);
                
                response.Append("MSA").Append(delim).Append(code).Append(delim).Append(this.MessageControlID).Append((isNack ? delim + errMsg : string.Empty)).Append(this.Encoding.SegmentDelimiter);
            }
            else
            {
                return null;
            }

            try 
            {
                var message = new Message(response.ToString());
                message.ParseMessage();
                return message;
            }
            catch 
            {
                return null;
            }
        }

        /// <summary>
        /// Validates the HL7 message for basic syntax
        /// </summary>
        /// <returns>A boolean indicating whether the whole message is valid or not</returns>
        private bool validateMessage()
        {
            try
            {
                if (!string.IsNullOrEmpty(HL7Message))
                {
                    //check message length - MSH+Delimeters+12Fields in MSH
                    if (HL7Message.Length < 20)
                    {
                        throw new HL7Exception("Message Length too short: " + HL7Message.Length + " chars.", HL7Exception.BAD_MESSAGE);
                    }

                    //check if message starts with header segment
                    if (!HL7Message.StartsWith("MSH"))
                    {
                        throw new HL7Exception("MSH segment not found at the beggining of the message", HL7Exception.BAD_MESSAGE);
                    }

                    this.Encoding.EvaluateSegmentDelimiter(this.HL7Message);
                    this.HL7Message = string.Join(this.Encoding.SegmentDelimiter, MessageHelper.SplitMessage(this.HL7Message)) + this.Encoding.SegmentDelimiter;

                    //check Segment Name & 4th character of each segment
                    char fourthCharMSH = HL7Message[3];
                    this.allSegments = MessageHelper.SplitMessage(HL7Message);

                    foreach (string strSegment in this.allSegments)
                    {
                        if (string.IsNullOrWhiteSpace(strSegment))
                            continue;

                        bool isValidSegName = false;
                        string segmentName = strSegment.Substring(0, 3);
                        string segNameRegEx = "[A-Z][A-Z][A-Z1-9]";
                        isValidSegName = System.Text.RegularExpressions.Regex.IsMatch(segmentName, segNameRegEx);

                        if (!isValidSegName)
                        {
                            throw new HL7Exception("Invalid segment name found: " + strSegment, HL7Exception.BAD_MESSAGE);
                        }

                        char fourthCharSEG = strSegment[3];

                        if (fourthCharMSH != fourthCharSEG)
                        {
                            throw new HL7Exception("Invalid segment found: " + strSegment, HL7Exception.BAD_MESSAGE);
                        }
                    }

                    string _fieldDelimiters_Message = this.allSegments[0].Substring(3, 8 - 3);
                    this.Encoding.EvaluateDelimiters(_fieldDelimiters_Message);

                    // Count field separators, MSH.12 is required so there should be at least 11 field separators in MSH
                    int countFieldSepInMSH = this.allSegments[0].Count(f => f == Encoding.FieldDelimiter);

                    if (countFieldSepInMSH < 11)
                    {
                        throw new HL7Exception("MSH segment doesn't contain all the required fields", HL7Exception.BAD_MESSAGE);
                    }

                    // Find Message Version
                    var MSHFields = MessageHelper.SplitString(this.allSegments[0], Encoding.FieldDelimiter);

                    if (MSHFields.Count >= 12)
                    {
                        this.Version = MessageHelper.SplitString(MSHFields[11], Encoding.ComponentDelimiter)[0];
                    }
                    else
                    {
                        throw new HL7Exception("HL7 version not found in the MSH segment", HL7Exception.REQUIRED_FIELD_MISSING);
                    }

                    //Find Message Type & Trigger Event
                    try
                    {
                        string MSH_9 = MSHFields[8];

                        if (!string.IsNullOrEmpty(MSH_9))
                        {
                            var MSH_9_comps = MessageHelper.SplitString(MSH_9, this.Encoding.ComponentDelimiter);

                            if (MSH_9_comps.Count >= 3)
                            {
                                this.MessageStructure = MSH_9_comps[2];
                            }
                            else if (MSH_9_comps.Count > 0 && MSH_9_comps[0] != null && MSH_9_comps[0].Equals("ACK"))
                            {
                                this.MessageStructure = "ACK";
                            }
                            else if (MSH_9_comps.Count == 2)
                            {
                                this.MessageStructure = MSH_9_comps[0] + "_" + MSH_9_comps[1];
                            }
                            else
                            {
                                throw new HL7Exception("Message Type & Trigger Event value not found in message", HL7Exception.UNSUPPORTED_MESSAGE_TYPE);
                            }
                        }
                        else
                            throw new HL7Exception("MSH.10 not available", HL7Exception.UNSUPPORTED_MESSAGE_TYPE);
                    }
                    catch (System.IndexOutOfRangeException e)
                    {
                        throw new HL7Exception("Can't find message structure (MSH.9.3) - " + e.Message, HL7Exception.UNSUPPORTED_MESSAGE_TYPE);
                    }

                    try
                    {
                        this.MessageControlID = MSHFields[9];

                        if (string.IsNullOrEmpty(this.MessageControlID))
                            throw new HL7Exception("MSH.10 - Message Control ID not found", HL7Exception.REQUIRED_FIELD_MISSING);
                    }
                    catch (Exception ex)
                    {
                        throw new HL7Exception("Error occured while accessing MSH.10 - " + ex.Message, HL7Exception.REQUIRED_FIELD_MISSING);
                    }

                    try
                    {
                        this.ProcessingID = MSHFields[10];

                        if (string.IsNullOrEmpty(this.ProcessingID))
                            throw new HL7Exception("MSH.11 - Processing ID not found", HL7Exception.REQUIRED_FIELD_MISSING);
                    }
                    catch (Exception ex)
                    {
                        throw new HL7Exception("Error occured while accessing MSH.11 - " + ex.Message, HL7Exception.REQUIRED_FIELD_MISSING);
                    }
                }
                else
                    throw new HL7Exception("No Message Found", HL7Exception.BAD_MESSAGE);
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Failed to validate the message with error - " + ex.Message, HL7Exception.BAD_MESSAGE);
            }

            return true;
        }

        /// <summary>
        /// Serializes a field into a string with proper encoding
        /// </summary>
        /// <returns>A serialized string</returns>
        private void serializeField(Field field, StringBuilder strMessage)
        {
            if (field.ComponentList.Count > 0)
            {
                int indexCom = 0;

                foreach (Component com in field.ComponentList)
                {
                    indexCom++;
                    if (com.SubComponentList.Count > 0)
                        strMessage.Append(string.Join(Encoding.SubComponentDelimiter.ToString(), com.SubComponentList.Select(sc => Encoding.Encode(sc.Value))));
                    else
                        strMessage.Append(Encoding.Encode(com.Value));

                    if (indexCom < field.ComponentList.Count)
                        strMessage.Append(Encoding.ComponentDelimiter);
                }
            }
            else
                strMessage.Append(Encoding.Encode(field.Value));

        }

        /// <summary> 
        /// Get all segments in order as they appear in original message. This the usual order: IN1|1 IN2|1 IN1|2 IN2|2
        /// </summary>
        /// <returns>A list of segments in the proper order</returns>
        private List<Segment> getAllSegmentsInOrder()
        {
            List<Segment> _list = new List<Segment>();

            foreach (string segName in SegmentList.Keys)
            {
                foreach (Segment seg in SegmentList[segName])
                {
                    _list.Add(seg);
                }
            }

            return _list.OrderBy(o => o.SequenceNo).ToList();
        }

        /// <summary>
        /// Validates the components of a value's position descriptor
        /// </summary>
        /// <returns>A boolean indicating whether all the components are valid or not</returns>
        private bool validateValueFormat(List<string> allComponents)
        {
            string segNameRegEx = "[A-Z][A-Z][A-Z1-9]";
            string otherRegEx = @"^[1-9]([0-9]{1,2})?$";
            bool isValid = false;

            if (allComponents.Count > 0)
            {
                if (Regex.IsMatch(allComponents[0], segNameRegEx))
                {
                    for (int i = 1; i < allComponents.Count; i++)
                    {
                        if (Regex.IsMatch(allComponents[i], otherRegEx))
                            isValid = true;
                        else
                            return false;
                    }
                }
                else
                {
                    isValid = false;
                }
            }

            return isValid;
        }
    }
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **MessageElement.cs:**
    
```
/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public abstract class MessageElement
    {
        protected string _value = string.Empty;
       
        
        public  string Value 
        { 
            get 
            {
                return _value == Encoding.PresentButNull ? null : _value; 
            }
            set 
            { 
                _value = value; 
                ProcessValue(); 
            }
        }

        public HL7Encoding Encoding { get; protected set; }

        protected abstract void ProcessValue();
    }
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **MessageHelper.cs:**
    
```
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public static class MessageHelper
    {
        private static string[] lineSeparators = { "\r\n", "\n\r", "\r", "\n" };

        public static List<string> SplitString(string strStringToSplit, string splitBy, StringSplitOptions splitOptions = StringSplitOptions.None)
        {
            return strStringToSplit.Split(new string[] { splitBy }, splitOptions).ToList();
        }

        public static List<string> SplitString(string strStringToSplit, char chSplitBy, StringSplitOptions splitOptions = StringSplitOptions.None)
        {
            return strStringToSplit.Split(new char[] { chSplitBy }, splitOptions).ToList();
        }

        public static List<string> SplitString(string strStringToSplit, char[] chSplitBy, StringSplitOptions splitOptions = StringSplitOptions.None)
        {
            return strStringToSplit.Split(chSplitBy, splitOptions).ToList();
        }

        public static List<string> SplitMessage(string message)
        {
            return message.Split(lineSeparators, StringSplitOptions.None).Where(m => !string.IsNullOrWhiteSpace(m)).ToList();
        }

        public static string LongDateWithFractionOfSecond(DateTime dt)
        {
            return dt.ToString("yyyyMMddHHmmss.FFFF");
        }

        public static string[] ExtractMessages(string messages)
        {
            var expr = "\x0B(.*?)\x1C\x0D";
            var matches = Regex.Matches(messages, expr, RegexOptions.Singleline);

            var list = new List<string>();
            foreach (Match m in matches)
                list.Add(m.Groups[1].Value);

            return list.ToArray();
        }

        public static DateTime? ParseDateTime(string dateTimeString, bool throwExeption = false)
        {
            return ParseDateTime(dateTimeString, out TimeSpan offset, throwExeption);
        }

        public static DateTime? ParseDateTime(string dateTimeString, out TimeSpan offset, bool throwExeption = false)
        {
            var expr = @"^\s*((?:19|20)[0-9]{2})(?:(1[0-2]|0[1-9])(?:(3[0-1]|[1-2][0-9]|0[1-9])(?:([0-1][0-9]|2[0-3])(?:([0-5][0-9])(?:([0-5][0-9](?:\.[0-9]{1,4})?)?)?)?)?)?)?(?:([+-][0-1][0-9]|[+-]2[0-3])([0-5][0-9]))?\s*$";
            var matches = Regex.Matches(dateTimeString, expr, RegexOptions.Singleline);

            try
            {
                if (matches.Count != 1)
                    throw new FormatException("Invalid date format");

                var groups = matches[0].Groups;
                int year = int.Parse(groups[1].Value);
                int month = groups[2].Success ? int.Parse(groups[2].Value) : 1;
                int day = groups[3].Success ? int.Parse(groups[3].Value) : 1;
                int hours = groups[4].Success ? int.Parse(groups[4].Value) : 0;
                int mins = groups[5].Success ? int.Parse(groups[5].Value) : 0;

                float fsecs = groups[6].Success ? float.Parse(groups[6].Value) : 0;
                int secs = (int)Math.Truncate(fsecs);
                int msecs = (int)Math.Truncate(fsecs * 1000) % 1000;

                int tzh = groups[7].Success ? int.Parse(groups[7].Value) : 0;
                int tzm = groups[8].Success ? int.Parse(groups[8].Value) : 0;
                offset = new TimeSpan(tzh, tzm, 0);

                return new DateTime(year, month, day, hours, mins, secs, msecs);
            }
            catch
            {
                if (throwExeption)
                    throw;

                offset = new TimeSpan();

                return null;
            }
        }

        /// <summary>
        /// Serialize string to MLLP escaped byte array
        /// </summary>
        /// <param name="message">String to serialize</param>
        /// <param name="encoding">Text encoder (optional)</param>
        /// <returns>MLLP escaped byte array</returns>
        public static byte[] GetMLLP(string message, Encoding encoding = null)
        {
            if (encoding == null)
                encoding = Encoding.UTF8;
            
            byte[] data = encoding.GetBytes(message);
            byte[] buffer = new byte[data.Length + 3];
            buffer[0] = 11;//VT

            Array.Copy(data, 0, buffer, 1, data.Length);
            buffer[buffer.Length - 2] = 28;//FS
            buffer[buffer.Length - 1] = 13;//CR

            return buffer;
        }
    }
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **Segment.cs:**
    
```
using System;
using System.Collections.Generic;

/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public class Segment : MessageElement
    {
        internal FieldCollection FieldList { get; set; }
        internal short SequenceNo { get; set; }
                
        public string Name { get; set; }

        public Segment(HL7Encoding encoding)
        {
            this.FieldList = new FieldCollection();
            this.Encoding = encoding;
        }

        public Segment(string name, HL7Encoding encoding)
        {
            this.FieldList = new FieldCollection();
            this.Name = name;
            this.Encoding = encoding;
        }

        protected override void ProcessValue()
        {
            List<string> allFields = MessageHelper.SplitString(_value, this.Encoding.FieldDelimiter);

            if (allFields.Count > 1)
            {
                allFields.RemoveAt(0);
            }
            
            for (int i = 0; i < allFields.Count; i++)
            {
                string strField = allFields[i];
                Field field = new Field(this.Encoding);   

                if (Name == "MSH" && i == 0)
                    field.IsDelimiters = true;  // special case

                field.Value = strField;
                this.FieldList.Add(field);
            }

            if (this.Name == "MSH")
            {
                var field1 = new Field(this.Encoding);
                field1.IsDelimiters = true;
                field1.Value = this.Encoding.FieldDelimiter.ToString();

                this.FieldList.Insert(0,field1);
            }
        }

        public Segment DeepCopy()
        {
            var newSegment = new Segment(this.Name, this.Encoding);
            newSegment.Value = this.Value; 

            return newSegment;        
        }

        public void AddEmptyField()
        {
            this.AddNewField(string.Empty);
        }

        public void AddNewField(string content, int position = -1)
        {
            this.AddNewField(new Field(content, this.Encoding), position);
        }

        public void AddNewField(string content, bool isDelimiters)
        {
            var newField = new Field(this.Encoding);

            if (isDelimiters)
                newField.IsDelimiters = true;   // Prevent decoding

            newField.Value = content;
            this.AddNewField(newField, -1);
        }

        public bool AddNewField(Field field, int position = -1)
        {
            try
            {
                if (position < 0)
                {
                    this.FieldList.Add(field);
                }
                else 
                {
                    position = position - 1;
                    this.FieldList.Add(field, position);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Unable to add new field in segment " + this.Name + " Error - " + ex.Message);
            }
        }

        public Field Fields(int position)
        {
            position = position - 1;
            Field field = null;

            try
            {
                field = this.FieldList[position];
            }
            catch (Exception ex)
            {
                throw new HL7Exception("Field not available Error - " + ex.Message);
            }

            return field;
        }

        public List<Field> GetAllFields()
        {
            return this.FieldList;
        }
    }
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **SubComponent.cs:**
    
```
/// <summary>
/// https://github.com/Efferent-Health/HL7-dotnetcore
/// </summary>
namespace HL7.Dotnetcore
{
    public class SubComponent : MessageElement
    {
        public SubComponent(string val, HL7Encoding encoding)
        {
            this.Encoding = encoding;
            this.Value = val;
        }

        protected override void ProcessValue()
        {
            
        }
    }
}

```

<!-- code block end -->