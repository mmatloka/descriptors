<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xdd="http://org.jboss/shrinkwrap" exclude-result-prefixes="xs" version="2.0">

<!--    <xsl:include href="xdd-printBase.xsl"/>-->

    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    <!-- ****** Single    Elements ********************************* -->
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->

    <!-- *********************************************************** -->
    <!-- ****** Function which prints complex types unbounded    *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printComplexTypeSingleXX">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:value-of select=" xdd:printGetOrCreateSingleXX($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
        <xsl:value-of select=" xdd:printRemoveSingleXX($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
    </xsl:function>

    <!-- *********************************************************** -->
    <!-- ****** Function which writes the printGetOrCreateXX    *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetOrCreateSingleXX">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vStandardGetComplexSingleSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' getOrCreate', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:variable name="vinterfaceClass" select="substring-before($pElementType, '&lt;')"/>
        <xsl:variable name="vConstructor" select="concat(substring-before($pElementType, '&lt;'), 'Impl&lt;', $pClassType, '&gt;')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * If not already created, a new &lt;code&gt;', $pElementName,'&lt;/code&gt; element with the given value will be created.&#10;')"/>
        <xsl:value-of select="concat('    * Otherwise, the existing &lt;code&gt;', $pElementName,'&lt;/code&gt; element will be returned.&#10;')"/>
        <xsl:value-of select="concat('    * @return ', ' a new or existing instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vStandardGetComplexSingleSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vStandardGetComplexSingleSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      Node node = ', $pNodeNameLocal, '.getOrCreate(&quot;', $pElementName, '&quot;);',  '&#10;')"/>
                <xsl:value-of select="concat('      ', xdd:createPascalizedName($pElementType,''), ' ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' = new ', $vConstructor, '(this, &quot;', $pElementName, '&quot;, ', $pNodeNameLocal, ', node);', '&#10;')"/>
                <xsl:value-of select="concat('      return ', xdd:createCamelizedName($pElementName), ';&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- *********************************************************** -->
    <!-- ****** Function which writes the printRemoveXX         *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printRemoveSingleXX">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vRemoveXXSignature" select="concat('   public ', $pClassType, ' remove', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes the &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pClassType, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vRemoveXXSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vRemoveXXSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.removeChildren(&quot;', $pElementName, '&quot;', ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    <!-- ****** Unbounded Elements ********************************* -->
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->


    <!-- *********************************************************** -->
    <!-- ****** ENTRY FUNCTION - prints complex types unbounded  *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printComplexTypeUnboundedXX">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:value-of select=" xdd:printGetOrCreateXX($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
        <xsl:value-of select=" xdd:printCreateXX($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
        <xsl:value-of select=" xdd:printGetAllXX($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
        <xsl:value-of select=" xdd:printRemoveAllXX($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the printCreateXX          *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printCreateXX">
        <xsl:param name="vClassType"/>
        <xsl:param name="vElementType"/>
        <xsl:param name="vMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Creates a new &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the new created instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>

        <xsl:variable name="vStandardCreateSignature" select="concat('public ', xdd:createPascalizedName($vElementType,''), ' create', xdd:checkForClassType($vMethodName), '()')"/>
        <xsl:variable name="vConstructor" select="concat(substring-before($vElementType, '&lt;'), 'Impl&lt;', $vClassType, '&gt;')"/>

        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vStandardCreateSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vStandardCreateSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return new ', $vConstructor, '(this, &quot;', $pElementName, '&quot;, ', $pNodeNameLocal, ');', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the printGetOrCreateXX     *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetOrCreateXX">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vStandardCreateSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' getOrCreate', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:variable name="vConstructor" select="concat(substring-before($pElementType, '&lt;'), 'Impl&lt;', $pClassType, '&gt;')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * If not already created, a new &lt;code&gt;', $pElementName,'&lt;/code&gt; element will be created and returned.&#10;')"/>
        <xsl:value-of select="concat('    * Otherwise, the first existing &lt;code&gt;', $pElementName,'&lt;/code&gt; element will be returned.&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the instance defined for the element &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vStandardCreateSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vStandardCreateSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      List', '&lt;', 'Node', '&gt;', ' nodeList = ', $pNodeNameLocal , '.get(&quot;', $pElementName, '&quot;);', '&#10;')"/>
                <xsl:value-of select="concat('      if (nodeList != null', ' &amp;&amp; ', ' nodeList.size() &gt; 1)', '&#10;')"/>
                <xsl:value-of select="concat('      {', '&#10;')"/>
                <xsl:value-of select="concat('         return new ', $vConstructor, '(this, &quot;', $pElementName, '&quot;, ', $pNodeNameLocal, ', nodeList.get(0));', '&#10;')"/>
                <xsl:value-of select="concat('      }', '&#10;')"/>
                <xsl:value-of select="concat('      return create', xdd:checkForClassType($pMethodName), '();', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes getAllXX                   *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetAllXX">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vStandardGetAllXXSignature" select="concat('public List&lt;', xdd:createPascalizedName($pElementType,''), '&gt; getAll', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:variable name="vinterfaceClass" select="substring-before($pElementType, '&lt;')"/>
        <xsl:variable name="vConstructor" select="concat($vinterfaceClass, '&lt;', $pClassType, '&gt;')"/>
        <xsl:variable name="vConstructorImpl" select="concat($vinterfaceClass, 'Impl&lt;', $pClassType, '&gt;')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns all &lt;code&gt;', $pElementName, '&lt;/code&gt; elements&#10;')"/>
        <xsl:value-of select="concat('    * @return list of &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select=" concat('   ', $vStandardGetAllXXSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vStandardGetAllXXSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      List', '&lt;', $vConstructor, '&gt;', ' list = new ArrayList', '&lt;', $vConstructor, '&gt;', '();', '&#10;')"/>
                <xsl:value-of select="concat('      List', '&lt;', 'Node', '&gt;', ' nodeList = ', $pNodeNameLocal , '.get(&quot;', $pElementName, '&quot;);', '&#10;')"/>
                <xsl:value-of select="concat('      for(Node node: nodeList)', '&#10;')"/>
                <xsl:value-of select="concat('      {', '&#10;')"/>
                <xsl:value-of select="concat('         ', $vConstructor, '  type = new ', $vConstructorImpl, '(this, &quot;', $pElementName, '&quot;, ', $pNodeNameLocal, ', node);', '&#10;')"/>
                <xsl:value-of select="concat('         list.add(type);', '&#10;')"/>
                <xsl:value-of select="concat('      }', '&#10;')"/>
                <xsl:value-of select="concat('      return list;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the printRemoveAllXX       *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printRemoveAllXX">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes all &lt;code&gt;', $pElementName,'&lt;/code&gt; elements &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:variable name="vStandardRemoveAllSignature" select="concat('public ', $pClassType, ' removeAll', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vStandardRemoveAllSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vStandardRemoveAllSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.removeChildren(&quot;', $pElementName, '&quot;', ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    <!-- ****** Body Text          ********************************* -->
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->


    <!-- *********************************************************** -->
    <!-- ****** ENTRY FUNCTION - prints body text                *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printBodyText">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:param name="pIsEnum" as="xs:boolean"/>
        <xsl:value-of select="xdd:printSetBodyText($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
        <xsl:value-of select="xdd:printGetBodyText($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
    </xsl:function>


    <!-- ************************************************************* -->
    <!-- ****** Function which writes the set Body Text            *** -->
    <!-- ************************************************************* -->
    <xsl:function name="xdd:printSetBodyText">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetBodyTextSignature" select="concat('   public ', $pClassType, ' text(String value)')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the body text for the element &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @param ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' the value for the body text &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetBodyTextSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetBodyTextSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.text(value);', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Get Body Text          *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetBodyText">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' getText()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the body text of the element &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value defined for the text &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ',$vGetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return ', $pNodeNameLocal, '.getText();' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    <!-- ****** Attributes         ********************************* -->
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    
    <!-- *********************************************************** -->
    <!-- ****** ENTRY FUNCTION - prints attributes               *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printAttributes">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:param name="pIsEnum" as="xs:boolean"/>
        <xsl:choose>
            <xsl:when test="$pIsEnum=true()">
                <xsl:value-of select="xdd:printSetAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printSetEnumAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printRemoveAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:when>
            <xsl:when test="$pElementType='Boolean'">
                <xsl:value-of select="xdd:printSetAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetBooleanAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printRemoveAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:when>
            <xsl:when test="$pElementType='Integer'">
                <xsl:value-of select="xdd:printSetAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetIntegerAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printRemoveAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="xdd:printSetAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printRemoveAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- ************************************************************* -->
    <!-- ****** Function which writes the AttributeBody            *** -->
    <!-- ************************************************************* -->
    <xsl:function name="xdd:printSetAttribute">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetAttributeSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(',  xdd:createPascalizedName($pElementType,''),' ',xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ')')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the &lt;code&gt;', $pElementName,'&lt;/code&gt; attribute&#10;')"/>
        <xsl:value-of select="concat('    * @param ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' the value for the attribute &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetAttributeSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetAttributeSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.attribute(&quot;', $pElementName, '&quot;, ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- ************************************************************* -->
    <!-- ****** Function which writes the AttributeBody            *** -->
    <!-- ************************************************************* -->
    <xsl:function name="xdd:printSetEnumAttribute">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetAttributeSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(String', ' ',xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ')')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the &lt;code&gt;', $pElementName,'&lt;/code&gt; attribute&#10;')"/>
        <xsl:value-of select="concat('    * @param ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' the value for the attribute &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetAttributeSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetAttributeSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.attribute(&quot;', $pElementName, '&quot;, ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Getbbb Attribute  Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetAttribute">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetSignature" select="concat('   public ', xdd:createPascalizedName($pElementType,''), ' get', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; attribute&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value defined for the attribute &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vGetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return ', $pNodeNameLocal, '.getAttribute(&quot;', $pElementName, '&quot;);' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Getbbb Attribute  Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetEnumAttribute">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' get', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; attribute&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value defined for the attribute &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vGetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return ', xdd:createPascalizedName($pElementType,''), '.getFromStringValue(', $pNodeNameLocal, '.getAttribute(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the GetOrCreate       Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetEnumAttributeAsString">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetStringSignature" select="concat('public String ', ' get', xdd:checkForClassType($pMethodName), 'AsString()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; attribute&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value found for the element &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vGetStringSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetStringSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return ', $pNodeNameLocal, '.getAttribute(&quot;', $pElementName, '&quot;);' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Getbooleab Attribute   *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetBooleanAttribute">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetBooleanSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' is', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; attribute&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value defined for the attribute &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vGetBooleanSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetBooleanSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return Strings.isTrue(', $pNodeNameLocal, '.getAttribute(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Getbooleab Attribute   *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetIntegerAttribute">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetBooleanSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' get', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; attribute&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value defined for the attribute &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vGetBooleanSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetBooleanSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      if(', $pNodeNameLocal, '.getAttribute(&quot;', $pElementName, '&quot;) != null &amp;&amp; !', $pNodeNameLocal, '.getAttribute(&quot;', $pElementName, '&quot;).equals(&quot;null&quot;))' , '&#10;')"/>
                <xsl:value-of select="concat('      {', '&#10;')"/>
                <xsl:value-of select="concat('         return Integer.valueOf(', $pNodeNameLocal, '.getAttribute(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                <xsl:value-of select="concat('      }', '&#10;')"/>
                <xsl:value-of select="concat('      return null;' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Remove Attribute  Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printRemoveAttribute">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vRemoveSignature" select="concat('   public ', $pClassType, ' remove', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes the &lt;code&gt;', $pElementName,'&lt;/code&gt; attribute &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vRemoveSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vRemoveSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.removeAttribute(&quot;', $pElementName, '&quot;', ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    <!-- ****** Enums              ********************************* -->
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->


    <!-- *********************************************************** -->
    <!-- ****** ENTRY FUNCTION - prints enums                    *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printEnums">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:param name="pIsEnum" as="xs:boolean"/>
        <xsl:param name="pIsAttribute" as="xs:boolean"/>
        <xsl:choose>
            <xsl:when test="$pIsAttribute=true()">
                <xsl:value-of select="xdd:printSetAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printSetEnumAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetEnumAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetEnumAttributeAsString($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printRemoveAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="xdd:printSetEnum($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printSetEnumAsString($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetEnum($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printGetEnumAsString($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printRemoveAttribute($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- ****** Function which writes the GetOrCreate       Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printSetEnum">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(',  xdd:createPascalizedName($pElementType,''),' ',xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ')')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the &lt;code&gt;', $pElementName,'&lt;/code&gt; element&#10;')"/>
        <xsl:value-of select="concat('    * @param ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' the value for the element &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.getOrCreate(&quot;', $pElementName, '&quot;).text(', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the GetOrCreate       Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printSetEnumAsString">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetStringSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(String', ' ',xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ')')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the &lt;code&gt;', $pElementName,'&lt;/code&gt; element&#10;')"/>
        <xsl:value-of select="concat('    * @param ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' the value for the element &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetStringSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetStringSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.getOrCreate(&quot;', $pElementName, '&quot;).text(', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- *********************************************************** -->
    <!-- ****** Function which writes the GetOrCreate       Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetEnum">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' get', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; element&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value found for the element &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vGetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return ', xdd:createPascalizedName($pElementType,''), '.getFromStringValue(', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- ****** Function which writes the GetOrCreate       Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetEnumAsString">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetStringSignature" select="concat('public String ', ' get', xdd:checkForClassType($pMethodName), 'AsString()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; element&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the value found for the element &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vGetStringSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('   ', $vGetStringSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return ', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;);' , '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    <!-- ****** Simple Data types  ********************************* -->
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->


    <!-- *********************************************************** -->
    <!-- ****** ENTRY FUNCTION - prints DataType                 *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:param name="pIsUnbounded" as="xs:boolean"/>
        <xsl:choose>
            <xsl:when test="$pIsUnbounded = true()">
                <xsl:value-of select=" xdd:printSetVarArgUnboundedDataType($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select=" xdd:printGetUnboundedDataType($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select=" xdd:printRemoveUnboundedDataType($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$pElementType='java.util.Date'">
                        <xsl:value-of select="xdd:printSetSingleXmlDate($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="xdd:printSetSingleDataType($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="xdd:printGetSingleDataType($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
                <xsl:value-of select="xdd:printRemoveSingleDataType($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the GetOrCreate       Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printSetSingleDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(',  xdd:createPascalizedName($pElementType,''),' ',xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ')')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the &lt;code&gt;', $pElementName,'&lt;/code&gt; element&#10;')"/>
        <xsl:value-of select="concat('    * @param ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' the value for the element &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.getOrCreate(&quot;', $pElementName, '&quot;).text(', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the GetOrCreateXMLDateBody *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printSetSingleXmlDate">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(',  xdd:createPascalizedName($pElementType,''),' ',xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ')')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the &lt;code&gt;', $pElementName,'&lt;/code&gt; element&#10;')"/>
        <xsl:value-of select="concat('    * @param ', xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ' the value for the element &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      if (', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , ' != null)', '&#10;')"/>
                <xsl:value-of select="concat('      {', '&#10;')"/>
                <xsl:value-of select="concat('         ', $pNodeNameLocal, '.getOrCreate(&quot;', $pElementName, '&quot;).text(XMLDate.toXMLFormat(', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , '));', '&#10;')"/>
                <xsl:value-of select="concat('         return this;', '&#10;')"/>
                <xsl:value-of select="concat('      }', '&#10;')"/>
                <xsl:value-of select="concat('      return null;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the printGetDataType       *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetSingleDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vStandardGetSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' get', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:variable name="vStandardGetStringSignature" select="concat('public String ', ' get', xdd:checkForClassType($pMethodName), 'AsString()')"/>
        <xsl:variable name="vStandardGetBooleanSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' is', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:variable name="vStandardGetComplexSignature" select="concat('public ', xdd:createPascalizedName($pElementType,''), ' ', xdd:checkForClassType( xdd:LowerCaseFirstChar($pMethodName)), '()')"/>
        <xsl:variable name="vStandardGetListSignature" select="concat('public List&lt;', xdd:createPascalizedName($pElementType,''), '&gt; getAll', xdd:checkForClassType($pMethodName), '()')"/>

        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:choose>
                    <xsl:when test="$pElementType='Boolean'">
                        <xsl:value-of select="xdd:writeStandardGetElementJavaDoc($pElementType, $pElementName)"/>
                        <xsl:value-of select=" concat('   ', $vStandardGetBooleanSignature, ';&#10;')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="xdd:writeStandardGetElementJavaDoc($pElementType, $pElementName)"/>
                        <xsl:value-of select=" concat('   ', $vStandardGetSignature, ';&#10;')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$pElementType='Boolean'">
                        <xsl:value-of select="xdd:writeStandardGetElementJavaDoc($pElementType, $pElementName)"/>
                        <xsl:value-of select="concat('   ', $vStandardGetBooleanSignature, '&#10;')"/>
                        <xsl:value-of select="concat('   {', '&#10;')"/>
                        <xsl:value-of select="concat('      return Strings.isTrue(', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                        <xsl:value-of select="concat('   }', '&#10;')"/>
                    </xsl:when>
                    <xsl:when test="$pElementType='Integer'">
                        <xsl:value-of select="xdd:writeStandardGetElementJavaDoc($pElementType, $pElementName)"/>
                        <xsl:value-of select="concat('   ', $vStandardGetSignature, '&#10;')"/>
                        <xsl:value-of select="concat('   {', '&#10;')"/>
                        <xsl:value-of select="concat('      if (', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;) != null &amp;&amp; !', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;).equals(&quot;null&quot;)) {' , '&#10;')"/>
                        <xsl:value-of select="concat('         return Integer.valueOf(', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                        <xsl:value-of select="concat('      }' , '&#10;')"/>
                        <xsl:value-of select="concat('      return null;' , '&#10;')"/>
                        <xsl:value-of select="concat('   }', '&#10;')"/>
                    </xsl:when>
                    <xsl:when test="$pElementType='Long'">
                        <xsl:value-of select="xdd:writeStandardGetElementJavaDoc($pElementType, $pElementName)"/>
                        <xsl:value-of select="concat('   ', $vStandardGetSignature, '&#10;')"/>
                        <xsl:value-of select="concat('   {', '&#10;')"/>
                        <xsl:value-of select="concat('      if (', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;) != null &amp;&amp; !', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;).equals(&quot;null&quot;)) {' , '&#10;')"/>
                        <xsl:value-of select="concat('         return Long.valueOf(', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                        <xsl:value-of select="concat('      }' , '&#10;')"/>
                        <xsl:value-of select="concat('      return null;' , '&#10;')"/>
                        <xsl:value-of select="concat('   }', '&#10;')"/>
                    </xsl:when>
                    <xsl:when test="$pElementType='java.util.Date'">
                        <xsl:value-of select="xdd:writeStandardGetElementJavaDoc($pElementType, $pElementName)"/>
                        <xsl:value-of select="concat('   ', $vStandardGetSignature, '&#10;')"/>
                        <xsl:value-of select="concat('   {', '&#10;')"/>
                        <xsl:value-of select="concat('      if (', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;) != null) {' , '&#10;')"/>
                        <xsl:value-of select="concat('         return XMLDate.toDate(', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;));' , '&#10;')"/>
                        <xsl:value-of select="concat('      }' , '&#10;')"/>
                        <xsl:value-of select="concat('      return null;' , '&#10;')"/>
                        <xsl:value-of select="concat('   }', '&#10;')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="xdd:writeStandardGetElementJavaDoc($pElementType, $pElementName)"/>
                        <xsl:value-of select="concat('   ', $vStandardGetSignature, '&#10;')"/>
                        <xsl:value-of select="concat('   {', '&#10;')"/>
                        <xsl:value-of select="concat('      return ', $pNodeNameLocal, '.getTextValueForPatternName(&quot;', $pElementName, '&quot;);' , '&#10;')"/>
                        <xsl:value-of select="concat('   }', '&#10;')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Remove            Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printRemoveSingleDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vRemoveSignature" select="concat('   public ', $pClassType, ' remove', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes the &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vRemoveSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vRemoveSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.removeChildren(&quot;', $pElementName, '&quot;', ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Create Node  Body      *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printSetUnboundedDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vStandardSetSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(',  xdd:createPascalizedName($pElementType,''),' ',xdd:checkForClassType(xdd:createCamelizedName($pElementName)), ')')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Creates a new &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vStandardSetSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vStandardSetSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.createChild(&quot;', $pElementName, '&quot;).text(', xdd:checkForClassType(xdd:createCamelizedName($pElementName)) , ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the SetVarArgBody          *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printSetVarArgUnboundedDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetVarArgSignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType(xdd:LowerCaseFirstChar($pMethodName)), '(',  xdd:createPascalizedName($pElementType,''),' ... values)')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Creates for all ', $pElementType, ' objects representing &lt;code&gt;', $pElementName,'&lt;/code&gt; elements, &#10;')"/>
        <xsl:value-of select="concat('    * a new &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @param ', 'values', ' list of &lt;code&gt;', $pElementName,'&lt;/code&gt; objects &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetVarArgSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetVarArgSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      if (values != null)', '&#10;')"/>
                <xsl:value-of select="concat('      {', '&#10;')"/>
                <xsl:value-of select="concat('         for(', xdd:createPascalizedName($pElementType,''), ' name: values)', '&#10;')"/>
                <xsl:value-of select="concat('         {', '&#10;')"/>
                <xsl:value-of select="concat('            ', $pNodeNameLocal, '.createChild(&quot;', $pElementName, '&quot;).text(name);', '&#10;')"/>
                <xsl:value-of select="concat('         }', '&#10;')"/>
                <xsl:value-of select="concat('      }', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>



    <!-- *********************************************************************** -->
    <!-- ****** Function which writes the GetBodyForSimpleDataTypeUnbounded  *** -->
    <!-- *********************************************************************** -->
    <xsl:function name="xdd:printGetUnboundedDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetListSignature" select="concat('public List&lt;', xdd:createPascalizedName($pElementType,''), '&gt; getAll', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:variable name="vValueOf" select=" xdd:writeGetValueOf($pElementType, $pElementName)"/>
        <xsl:variable name="vValueOfDataType" select=" xdd:writeGetValueOfDataType($pElementType)"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns all &lt;code&gt;', $pElementName, '&lt;/code&gt; elements&#10;')"/>
        <xsl:value-of select="concat('    * @return list of &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat('   ', $vGetListSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vGetListSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      List&lt;', $vValueOfDataType, '&gt; result = new ArrayList&lt;', $vValueOfDataType, '&gt;();', '&#10;')"/>
                <xsl:value-of select="concat('      List&lt;Node&gt; nodes = ', $pNodeNameLocal, '.get(&quot;', $pElementName, '&quot;);', '&#10;')"/>
                <xsl:value-of select="concat('      for (Node node : nodes)', '&#10;')"/>
                <xsl:value-of select="concat('      {', '&#10;')"/>
                <xsl:value-of select="concat('         ', $vValueOf, '&#10;')"/>
                <xsl:value-of select="concat('      }', '&#10;')"/>
                <xsl:value-of select="concat('      return result;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Remove            Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printRemoveUnboundedDataType">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vRemoveAllSignature" select="concat('   public ', $pClassType, ' removeAll', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes the &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vRemoveAllSignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vRemoveAllSignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.removeChildren(&quot;', $pElementName, '&quot;', ');', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- *********************************************************** -->
    <!-- *********************************************************** -->
    <!-- ****** Empty boolean      ********************************* -->
    <!-- *********************************************************** -->
    <!-- *********************************************************** -->


    <!-- *********************************************************** -->
    <!-- ****** ENTRY FUNCTION - prints enums                    *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printEmptyBoolean">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <!--<xsl:value-of select="xdd:writeTypeCommentLines($pElementName, true(), true(), true(), false())"/>-->
        <xsl:value-of select=" xdd:printSetEmptyBoolean($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
        <xsl:value-of select=" xdd:printGetEmptyBoolean($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
        <xsl:value-of select=" xdd:printRemoveEmptyBoolean($pClassType, $pElementType, $pMethodName, $pNodeNameLocal, $pElementName, $pReturnTypeName, $pIsInterface)"/>
    </xsl:function>

    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Remove            Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printSetEmptyBoolean">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vSetBooleanEmptySignature" select="concat('   public ', $pClassType, ' ', xdd:checkForClassType( xdd:LowerCaseFirstChar($pMethodName)), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Sets the &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vSetBooleanEmptySignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vSetBooleanEmptySignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.getOrCreate(&quot;', $pElementName, '&quot;);', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Remove            Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printGetEmptyBoolean">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vGetBooleanEmptySignature" select="concat('   public Boolean is', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes the &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vGetBooleanEmptySignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vGetBooleanEmptySignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      return ', $pNodeNameLocal, '.getSingle(&quot;', $pElementName, '&quot;) != null;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- *********************************************************** -->
    <!-- ****** Function which writes the Remove            Body *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:printRemoveEmptyBoolean">
        <xsl:param name="pClassType"/>
        <xsl:param name="pElementType"/>
        <xsl:param name="pMethodName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pReturnTypeName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:variable name="vRemoveBooleanEmptySignature" select="concat('   public ', $pClassType, ' remove', xdd:checkForClassType($pMethodName), '()')"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes the &lt;code&gt;', $pElementName,'&lt;/code&gt; element &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnTypeName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:choose>
            <xsl:when test="$pIsInterface=true()">
                <xsl:value-of select="concat($vRemoveBooleanEmptySignature, ';&#10;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($vRemoveBooleanEmptySignature, '&#10;')"/>
                <xsl:value-of select="concat('   {', '&#10;')"/>
                <xsl:value-of select="concat('      ', $pNodeNameLocal, '.removeChild(&quot;', $pElementName, '&quot;);', '&#10;')"/>
                <xsl:value-of select="concat('      return this;', '&#10;')"/>
                <xsl:value-of select="concat('   }', '&#10;')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
      <!-- ****************************************************** -->
    <!-- ****** Function which writes the package line   ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writePackageLine">
        <xsl:param name="pPackage"/>
        <xsl:text>package </xsl:text><xsl:value-of select="$pPackage"/>; <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:function>
    
    
    <!-- ****************************************************** -->
    <!-- ****** Function which writes the imports           *** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeImports">
        <xsl:param name="vIsApi" as="xs:boolean"/>
        <xsl:choose>
            <xsl:when test="$vIsApi=true()">
                <xsl:value-of select="'import java.util.ArrayList;&#10;'"/>
                <xsl:value-of select="'import java.util.List;&#10;'"/>
                <xsl:value-of select="'import java.util.Map;&#10;'"/>
                <xsl:value-of select="'import org.jboss.shrinkwrap.descriptor.api.Child;&#10;'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'import org.jboss.shrinkwrap.descriptor.impl.base.XMLDate;&#10;'"/>
                <xsl:value-of select="'import org.jboss.shrinkwrap.descriptor.impl.base.Strings;&#10;'"/>
                <xsl:value-of select="'import org.jboss.shrinkwrap.descriptor.api.DescriptorExporter;&#10;'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
        <!-- *********************************************************************** -->
    <!-- ****** Function which writes the GetBodyForSimpleDataTypeUnbounded  *** -->
    <!-- *********************************************************************** -->
    <xsl:function name="xdd:writeStandardGetElementJavaDoc">
        <xsl:param name="pElementType"/>
        <xsl:param name="pElementName"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns the &lt;code&gt;', $pElementName, '&lt;/code&gt; element&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the node defined for the element &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
    </xsl:function>


    <!-- *********************************************************************** -->
    <!-- ****** Function which writes the writeStandardGetComplexTypeJavaDoc *** -->
    <!-- *********************************************************************** -->
    <xsl:function name="xdd:writeStandardGetComplexTypeJavaDoc">
        <xsl:param name="pElementType"/>
        <xsl:param name="pElementName"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * If not already created, a new &lt;code&gt;', $pElementName,'&lt;/code&gt; element will be created and returned.&#10;')"/>
        <xsl:value-of select="concat('    * Otherwise, the existing &lt;code&gt;', $pElementName,'&lt;/code&gt; element will be returned.&#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the node defined for the element &lt;code&gt;', $pElementName, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
    </xsl:function>


    <!-- *********************************************************************** -->
    <!-- ****** Function which writes the GetBodyForSimpleDataTypeUnbounded  *** -->
    <!-- *********************************************************************** -->
    <xsl:function name="xdd:writeStandardGetAllElementJavaDoc">
        <xsl:param name="pElementType"/>
        <xsl:param name="pElementName"/>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns all &lt;code&gt;', $pElementName, '&lt;/code&gt; elements&#10;')"/>
        <xsl:value-of select="concat('    * @return list of &lt;code&gt;', $pElementName,'&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
    </xsl:function> 


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the package line   ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeDescriptorImplConstructor">
        <xsl:param name="pClassName"/>
        <xsl:param name="pAppDescription"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
        <xsl:text>   // Constructor &#10;</xsl:text>
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="concat('   public ', $pClassName, '(String descriptorName)')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>   {</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:variable name="nodeExtractor" select="concat('NodeInfoExtractor.getNodeInfo(', $pClassName, '.class)')"/>
        <xsl:value-of select="concat('       this(descriptorName, new Node(&quot;', $pAppDescription , '&quot;));')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>   }&#10;&#10;</xsl:text>
        <xsl:value-of select="concat('   public ', $pClassName, '(String descriptorName, Node node)')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:text>      super(descriptorName);&#10;</xsl:text>
        <xsl:value-of select="concat('      this.', $pNodeNameLocal, ' = node;&#10;')"/>
        <xsl:text>      addDefaultNamespaces();&#10;</xsl:text>
        <xsl:text>   }&#10;&#10;</xsl:text>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the package line   ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeImplClassConstructor">
        <xsl:param name="pClassName"/>
        <xsl:param name="pNodeName"/>
        <xsl:param name="pNodeNameLocal"/>
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
        <xsl:text>   // Constructor &#10;</xsl:text>
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="concat('   public ', $pClassName, '(T t, String nodeName, Node node)'&#10;)"/>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:text>      this.t = t;&#10;</xsl:text>
        <!--        <xsl:text>      this.node = node;&#10;</xsl:text>-->
        <xsl:value-of select="concat('      this.', $pNodeNameLocal ,' = node.createChild(', $pNodeName,');&#10;')"/>
        <xsl:text>   }&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>

        <xsl:value-of select="concat('   public ', $pClassName, '(T t, String nodeName, Node node, Node childNode)'&#10;)"/>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:text>      this.t = t;&#10;</xsl:text>
        <!--        <xsl:text>      this.node = node;&#10;</xsl:text>-->
        <xsl:value-of select="concat('      this.', $pNodeNameLocal ,' = childNode;&#10;')"/>
        <xsl:text>   }&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>

    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the method line    ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeMethodComment">
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
        <xsl:text>   // Methods &#10;</xsl:text>
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes a set method          *** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeTypeCommentLines">
        <xsl:param name="pClassName" as="xs:string"/>
        <xsl:param name="pElementName" as="xs:string"/>
        <xsl:param name="pElementType" as="xs:string"/>
        <xsl:param name="pMaxOccurs" as="xs:string"/>
        <xsl:param name="pWriteAttribute" as="xs:boolean"/>
        <xsl:param name="pWriteInterface" as="xs:boolean"/>
        <xsl:param name="pIsGeneric" as="xs:boolean"/>
        <xsl:param name="pNodeNameLocal" as="xs:string"/>
        <xsl:param name="pIsAttribute" as="xs:boolean"/>
        <xsl:param name="pIsEnum" as="xs:boolean"/>
        <xsl:param name="pIsDataType" as="xs:boolean"/>
        <xsl:value-of select="concat(' ', '&#10;')"/>
        <xsl:value-of select="concat('   // --------------------------------------------------------------------------------------------------------||', '&#10;')"/>
        <xsl:value-of select="concat('   // ClassName: ', $pClassName, ' ElementName: ', $pElementName ,' ElementType : ', $pElementType, '&#10;')"/>
        <xsl:value-of select="concat('   // MaxOccurs: ', $pMaxOccurs, '  isGeneric: ', $pIsGeneric, '   isAttribute: ', $pIsAttribute, ' isEnum: ', $pIsEnum, ' isDataType: ', $pIsDataType, '&#10;')"/>
        <xsl:value-of select="concat('   // --------------------------------------------------------------------------------------------------------||', '&#10;')"/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the Child interface ***** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeChildUp">
        <xsl:value-of select="'   public T up()&#10;'"/>
        <xsl:value-of select="'   {&#10;'"/>
        <xsl:value-of select="'      return t;&#10;'"/>
        <xsl:value-of select="'   }&#10;'"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the node provider methods -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeNodeProviderMethods">
        <xsl:param name="pNodeNameLocal"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>   public Node getRootNode()&#10;</xsl:text>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:value-of select="concat('      return ', $pNodeNameLocal, ';&#10;')"/>
        <xsl:text>   }&#10;&#10;</xsl:text>
    </xsl:function>

    <!-- ************************************************************ -->
    <!-- ****** Function which writes the DescriptorNamespace methods -->
    <!-- ************************************************************ -->
    <xsl:function name="xdd:writeDescriptorNamespaceMethods">
        <xsl:param name="pDefaultNamespaces"/>
        <xsl:param name="pReturnType"/>
        <xsl:text>&#10;&#10;</xsl:text>
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
        <xsl:text>   // Namespace &#10;</xsl:text>
        <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="concat('', '&#10;')"/>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Adds the default namespaces as defined in the specification',' &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnType, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:value-of select="concat('   public ', $pReturnType,' addDefaultNamespaces()', '&#10;')"/>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:for-each select="$pDefaultNamespaces/namespace">
            <xsl:value-of select="concat('      addNamespace(&quot;', @name, '&quot;, &quot;', @value, '&quot;)', ';&#10;')"/>
        </xsl:for-each>
        <xsl:value-of select="concat('     return this;', '&#10;')"/>
        <xsl:text>   }&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Adds a new namespace',' &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnType, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:value-of select="concat('   public ', $pReturnType,' addNamespace(String name, String value)', '&#10;')"/>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:value-of select="concat('      ', 'model', '.attribute(name, value);', '&#10;')"/>
        <xsl:value-of select="concat('      return this;', '&#10;')"/>
        <xsl:text>   }&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Returns all defined namespaces.',' &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'all defined namespaces', ' &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:text>   public List&lt;String&gt; getNamespaces()&#10;</xsl:text>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:value-of select="concat('      List&lt;String&gt; namespaceList = new ArrayList&lt;String&gt;();', '&#10;')"/>
        <xsl:value-of select="concat('      Map&lt;String, String&gt; attributes = model.getAttributes();', '&#10;')"/>
        <xsl:value-of select="concat('      for (String name: attributes.keySet())', '&#10;')"/>
        <xsl:value-of select="concat('      {', '&#10;')"/>
        <xsl:value-of select="concat('         String value = attributes.get(name);', '&#10;')"/>
        <xsl:value-of select="concat('         if (value != null &amp;&amp; value.startsWith(&quot;http://&quot;)) ', '&#10;')"/>
        <xsl:value-of select="concat('         {', '&#10;')"/>
        <xsl:value-of select="concat('            namespaceList.add(name + &quot;=&quot; + value);', '&#10;')"/>
        <xsl:value-of select="concat('         }', '&#10;')"/>
        <xsl:value-of select="concat('      }', '&#10;')"/>
        <xsl:value-of select="concat('      return namespaceList;', '&#10;')"/>
        <xsl:text>   }&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="concat('   /**', '&#10;')"/>
        <xsl:value-of select="concat('    * Removes all existing namespaces.',' &#10;')"/>
        <xsl:value-of select="concat('    * @return ', 'the current instance of &lt;code&gt;', $pReturnType, '&lt;/code&gt; &#10;')"/>
        <xsl:value-of select="concat('    */', '&#10;')"/>
        <xsl:value-of select="concat('   public ', $pReturnType,' removeAllNamespaces()', '&#10;')"/>
        <xsl:text>   {&#10;</xsl:text>
        <xsl:value-of select="concat('      List&lt;String&gt; nameSpaceKeys = new ArrayList&lt;String&gt;();', '&#10;')"/>
        <xsl:value-of select="concat('      Map&lt;String, String&gt; attributes = model.getAttributes();', '&#10;')"/>
        <xsl:value-of select="concat('      for (String name: attributes.keySet())', '&#10;')"/>
        <xsl:value-of select="concat('      {', '&#10;')"/>
        <xsl:value-of select="concat('         String value = attributes.get(name);', '&#10;')"/>
        <xsl:value-of select="concat('         if (value != null &amp;&amp; value.startsWith(&quot;http://&quot;)) ', '&#10;')"/>
        <xsl:value-of select="concat('         {', '&#10;')"/>
        <xsl:value-of select="concat('            nameSpaceKeys.add(name);', '&#10;')"/>
        <xsl:value-of select="concat('         }', '&#10;')"/>
        <xsl:value-of select="concat('      }', '&#10;')"/>
        <xsl:value-of select="concat('      for (String name: nameSpaceKeys)', '&#10;')"/>
        <xsl:value-of select="concat('      {', '&#10;')"/>
        <xsl:value-of select="concat('         model.removeAttribute(name);', '&#10;')"/>
        <xsl:value-of select="concat('      }', '&#10;')"/>
        <xsl:value-of select="concat('      return this;', '&#10;')"/>
        <xsl:text>   }&#10;</xsl:text>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the class header   ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeClassJavaDoc">
        <xsl:param name="pText"/>
        <xsl:param name="pElementName"/>
        <xsl:param name="pIsInterface" as="xs:boolean"/>
        <xsl:param name="pIsClassHeader" as="xs:boolean"/>
        <xsl:param name="pContributors"/>

        <xsl:value-of select="'/**&#10;'"/>
        <xsl:if test="$pIsClassHeader=true()">
            <xsl:choose>
                <xsl:when test="$pIsInterface=true()">
                    <xsl:value-of select="' * This interface defines the contract for the &lt;code&gt;', $pElementName ,'&lt;/code&gt; xsd type &#10;'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="' * This class implements the &lt;code&gt;', $pElementName ,'&lt;/code&gt; xsd type &#10;'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <xsl:if test="$pText!=''">
            <xsl:value-of select="' * &lt;p&gt; &#10;'"/>
            <xsl:value-of select="' * Original Documentation:&#10;'"/>
            <xsl:value-of select="' * &lt;p&gt; &#10;'"/>
            <xsl:for-each select=" tokenize($pText, '&#xA;')">
                <xsl:choose>
                    <xsl:when test="normalize-space(.) != ''">
                        <xsl:value-of select="concat(' * ', normalize-space(.), ' &lt;br&gt; &#10;')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="' *&lt;br&gt;&#10;'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:value-of select="' *&#10;'"/>
        </xsl:if>
        <xsl:value-of select="xdd:writeContributors($pContributors)"/>
        <xsl:value-of select="concat(' * @since Generation date :', current-dateTime(), '&#10;')"/>
        <xsl:value-of select="' */&#10;'"/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the class header   ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeDescriptorJavaDoc">
        <xsl:param name="pDescriptorName"/>
        <xsl:param name="pDescriptorSchema"/>
        <xsl:param name="pContributors"/>
        <xsl:value-of select="concat('/**',' &#10;')"/>
        <xsl:value-of select="concat(' * &lt;p&gt; ', '&#10;')"/>
        <xsl:value-of select="concat(' * This deployment descriptor provides the functionalities as described in the ', $pDescriptorSchema,' specification&#10;')"/>
        <xsl:value-of select="concat(' * &lt;p&gt;',' &#10;')"/>
        <xsl:value-of select="concat(' * Example:', '&#10;')"/>
        <xsl:value-of select="concat(' * &lt;p&gt;',' &#10;')"/>
        <xsl:value-of select="concat(' * &lt;code&gt;', ' &#10;')"/>
        <xsl:value-of select="concat(' *     ', $pDescriptorName, ' descriptor = Descriptors.create(', $pDescriptorName, '.class);', '&#10;')"/>
        <xsl:value-of select="concat(' * &lt;/code&gt;', ' &#10;')"/>
        <xsl:value-of select="concat(' *', '&#10;')"/>
        <xsl:value-of select="concat(' *', '&#10;')"/>
        <xsl:value-of select="xdd:writeContributors($pContributors)"/>
        <xsl:value-of select="concat(' * @since Generation date :', current-dateTime(), '&#10;')"/>
        <xsl:value-of select="concat(' */', '&#10;')"/>
    </xsl:function>
    
      <!-- ****************************************************** -->
    <!-- ****** Function which writes the class declaration *** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:classHeaderDeclaration">
        <xsl:param name="classType"/>
        <xsl:param name="className"/>
        <xsl:text>public </xsl:text>
        <xsl:value-of select="$classType"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="xdd:createPascalizedName($className, '')"/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which writes the class declaration *** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:classNodeInfo">
        <xsl:param name="pNodeName"/>
        <xsl:value-of select="concat('   @NodeInfo(xmlName=&quot;', $pNodeName, '&quot;)')"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:function>
    
    
    <!-- ****************************************************** -->
    <!-- ****** Function which writes the package line   ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeAttribute">
        <xsl:param name="pType"/>
        <xsl:param name="pName"/>
        <xsl:param name="pWithCommentHeader" as="xs:boolean"/>
        <xsl:if test="$pWithCommentHeader=true()">
            <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
            <xsl:text>   // Instance Members &#10;</xsl:text>
            <xsl:text>   // -------------------------------------------------------------------------------------||&#10;</xsl:text>
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:value-of select="concat('   private ', $pType, ' ', $pName, ';')"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:function>
    
    
    <!-- ****************************************************** -->
    <!-- ****** Function which writes the contributors   ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:writeContributors">
        <xsl:param name="pContributors"/>
        <xsl:for-each select="$pContributors/contributor">
            <xsl:choose>
                <xsl:when test="@mailto=''">
                    <xsl:value-of select="concat(' * &amp;author ', @name, '&#10;')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(' * @author &lt;a href=&quot;mailto:', @mailto, '&quot;&gt;', @name, '&lt;/a&gt;', '&#10;')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ******  Utility Functions **************************** -->
    <!-- ****************************************************** -->
    

    <!-- ****************************************************** -->
    <!-- ******  Function which generates a camel case string * -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:words-to-camel-case" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select=" 
            string-join((tokenize($arg,'\s+')[1],
            for $word in tokenize($arg,'\s+')[position() > 1]
            return xdd:capitalize-first($word))
            ,'')
            "/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ******  Function which capitalize tje first char     * -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:capitalize-first" as="xs:string?">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select=" 
            concat(upper-case(substring($arg,1,1)),
            substring($arg,2))
            "/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which creates a full path       ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:createPath" as="xs:string">
        <xsl:param name="path" as="xs:string"/>
        <xsl:param name="package" as="xs:string"/>
        <xsl:param name="filename" as="xs:string"/>
        <xsl:param name="extension" as="xs:string"/>
        <xsl:sequence select="concat($path, '/' , replace($package,'\.','/'), '/' , $filename, '.', $extension)"/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which creates a class name      ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:createPascalizedName">
        <xsl:param name="name"/>
        <xsl:param name="extension" as="xs:string"/>
        <xsl:variable name="retValue" select="xdd:normalizeString($name)"/>
        <xsl:variable name="retValue" select="xdd:words-to-camel-case($retValue)"/>
        <xsl:variable name="retValue" select="concat(upper-case(substring($retValue,1,1)), substring($retValue,2))"/>
        <xsl:variable name="retValue" select="xdd:stripNumbersFromString($retValue)"/>
        <xsl:choose>
            <xsl:when test=" starts-with($name, 'java.')">
                <xsl:sequence select="$name"/>
            </xsl:when>
            <xsl:when test="$extension!=''">
                <xsl:sequence select="concat($retValue, $extension)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$retValue"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="xdd:stripNumbersFromString">
      <xsl:param name="name" />
        <xsl:sequence
            select="
             if (contains($name, '0')) then
                   xdd:stripNumbersFromString(replace($name,'0',''))
             else if (contains($name, '1')) then
                   xdd:stripNumbersFromString(replace($name,'1',''))                   
             else if (contains($name, '2')) then
                   xdd:stripNumbersFromString(replace($name,'2',''))
             else if (contains($name, '3')) then
                   xdd:stripNumbersFromString(replace($name,'3',''))
             else if (contains($name, '4')) then
                   xdd:stripNumbersFromString(replace($name,'4',''))
             else if (contains($name, '5')) then
                   xdd:stripNumbersFromString(replace($name,'5',''))
             else if (contains($name, '6')) then
                   xdd:stripNumbersFromString(replace($name,'6',''))
             else if (contains($name, '7')) then
                   xdd:stripNumbersFromString(replace($name,'7',''))
             else if (contains($name, '8')) then
                   xdd:stripNumbersFromString(replace($name,'8',''))
             else if (contains($name, '9')) then
                   xdd:stripNumbersFromString(replace($name,'9',''))
             else
                 string($name)
        "
        />

    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which creates a type   name     ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:createCamelizedName">
        <xsl:param name="name"/>
        <xsl:sequence select="xdd:words-to-camel-case(xdd:normalizeString($name))"/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which creates a type   name     ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:LowerCaseFirstChar">
        <xsl:param name="name"/>
        <xsl:sequence select="concat(lower-case(substring($name,1,1)), substring($name,2))"/>
    </xsl:function>


    <!-- ****************************************************** -->
    <!-- ****** Function which normalizes a string       ****** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:normalizeString">
        <xsl:param name="name"/>
        <xsl:sequence
            select="
             if (contains($name, '/')) then
                   xdd:normalizeString(substring-after($name,'/'))
             else if (contains($name, ':')) then
                   xdd:normalizeString(substring-after($name,':'))                   
             else if (contains($name, '_')) then
                   xdd:normalizeString(replace($name,'_',' ')) 
             else if (contains($name, '-')) then
                   xdd:normalizeString(replace($name,'-',' '))    
             else if (contains($name,'.xsd')) then
                   xdd:normalizeString(substring-before($name, '.xsd'))
             else
                 string($name)
        "
        />
    </xsl:function>
    
    

    <!-- ****************************************************** -->
    <!-- ****** Function which returns a java data type     *** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:getJavaDataType" as="xs:string">
        <xsl:param name="pText" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="$pText='xsd:long'">
                <xsl:sequence select="'Long'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:decimal'">
                <xsl:sequence select="'String'"/>
                <!-- workaround -->
            </xsl:when>
            <xsl:when test="$pText='xsd:integer'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:int'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:string'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='xsdIntegerType'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:positiveInteger'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='positiveInteger'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='nonNegativeInteger'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:nonNegativeInteger'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='integer'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
             <xsl:when test="$pText='int'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pText='xsdStringType'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='string'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:QName'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:anyURI'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:NMTOKEN'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:NCName'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:token'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='nonEmptyStringType'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='xsdBooleanType'">
                <xsl:sequence select="'Boolean'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:boolean'">
                <xsl:sequence select="'Boolean'"/>
            </xsl:when>
            <xsl:when test="$pText='token'">
                <xsl:sequence select="'String'"/>
            </xsl:when>
            <xsl:when test="$pText='long'">
                <xsl:sequence select="'Long'"/>
            </xsl:when>
            <xsl:when test="$pText='xsd:dateTime'">
                <xsl:sequence select="'java.util.Date'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <!-- ****************************************************** -->
    <!-- ****** Function which checks for 'class' type      *** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:checkForClassType">
        <xsl:param name="vMethodName"/>
        <xsl:choose>
            <xsl:when test="$vMethodName='class'">
                <xsl:sequence select="'clazz'"/>
            </xsl:when>
            <xsl:when test="$vMethodName='Class'">
                <xsl:sequence select="'Clazz'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$vMethodName"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!---****************************************************** -->
    <!-- ****** Function which returns a classname          *** -->
    <!-- ****************************************************** -->
    <xsl:function name="xdd:getReturnType">
        <xsl:param name="pClassName" as="xs:string"/>
        <xsl:param name="pIsGeneric" as="xs:boolean"/>
        <xsl:choose>
            <xsl:when test="$pIsGeneric=true()">
                <xsl:sequence select="xdd:createPascalizedName($pClassName, '&lt;T&gt;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="xdd:createPascalizedName($pClassName, '')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    

    <!-- *********************************************************** -->
    <!-- ****** Function which returns correct valueof           *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:writeGetValueOfDataType">
        <xsl:param name="pElementType"/>
        <xsl:choose>
            <xsl:when test="$pElementType='Boolean'">
                <xsl:sequence select="'Boolean'"/>
            </xsl:when>
            <xsl:when test="$pElementType='Integer'">
                <xsl:sequence select="'Integer'"/>
            </xsl:when>
            <xsl:when test="$pElementType='Long'">
                <xsl:sequence select="'Long'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="'String'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- *********************************************************** -->
    <!-- ****** Function which returns correct valueof           *** -->
    <!-- *********************************************************** -->
    <xsl:function name="xdd:writeGetValueOf">
        <xsl:param name="pElementType"/>
        <xsl:param name="pElementName"/>
        <xsl:choose>
            <xsl:when test="$pElementType='Boolean'">
                <xsl:sequence select="'result.add(Boolean.valueOf(node.getText()));'"/>
            </xsl:when>
            <xsl:when test="$pElementType='Integer'">
                <xsl:sequence select="'result.add(Integer.valueOf(node.getText()));'"/>
            </xsl:when>
            <xsl:when test="$pElementType='Long'">
                <xsl:sequence select="'result.add(Long.valueOf(node.getText()));'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="'result.add(node.getText());'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
</xsl:stylesheet>
