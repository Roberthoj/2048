﻿<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="Azure_DevDay" generation="1" functional="0" release="0" Id="b577c3b2-ecf0-483d-8461-5307b1723dd4" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="Azure_DevDayGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="WebRole1:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/Azure_DevDay/Azure_DevDayGroup/LB:WebRole1:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="WebRole1:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Azure_DevDay/Azure_DevDayGroup/MapWebRole1:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="WebRole1Instances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/Azure_DevDay/Azure_DevDayGroup/MapWebRole1Instances" />
          </maps>
        </aCS>
        <aCS name="WorkerRole1:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Azure_DevDay/Azure_DevDayGroup/MapWorkerRole1:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRole1Instances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/Azure_DevDay/Azure_DevDayGroup/MapWorkerRole1Instances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:WebRole1:Endpoint1">
          <toPorts>
            <inPortMoniker name="/Azure_DevDay/Azure_DevDayGroup/WebRole1/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapWebRole1:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Azure_DevDay/Azure_DevDayGroup/WebRole1/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapWebRole1Instances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/Azure_DevDay/Azure_DevDayGroup/WebRole1Instances" />
          </setting>
        </map>
        <map name="MapWorkerRole1:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Azure_DevDay/Azure_DevDayGroup/WorkerRole1/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRole1Instances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/Azure_DevDay/Azure_DevDayGroup/WorkerRole1Instances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="WebRole1" generation="1" functional="0" release="0" software="C:\Users\JUNIOR RODRIGUEZ\Desktop\archivos\Azure DevDay\Azure DevDay\csx\Release\roles\WebRole1" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WebRole1&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WebRole1&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRole1&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/Azure_DevDay/Azure_DevDayGroup/WebRole1Instances" />
            <sCSPolicyUpdateDomainMoniker name="/Azure_DevDay/Azure_DevDayGroup/WebRole1UpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/Azure_DevDay/Azure_DevDayGroup/WebRole1FaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="WorkerRole1" generation="1" functional="0" release="0" software="C:\Users\JUNIOR RODRIGUEZ\Desktop\archivos\Azure DevDay\Azure DevDay\csx\Release\roles\WorkerRole1" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WorkerRole1&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WebRole1&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRole1&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/Azure_DevDay/Azure_DevDayGroup/WorkerRole1Instances" />
            <sCSPolicyUpdateDomainMoniker name="/Azure_DevDay/Azure_DevDayGroup/WorkerRole1UpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/Azure_DevDay/Azure_DevDayGroup/WorkerRole1FaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="WebRole1UpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="WorkerRole1UpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="WebRole1FaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="WorkerRole1FaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="WebRole1Instances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="WorkerRole1Instances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="799dcb22-2e60-4a0a-9747-7446352da7b2" ref="Microsoft.RedDog.Contract\ServiceContract\Azure_DevDayContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="12b78cf6-0de2-41da-8665-95cdf67a6773" ref="Microsoft.RedDog.Contract\Interface\WebRole1:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/Azure_DevDay/Azure_DevDayGroup/WebRole1:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>