dotnet
{

    assembly("mscorlib")
    {

        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        Version = '4.0.0.0';

        type("System.String"; "String") { }
        type("System.IO.FileAccess"; "FileAccess") { }
       //  type(System.uri; uri) { }

    }
    assembly(mscorlib)
    {
        type(System.DateTime; MyDateTime) { }   //DATETIME
        type(System.Environment; env) { }
        type(System.Reflection.Assembly; assembly) { }
        type(System.IO.Path; path) { }
       
        //type(System.IO.FileAccess; FileAccess) { }

    }
    assembly("System")
    {

        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        Version = '4.0.0.0';

        type("System.ComponentModel.PropertyChangedEventArgs"; "PropertyChangedEventArgs") { }
        type("System.ComponentModel.PropertyChangingEventArgs"; "PropertyChangingEventArgs") { }
        type("System.ComponentModel.ListChangedEventArgs"; "ListChangedEventArgs") { }
        type("System.ComponentModel.AddingNewEventArgs"; "AddingNewEventArgs") { }
        type("System.Collections.Specialized.NotifyCollectionChangedEventArgs"; "NotifyCollectionChangedEventArgs") { }
    }
    assembly("System.Xml")
    {

        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        Version = '4.0.0.0';

        type("System.Xml.XmlDocument"; "XmlDocument") { }
        type("System.Xml.XmlNode"; "XmlNode") { }
        type("System.Xml.XmlNodeList"; "XmlNodeList") { }
        type("System.Xml.XmlNamedNodeMap"; "XmlNamedNodeMap") { }
    }



}
