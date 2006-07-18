From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000335]: No support for Soundfont 2.1
	modulators
Date: Tue, 18 Jul 2006 14:46:51 +0200
Message-ID: <5689f06547c9c2efbc9f27b48f19ece8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AC2AFCA
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:46:51 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=335> 
======================================================================
Reported By:                meneerdik
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   335
Category:                   PCI - emu10k1
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-15-2004 12:57 CEST
Last Modified:              07-18-2006 14:46 CEST
======================================================================
Summary:                    No support for Soundfont 2.1 modulators
Description: 
Most of my soundfonts are unusable on Linux because the modulator
definitions in the fonts are not used by the driver. For example, when the
soundfont contains a modulator definition that routes the Expression
controller to the cutoff frequency of a particular instument zone, ALSA
ignores it completely. 
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 20:55 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-04 12:57 meneerdik      New Issue                                    
04-07-05 20:55 jdthood        Note Added: 0004364                          
07-18-06 14:46 jcdutton       Status                   new => assigned     
07-18-06 14:46 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
