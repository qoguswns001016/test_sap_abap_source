sap.ui.define(["sap/base/util/ObjectPath","sap/ushell/services/Container"],function(e){"use strict";e.set(["sap-ushell-config"],{defaultRenderer:"fiori2",bootstrapPlugins:{RuntimeAuthoringPlugin:{component:"sap.ushell.plugins.rta",config:{validateAppVers+
ion:false}},PersonalizePlugin:{component:"sap.ushell.plugins.rta-personalize",config:{validateAppVersion:false}}},renderers:{fiori2:{componentData:{config:{enableSearch:false,rootIntent:"Shell-home"}}}},services:{LaunchPage:{adapter:{config:{groups:[{til+
es:[{tileType:"sap.ushell.ui.tile.StaticTile",properties:{title:"navi01",targetURL:"#syncnavi01-display"}}]}]}}},ClientSideTargetResolution:{adapter:{config:{inbounds:{"syncnavi01-display":{semanticObject:"syncnavi01",action:"display",description:"A Fior+
i application.",title:"navi01",signature:{parameters:{}},resolutionResult:{applicationType:"SAPUI5",additionalInformation:"SAPUI5.Component=sync.navi01",url:sap.ui.require.toUrl("sync/navi01")}}}}}},NavTargetResolution:{config:{enableClientSideTargetReso+
lution:true}}}});var i={init:function(){if(!this._oBootstrapFinished){this._oBootstrapFinished=sap.ushell.bootstrap("local");this._oBootstrapFinished.then(function(){sap.ushell.Container.createRenderer().placeAt("content")})}return this._oBootstrapFinish+
ed}};return i});                                                                                                                                                                                                                                               