From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000987]: new chipset
Date: Sat, 28 May 2005 12:20:52 +0200
Message-ID: <b231030ab8506f1a0dde54c88ad5fe1f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0F4D214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:21:02 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=987> 
======================================================================
Reported By:                mitchix
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   987
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               debian useing pure64 sid
Kernel Version:             2.6.10-9-amd64-k8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-12-2005 22:49 CET
Last Modified:              05-28-2005 12:20 CEST
======================================================================
Summary:                    new chipset
Description: 
Vendor 1462: Micro-Star International Co., Ltd.
Card model K8N Neo4 Platinum/SLI

On Board Audio
 	
Creative sound Bluster Live 24-bit H/W audio
24-bit / 96KHz audio quality
100db SNR clarity
Up to 7.1 CH Surround Sound, Dolby Digital ready

modprobe snd_ca0106
Model 1009 Rev 00000000 Serial 10091462


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000901 The onboard audigyls chip on msi k8 dia...
======================================================================

----------------------------------------------------------------------
 mitchix - 03-12-05 22:55 
----------------------------------------------------------------------
Sorry this is Dup of 901

----------------------------------------------------------------------
 jcdutton - 03-19-05 18:19 
----------------------------------------------------------------------
Fixed in 1.0.9

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 22:49 mitchix        New Issue                                    
03-12-05 22:49 mitchix        Distribution              => debian useing pure64
sid
03-12-05 22:49 mitchix        Kernel Version            => 2.6.10-9-amd64-k8
03-12-05 22:55 mitchix        Note Added: 0003899                          
03-19-05 18:17 jcdutton       Relationship added       duplicate of 0000901
03-19-05 18:19 jcdutton       Duplicate ID             0 => 901            
03-19-05 18:19 jcdutton       Status                   assigned => resolved
03-19-05 18:19 jcdutton       Resolution               open => fixed       
03-19-05 18:19 jcdutton       Note Added: 0004061                          
05-28-05 12:20 jcdutton       Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
